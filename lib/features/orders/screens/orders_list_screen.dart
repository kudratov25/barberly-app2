import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/common/utils/storage.dart';
import 'package:mobile/common/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/orders/models/client_timeline_item.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/shops/services/shop_service.dart';
import 'package:intl/intl.dart';

/// My Orders Page with badge and status filters
class OrdersListScreen extends ConsumerStatefulWidget {
  const OrdersListScreen({super.key});

  @override
  ConsumerState<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends ConsumerState<OrdersListScreen>
    with WidgetsBindingObserver {
  Future<PaginatedResponse<ClientTimelineItem>>? _timelineFuture;
  bool _isInitialized = false;
  bool _hasItems = false;
  DateTime? _lastRefreshTime;
  int? _lastSyncedWalkInCount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadTimeline();
    _isInitialized = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh when route becomes current (screen becomes visible)
    final route = ModalRoute.of(context);

    if (route != null && route.isCurrent && _isInitialized) {
      final now = DateTime.now();
      // Refresh if last refresh was more than 1 second ago (to avoid too many refreshes)
      if (_lastRefreshTime == null ||
          now.difference(_lastRefreshTime!).inSeconds > 1) {
        _lastRefreshTime = now;
        // Use postFrameCallback to avoid multiple refreshes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final currentRoute = ModalRoute.of(context);
            if (currentRoute != null && currentRoute.isCurrent) {
              _loadTimeline();
            }
          }
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh when app comes back to foreground
    if (state == AppLifecycleState.resumed && _isInitialized) {
      _loadTimeline();
    }
  }

  void _loadTimeline() {
    if (mounted) {
      setState(() {
        _timelineFuture = ref.read(orderServiceProvider).listClientTimeline();
      });
    }
  }

  Future<void> _refreshTimeline() async {
    _loadTimeline();
    // Wait for the future to complete
    if (_timelineFuture != null) {
      await _timelineFuture;
    }
  }

  Color _getStatusColor(String status) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF1E3A5F),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E3A5F)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF1E3A5F).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
        future: _timelineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E3A5F)),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            // Update hasItems flag
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _hasItems = false;
                });
              }
            });

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A5F).withOpacity(0.08),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1E3A5F).withOpacity(0.15),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.receipt_long_outlined,
                        size: 80,
                        color: Color(0xFF1E3A5F),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No bookings yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A5F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Make your first booking',
                      style: TextStyle(fontSize: 16, color: Color(0xFF424242)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await context.push('/shops');
                        // Refresh when returning from booking
                        if (mounted) {
                          // Reset last refresh time to force refresh
                          _lastRefreshTime = null;
                          // Small delay to ensure navigation is complete
                          await Future.delayed(
                            const Duration(milliseconds: 500),
                          );
                          _loadTimeline();
                        }
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'New Booking',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A5F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final items = snapshot.data!.data;

          // Mark all current walk-ins as "seen" whenever user views the bookings screen.
          // This ensures Home badge resets even when navigating here via BottomNavBar.
          final walkInCount = items.where((i) => i.isWalkIn).length;
          if (_lastSyncedWalkInCount != walkInCount) {
            _lastSyncedWalkInCount = walkInCount;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Storage.saveSeenWalkInCount(walkInCount);
            });
          }

          // Update hasItems flag
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _hasItems = items.isNotEmpty;
              });
            }
          });

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
            onRefresh: _refreshTimeline,
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
      floatingActionButton: _hasItems
          ? FloatingActionButton.extended(
              onPressed: () async {
                await context.push('/shops');
                // Refresh when returning from booking
                if (mounted) {
                  // Reset last refresh time to force refresh
                  _lastRefreshTime = null;
                  // Small delay to ensure navigation is complete
                  await Future.delayed(const Duration(milliseconds: 500));
                  _loadTimeline();
                }
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'New Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              backgroundColor: const Color(0xFF1E3A5F),
              elevation: 6,
            )
          : null,
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final Color statusColor;

  const _OrderCard({required this.order, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    DateTime? parseStartTime() {
      try {
        return DateTime.parse(order.startTime);
      } catch (_) {
        return null;
      }
    }

    final startDateTime = parseStartTime();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color(0xFF1E3A5F).withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () => context.push('/orders/${order.id}'),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E3A5F).withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: statusColor.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        order.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Date and time
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A5F).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF1E3A5F).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C4B77).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF2C4B77),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        startDateTime != null
                            ? DateFormat('MMM dd, yyyy').format(startDateTime)
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E3A5F),
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.access_time,
                          size: 18,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        startDateTime != null
                            ? DateFormat('HH:mm').format(startDateTime)
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E3A5F),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Barber name
                if (order.barber != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A5F).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A5F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 18,
                            color: Color(0xFF1E3A5F),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          order.barber!.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                // Divider
                Divider(
                  color: const Color(0xFF1E3A5F).withOpacity(0.1),
                  height: 1,
                  thickness: 1,
                ),

                const SizedBox(height: 14),

                // Price and actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF424242),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${order.price} UZS',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A5F),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A5F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF1E3A5F).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              size: 22,
                              color: Color(0xFF1E3A5F),
                            ),
                            onPressed: () => context.push('/chats'),
                            padding: const EdgeInsets.all(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A5F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF1E3A5F).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF1E3A5F),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WalkInCard extends StatelessWidget {
  final ClientTimelineItem item;
  final Color statusColor;

  const _WalkInCard({required this.item, required this.statusColor});

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
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color(0xFF1E3A5F).withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () => context.push('/walkin/${walkIn.id}'),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E3A5F).withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: statusColor.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        walkIn.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A5F).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF1E3A5F).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A5F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        startDateTime != null
                            ? DateFormat('MMM dd, yyyy').format(startDateTime)
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A5F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.access_time,
                          size: 18,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        startDateTime != null
                            ? DateFormat('HH:mm').format(startDateTime)
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A5F).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A5F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 18,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          walkIn.barber?.name ?? 'Barber',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Divider(
                  color: const Color(0xFF1E3A5F).withOpacity(0.1),
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF424242),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${(walkIn.price ?? 0)} UZS',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A5F),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A5F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF1E3A5F).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF1E3A5F),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
