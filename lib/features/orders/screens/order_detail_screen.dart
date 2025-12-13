import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:intl/intl.dart';

/// Order detail screen
class OrderDetailScreen extends ConsumerWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'in_progress':
        return 'In progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  DateTime? _tryParse(String? s) {
    if (s == null) return null;
    try {
      return DateTime.parse(s);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: FutureBuilder<Order>(
        future: ref.read(orderServiceProvider).getOrder(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Order not found'));
          }

          final order = snapshot.data!;
          final statusColor = _statusColor(order.status);
          final start = _tryParse(order.startTime);
          final end = _tryParse(order.endTime);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 160,
                backgroundColor: const Color(0xFF2196F3),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Order #${order.id}'),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2196F3),
                          Color(0xFF1976D2),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 56),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _statusLabel(order.status),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${order.price} UZS',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _InfoCard(
                        title: 'Appointment',
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.calendar_today,
                              label: 'Date',
                              value: start != null
                                  ? DateFormat('MMM dd, yyyy').format(start)
                                  : order.startTime,
                            ),
                            const SizedBox(height: 10),
                            _InfoRow(
                              icon: Icons.access_time,
                              label: 'Time',
                              value: start != null
                                  ? DateFormat('HH:mm').format(start)
                                  : '—',
                            ),
                            if (end != null) ...[
                              const SizedBox(height: 10),
                              _InfoRow(
                                icon: Icons.timelapse,
                                label: 'Ends',
                                value: DateFormat('HH:mm').format(end),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _InfoCard(
                        title: 'Details',
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.content_cut,
                              label: 'Service',
                              value: order.service?.name ?? '—',
                            ),
                            const SizedBox(height: 10),
                            _InfoRow(
                              icon: Icons.person,
                              label: 'Barber',
                              value: order.barber?.name ?? '—',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (order.status.toLowerCase() == 'pending')
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(orderServiceProvider)
                                  .cancelOrder(orderId);

                              // Send chat notification for cancel (client action)
                              try {
                                final chat = await ref
                                    .read(chatServiceProvider)
                                    .createOrGetChat(order.barberId);
                                final msg = [
                                  'Booking cancelled',
                                  'Order #${order.id}',
                                  if (start != null)
                                    'Date: ${DateFormat('yyyy-MM-dd').format(start)}',
                                  if (start != null)
                                    'Time: ${DateFormat('HH:mm').format(start)}',
                                  'Total: ${order.price} UZS',
                                ].join('\n');
                                await ref.read(chatServiceProvider).sendMessage(
                                      chatId: chat.id,
                                      message: msg,
                                      orderId: order.id,
                                    );
                              } catch (_) {}

                              if (context.mounted) context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Cancel Order'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF2196F3)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

