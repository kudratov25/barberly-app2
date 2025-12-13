import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/common/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/orders/models/client_timeline_item.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/shops/services/shop_service.dart';
import 'package:intl/intl.dart';

/// My Orders Page with badge and status filters
class OrdersListScreen extends ConsumerWidget {
  const OrdersListScreen({super.key});

  int _countNewItems(List<ClientTimelineItem> items) {
    return items.where((item) {
      final s = item.status.toLowerCase();
      return s == 'pending' || s == 'in_progress' || s == 'started';
    }).length;
  }

  Color _getStatusColor(String status) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
            future: ref.read(orderServiceProvider).listClientTimeline(),
            builder: (context, snapshot) {
              final newCount =
                  snapshot.hasData ? _countNewItems(snapshot.data!.data) : 0;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Badge(
                  label: Text('$newCount'),
                  isLabelVisible: newCount > 0,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
        future: ref.read(orderServiceProvider).listClientTimeline(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No orders yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Book your first appointment',
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/shops'),
                    icon: const Icon(Icons.add),
                    label: const Text('New Booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final items = snapshot.data!.data;
          
          // Sort by sort_time DESC (newest first)
          final sortedItems = List<ClientTimelineItem>.from(items);
          sortedItems.sort((a, b) {
            DateTime? aTime;
            DateTime? bTime;
            try {
              if (a.sortTime != null) aTime = DateTime.parse(a.sortTime!);
            } catch (_) {}
            try {
              if (b.sortTime != null) bTime = DateTime.parse(b.sortTime!);
            } catch (_) {}
            if (aTime != null && bTime != null) return bTime.compareTo(aTime);
            if (aTime != null) return -1;
            if (bTime != null) return 1;
            return 0;
          });
          
          return RefreshIndicator(
            onRefresh: () async {
              // Trigger rebuild
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sortedItems.length,
              itemBuilder: (context, index) {
                final item = sortedItems[index];
                if (item.isWalkIn) {
                  return _WalkInCard(
                    item: item,
                    statusColor: _getStatusColor(item.status),
                  );
                }
                return _OrderCard(
                  order: item.order!,
                  statusColor: _getStatusColor(item.status),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/shops'),
        icon: const Icon(Icons.add),
        label: const Text('New Booking'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final Color statusColor;

  const _OrderCard({
    required this.order,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? _parseStartTime() {
      try {
        return DateTime.parse(order.startTime);
      } catch (_) {
        return null;
      }
    }

    final startDateTime = _parseStartTime();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/orders/${order.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order.service?.name ?? 'Service',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Date and time
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    startDateTime != null
                        ? DateFormat('MMM dd, yyyy').format(startDateTime)
                        : 'N/A',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    startDateTime != null
                        ? DateFormat('HH:mm').format(startDateTime)
                        : 'N/A',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Barber name
              if (order.barber != null)
                Row(
                  children: [
                    Icon(Icons.person,
                        size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      order.barber!.name,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              
              const SizedBox(height: 12),
              
              // Price and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.price} UZS',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline,
                            size: 20),
                        onPressed: () => context.push('/chats'),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFE3F2FD),
                          foregroundColor: const Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right,
                          color: Color(0xFF757575)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalkInCard extends StatelessWidget {
  final ClientTimelineItem item;
  final Color statusColor;

  const _WalkInCard({
    required this.item,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final walkIn = item.walkIn!;

    DateTime? startDateTime;
    try {
      if (walkIn.startedAt != null) {
        startDateTime = DateTime.parse(walkIn.startedAt!);
      }
    } catch (_) {}

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/walkin/${walkIn.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Walk-in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      walkIn.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    startDateTime != null
                        ? DateFormat('MMM dd, yyyy').format(startDateTime)
                        : 'N/A',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    startDateTime != null
                        ? DateFormat('HH:mm').format(startDateTime)
                        : 'N/A',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.person,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      walkIn.barber?.name ?? 'Barber',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(walkIn.price ?? 0)} UZS',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0xFF757575)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

