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
        return const Color(0xFFFF9800); // Orange
      case 'in_progress':
        return const Color(0xFF2196F3); // Blue
      case 'completed':
        return const Color(0xFF4CAF50); // Green
      case 'cancelled':
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF757575); // Grey
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Kutilmoqda';
      case 'in_progress':
        return 'Jarayonda';
      case 'completed':
        return 'Yakunlangan';
      case 'cancelled':
        return 'Bekor qilingan';
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
      backgroundColor: const Color(0xFFF5F7FA),
      body: FutureBuilder<Order>(
        future: ref.read(orderServiceProvider).getOrder(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2C4B77)),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF44336).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Color(0xFFF44336),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Xatolik yuz berdi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Color(0xFF757575)),
                  ),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Bron topilmadi',
                style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
              ),
            );
          }

          final order = snapshot.data!;
          final statusColor = _statusColor(order.status);
          final start = _tryParse(order.startTime);
          final end = _tryParse(order.endTime);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                backgroundColor: const Color(0xFF1E3A5F),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Bron #${order.id}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1E3A5F), Color(0xFF2C4B77)],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 70),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: statusColor.withOpacity(0.5),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    _statusLabel(order.status),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${order.price} UZS',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
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
                        title: 'Vaqt',
                        icon: Icons.calendar_today,
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.calendar_today,
                              label: 'Sana',
                              value: start != null
                                  ? DateFormat('MMM dd, yyyy').format(start)
                                  : order.startTime,
                            ),
                            const SizedBox(height: 16),
                            _InfoRow(
                              icon: Icons.access_time,
                              label: 'Boshlanish vaqti',
                              value: start != null
                                  ? DateFormat('HH:mm').format(start)
                                  : '—',
                            ),
                            if (end != null) ...[
                              const SizedBox(height: 16),
                              _InfoRow(
                                icon: Icons.timelapse,
                                label: 'Tugash vaqti',
                                value: DateFormat('HH:mm').format(end),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InfoCard(
                        title: 'Ma\'lumotlar',
                        icon: Icons.info_outline,
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.content_cut,
                              label: 'Xizmat',
                              value: order.service?.name ?? '—',
                            ),
                            const SizedBox(height: 16),
                            _InfoRow(
                              icon: Icons.person,
                              label: 'Barber',
                              value: order.barber?.name ?? '—',
                            ),
                            if ((order.barber?.phone ?? '')
                                .trim()
                                .isNotEmpty) ...[
                              const SizedBox(height: 16),
                              _InfoRow(
                                icon: Icons.phone,
                                label: 'Telefon',
                                value: order.barber!.phone!.trim(),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (order.status.toLowerCase() == 'pending')
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF44336).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
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
                                await ref
                                    .read(chatServiceProvider)
                                    .sendMessage(
                                      chatId: chat.id,
                                      message: msg,
                                      orderId: order.id,
                                    );
                              } catch (_) {}

                              if (context.mounted) context.pop();
                            },
                            icon: const Icon(Icons.cancel_outlined, size: 22),
                            label: const Text(
                              'Bronni bekor qilish',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF44336),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
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
  final IconData? icon;

  const _InfoCard({required this.title, required this.child, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A5F).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C4B77).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: const Color(0xFF2C4B77)),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1E3A5F),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF2196F3)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF1E3A5F),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
