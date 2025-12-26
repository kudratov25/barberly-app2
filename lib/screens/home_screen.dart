import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/common/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/orders/models/client_timeline_item.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Home Dashboard - Main screen with barber list and user info
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Barber>? _barbers;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData({String? searchQuery}) async {
    try {
      List<Barber> barbers;

      if (searchQuery != null && searchQuery.isNotEmpty) {
        // Search rejimida (lat/lngsiz)
        barbers = await ref
            .read(barberServiceProvider)
            .searchBarbers(searchQuery);
      } else {
        // Nearby rejimida (lat/lng bilan)
        // Get user location (you would use geolocator package in production)
        // For now, using sample coordinates
        const lat = 41.2995;
        const lng = 69.2401;

        barbers = await ref
            .read(barberServiceProvider)
            .getNearestBarbers(lat: lat, lng: lng);
      }

      setState(() {
        _barbers = barbers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(userAsync: userAsync, ref: ref),
                      const SizedBox(height: 16),
                      _NextAppointmentSection(ref: ref),
                      const SizedBox(height: 20),
                      _QuickActionsRow(),
                      const SizedBox(height: 24),
                      // Search bar
                      // TextField(
                      //   controller: _searchController,
                      //   onChanged: (query) {
                      //     _loadData(searchQuery: query);
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'Search barbers or shops...',
                      //     prefixIcon: const Icon(Icons.search),
                      //     suffixIcon: _searchController.text.isNotEmpty
                      //         ? IconButton(
                      //             icon: const Icon(Icons.clear),
                      //             onPressed: () {
                      //               _searchController.clear();
                      //               _loadData();
                      //             },
                      //           )
                      //         : null,
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //       horizontal: 20,
                      //       vertical: 12,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Popular barbers (horizontal)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Popular Barbers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error != null
                      ? Center(child: Text(_error!))
                      : (_barbers == null || _barbers!.isEmpty)
                      ? const Center(child: Text('No barbers found'))
                      : Builder(
                          builder: (context) {
                            final popularBarbers = [..._barbers!]
                              ..sort(
                                (a, b) => (b.ratingAvg ?? 0).compareTo(
                                  a.ratingAvg ?? 0,
                                ),
                              );
                            final count = popularBarbers.length > 10
                                ? 10
                                : popularBarbers.length;

                            return ListView.separated(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                12,
                                16,
                                24,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: count,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final barber = popularBarbers[index];
                                return _BarberHorizontalCard(barber: barber);
                              },
                            );
                          },
                        ),
                ),
              ),

              // Stats section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: const _StatsCard(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _BarberHorizontalCard extends StatelessWidget {
  final Barber barber;

  const _BarberHorizontalCard({required this.barber});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.06),
      child: InkWell(
        onTap: () => context.push('/barbers/${barber.id}/book'),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF2C4B77), Color(0xFF4DA8FF)],
                      ),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          barber.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(height: 3),
                        // Shop name
                        if (barber.shopName != null) ...[
                          Row(
                            children: [
                              const Icon(
                                Icons.store,
                                size: 12,
                                color: Color(0xFF757575),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  barber.shopName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                        ],
                        Row(
                          children: [
                            if (barber.ratingAvg != null) ...[
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Color(0xFFFFC107),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                barber.ratingAvg!.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: barber.scheduleStatus == 'online'
                                    ? Colors.green.shade50
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                barber.scheduleStatus == 'online'
                                    ? 'Online'
                                    : 'Offline',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: barber.scheduleStatus == 'online'
                                      ? Colors.green[700]
                                      : Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Shop barbers count
                        // if (barber.shopBarbersCount != null &&
                        //     barber.shopBarbersCount! > 0) ...[
                        //   const SizedBox(height: 4),
                        //   Row(
                        //     children: [
                        //       const Icon(
                        //         Icons.people,
                        //         size: 12,
                        //         color: Color(0xFF757575),
                        //       ),
                        //       const SizedBox(width: 4),
                        //       Text(
                        //         '${barber.shopBarbersCount} barber${barber.shopBarbersCount != 1 ? 's' : ''} in shop',
                        //         style: const TextStyle(
                        //           fontSize: 11,
                        //           color: Color(0xFF757575),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ],
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/barbers/${barber.id}/book'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: const Color(0xFF2C4B77),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text(
                    'Book',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final AsyncValue userAsync;
  final WidgetRef ref;

  const _Header({required this.userAsync, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF2C4B77), Color(0xFF4DA8FF)],
                ),
              ),
              child: userAsync.when(
                data: (user) => Center(
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : 'C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                loading: () => const SizedBox(),
                error: (_, __) =>
                    const Icon(Icons.person, color: Colors.white, size: 26),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userAsync.when(
                    data: (user) => Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    loading: () => const Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    error: (_, __) => const Text(
                      'Client',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Client',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
              future: ref.read(orderServiceProvider).listClientTimeline(),
              builder: (context, snapshot) {
                int newCount = 0;
                if (snapshot.hasData) {
                  newCount = snapshot.data!.data.where((item) {
                    final s = item.status.toLowerCase();
                    return s == 'pending' ||
                        s == 'in_progress' ||
                        s == 'started';
                  }).length;
                }
                return IconButton(
                  onPressed: () => context.push('/notifications'),
                  icon: Badge(
                    backgroundColor: Colors.red,
                    label: Text(
                      '$newCount',
                      style: const TextStyle(fontSize: 10),
                    ),
                    isLabelVisible: newCount > 0,
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      size: 26,
                      color: Color(0xFF111827),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        // Nearest upcoming booking in header
        FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
          future: ref.read(orderServiceProvider).listClientTimeline(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }

            if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
              return const SizedBox.shrink();
            }

            final now = DateTime.now();
            final upcomingOrders = snapshot.data!.data
                .where((item) => item.isOrder)
                .map((item) => item.order!)
                .where((order) {
                  // Only show pending or in_progress orders
                  final status = order.status.toLowerCase();
                  if (status != 'pending' && status != 'in_progress') {
                    return false;
                  }

                  // Check if start time is in the future
                  try {
                    final startTime = DateTime.parse(order.startTime);
                    return startTime.isAfter(now);
                  } catch (_) {
                    return false;
                  }
                })
                .toList();

            if (upcomingOrders.isEmpty) {
              return const SizedBox.shrink();
            }

            // Sort by start time ascending (nearest first)
            upcomingOrders.sort((a, b) {
              try {
                final aTime = DateTime.parse(a.startTime);
                final bTime = DateTime.parse(b.startTime);
                return aTime.compareTo(bTime);
              } catch (_) {
                return 0;
              }
            });

            final nearestOrder = upcomingOrders.first;
            DateTime? startDateTime;
            try {
              startDateTime = DateTime.parse(nearestOrder.startTime);
            } catch (_) {}

            return Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E3A5F), Color(0xFF2C4B77)],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E3A5F).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Yaqin booking',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            if (startDateTime != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  '${startDateTime.day.toString().padLeft(2, '0')}.${startDateTime.month.toString().padLeft(2, '0')}.${startDateTime.year}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  '${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ] else
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  nearestOrder.startTime,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            if (nearestOrder.barber?.name != null) ...[
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  '• ${nearestOrder.barber!.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () =>
                          context.push('/orders/${nearestOrder.id}'),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(9),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _NextAppointmentSection extends StatelessWidget {
  final WidgetRef ref;

  const _NextAppointmentSection({required this.ref});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
      future: ref.read(orderServiceProvider).listClientTimeline(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 96,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
          return _EmptyNextAppointmentCard();
        }

        // Find nearest upcoming booking (sorted by date and time)
        final now = DateTime.now();
        final upcomingOrders = snapshot.data!.data
            .where((item) => item.isOrder)
            .map((item) => item.order!)
            .where((order) {
              final status = order.status.toLowerCase();
              if (status != 'pending' && status != 'in_progress') {
                return false;
              }
              try {
                final startTime = DateTime.parse(order.startTime);
                return startTime.isAfter(now);
              } catch (_) {
                return false;
              }
            })
            .toList();

        if (upcomingOrders.isEmpty) {
          return _EmptyNextAppointmentCard();
        }

        // Sort by start time ascending (nearest first)
        upcomingOrders.sort((a, b) {
          try {
            final aTime = DateTime.parse(a.startTime);
            final bTime = DateTime.parse(b.startTime);
            return aTime.compareTo(bTime);
          } catch (_) {
            return 0;
          }
        });

        final nearestOrder = upcomingOrders.first;
        return _NextAppointmentCard(order: nearestOrder);
      },
    );
  }
}

class _NextAppointmentCard extends StatelessWidget {
  final Order order;

  const _NextAppointmentCard({required this.order});

  @override
  Widget build(BuildContext context) {
    DateTime? startDateTime;
    try {
      startDateTime = DateTime.parse(order.startTime);
    } catch (_) {}

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A5F), Color(0xFF2C4B77)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A5F).withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left border gradient
          Positioned.fill(
            left: 0,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1E3A5F), Color(0xFF2C4B77)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E3A5F).withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1E3A5F), Color(0xFF2C4B77)],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A5F).withOpacity(0.4),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.barber?.name ?? 'Yaqinlashayotgan bron',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          order.service?.name ?? 'Xizmat',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              startDateTime != null
                                  ? '${startDateTime.day.toString().padLeft(2, '0')}.${startDateTime.month.toString().padLeft(2, '0')}.${startDateTime.year}'
                                  : order.startTime.split(' ').first,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              startDateTime != null
                                  ? '${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')}'
                                  : order.startTime.split(' ').length > 1
                                  ? order.startTime.split(' ')[1]
                                  : '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (order.shop != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.store,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                order.shop!.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.5,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () => context.push('/orders/${order.id}'),
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyNextAppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF2C4B77).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xFF2C4B77),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You don't have any active bookings",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Book your next haircut in a few taps.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => context.push('/shops'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              backgroundColor: const Color(0xFF2C4B77),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends ConsumerWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
      future: ref.read(orderServiceProvider).listClientTimeline(perPage: 100),
      builder: (context, snapshot) {
        final items = snapshot.hasData
            ? snapshot.data!.data
            : <ClientTimelineItem>[];
        final walkInCount = items.where((i) => i.isWalkIn).length;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _QuickActionButton(
              icon: Icons.search,
              label: 'Search Barbers',
              route: '/shops',
            ),
            const _QuickActionButton(
              icon: Icons.store_mall_directory_outlined,
              label: 'Nearby Shops',
              route: '/shops',
            ),
            _QuickActionButton(
              icon: Icons.calendar_today_outlined,
              label: 'My Bookings',
              route: '/orders',
              badgeCount: walkInCount,
              badgeLabel: 'W',
            ),
          ],
        );
      },
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final int? badgeCount;
  final String? badgeLabel;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.route,
    this.badgeCount,
    this.badgeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.push(route),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60,
                  height: 60,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2C4B77),
                  ),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                if ((badgeCount ?? 0) > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        badgeLabel != null
                            ? '$badgeLabel ${badgeCount!}'
                            : '${badgeCount!}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends ConsumerWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<PaginatedResponse<ClientTimelineItem>>(
      future: ref.read(orderServiceProvider).listClientTimeline(perPage: 100),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final items = snapshot.hasData
            ? snapshot.data!.data
            : <ClientTimelineItem>[];
        final orders = items
            .where((i) => i.isOrder)
            .map((i) => i.order!)
            .toList();

        final totalOrders = items.length;
        final totalSpent = items.fold<int>(0, (sum, item) => sum + item.price);

        final serviceIds = <int>{};
        for (final order in orders) {
          if (order.service != null) {
            serviceIds.add(order.service!.id);
          }
        }
        final servicesUsed = serviceIds.length;

        String mostBookedBarber = '-';
        String mostUsedService = '-';
        int thisMonthBookings = 0;

        if (orders.isNotEmpty) {
          final barberCounts = <String, int>{};
          final serviceCounts = <String, int>{};
          final now = DateTime.now();

          for (final order in orders) {
            if (order.barber?.name != null) {
              final name = order.barber!.name;
              barberCounts[name] = (barberCounts[name] ?? 0) + 1;
            }
            if (order.service?.name != null) {
              final sName = order.service!.name;
              serviceCounts[sName] = (serviceCounts[sName] ?? 0) + 1;
            }

            try {
              final dt = DateTime.parse(order.startTime);
              if (dt.year == now.year && dt.month == now.month) {
                thisMonthBookings++;
              }
            } catch (_) {}
          }

          if (barberCounts.isNotEmpty) {
            mostBookedBarber = barberCounts.entries
                .reduce((a, b) => a.value >= b.value ? a : b)
                .key;
          }
          if (serviceCounts.isNotEmpty) {
            mostUsedService = serviceCounts.entries
                .reduce((a, b) => a.value >= b.value ? a : b)
                .key;
          }
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Stats',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatsItem(label: 'Total orders', value: '$totalOrders'),
                  const SizedBox(width: 16),
                  _StatsItem(label: 'Total spent', value: '${totalSpent} UZS'),
                  const SizedBox(width: 16),
                  _StatsItem(label: 'Services used', value: '$servicesUsed'),
                ],
              ),
              const SizedBox(height: 12),
              _StatsRowLabelValue(
                icon: Icons.person_outline,
                label: 'Most booked barber',
                value: mostBookedBarber,
              ),
              const SizedBox(height: 8),
              _StatsRowLabelValue(
                icon: Icons.content_cut,
                label: 'Most used service',
                value: mostUsedService,
              ),
              const SizedBox(height: 8),
              _StatsRowLabelValue(
                icon: Icons.bar_chart_outlined,
                label: "This month's activity",
                value: '$thisMonthBookings bookings',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatsItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatsItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C4B77),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRowLabelValue extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatsRowLabelValue({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6B7280)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

// Provider for current user
final currentUserProvider = FutureProvider((ref) async {
  return await ref.read(authServiceProvider).getCurrentUser();
});
