import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/shops/models/shop.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shop Detail Page with workers list and map navigation
class ShopDetailScreen extends ConsumerStatefulWidget {
  final int shopId;

  const ShopDetailScreen({super.key, required this.shopId});

  @override
  ConsumerState<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends ConsumerState<ShopDetailScreen> {
  String? _statusFilter; // online|offline|busy|walk_in

  Future<void> _openMap(double lat, double lng, String shopName) async {
    // Using Yandex Maps (can be changed to Google Maps)
    final url = 'yandexmaps://maps.yandex.ru/?rtext=~$lat,$lng&rtt=auto';
    final fallbackUrl = 'https://yandex.ru/maps/?rtext=~$lat,$lng&rtt=auto';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(Uri.parse(fallbackUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Fallback: open in browser
      await launchUrl(Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication);
    }
  }

  Color _statusColor(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'online':
        return Colors.green;
      case 'busy':
        return Colors.orange;
      case 'walk_in':
        return Colors.purple;
      case 'offline':
      default:
        return Colors.grey;
    }
  }

  String _statusLabel(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'online':
        return 'Bo‘sh';
      case 'busy':
        return 'Band';
      case 'walk_in':
        return 'Walk-in';
      case 'offline':
      default:
        return 'Offline';
    }
  }

  Future<void> _openChat(Barber barber) async {
    try {
      final chat = await ref.read(chatServiceProvider).createOrGetChat(barber.id);
      if (!mounted) return;
      context.push('/chats/${chat.id}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open chat: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: FutureBuilder<Shop>(
        future: ref.read(shopServiceProvider).getShop(widget.shopId),
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
          if (!snapshot.hasData) {
            return const Center(child: Text('Shop not found'));
          }

          final shop = snapshot.data!;
          final barbersFuture = ref.read(shopServiceProvider).getShopBarbers(
                shopId: widget.shopId,
                status: _statusFilter,
              );
          return CustomScrollView(
            slivers: [
              // App bar
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: const Color(0xFF2196F3),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    shop.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF2196F3),
                          Color(0xFF1976D2),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.store,
                      size: 80,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),

              // Shop info section
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF2196F3)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              shop.address ?? 'Manzil ko\'rsatilmagan',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Phone
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Color(0xFF2196F3)),
                          const SizedBox(width: 8),
                          Text(
                            shop.phone,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF212121),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Go to Shop button (Map)
                      if (shop.locationLat != null && shop.locationLng != null)
                        ElevatedButton.icon(
                          onPressed: () => _openMap(
                            shop.locationLat!,
                            shop.locationLng!,
                            shop.name,
                          ),
                          icon: const Icon(Icons.directions),
                          label: const Text('Go to Shop'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2196F3),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Barbers section header
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Row(
                    children: [
                      const Text(
                        'Barbers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FutureBuilder<List<Barber>>(
                        future: barbersFuture,
                        builder: (context, s) {
                          final count = s.hasData ? s.data!.length : 0;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Status filter chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChoiceChip(
                          label: const Text('All'),
                          selected: _statusFilter == null,
                          onSelected: (_) => setState(() => _statusFilter = null),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Bo‘sh'),
                          selected: _statusFilter == 'online',
                          onSelected: (_) => setState(() => _statusFilter = 'online'),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Band'),
                          selected: _statusFilter == 'busy',
                          onSelected: (_) => setState(() => _statusFilter = 'busy'),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Walk-in'),
                          selected: _statusFilter == 'walk_in',
                          onSelected: (_) => setState(() => _statusFilter = 'walk_in'),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Offline'),
                          selected: _statusFilter == 'offline',
                          onSelected: (_) => setState(() => _statusFilter = 'offline'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Barbers list
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverToBoxAdapter(
                  child: FutureBuilder<List<Barber>>(
                    future: barbersFuture,
                    builder: (context, s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (s.hasError) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Center(child: Text('Error: ${s.error}')),
                        );
                      }
                      final barbers = s.data ?? const <Barber>[];
                      if (barbers.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(child: Text('No barbers available')),
                        );
                      }

                      return Column(
                        children: barbers.map((barber) {
                          final status = barber.scheduleStatus;
                          final statusColor = _statusColor(status);
                          final statusLabel = _statusLabel(status);

                          return InkWell(
                            onTap: () => context.push(
                              '/barbers/${barber.id}/book',
                              extra: barber,
                            ),
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2196F3),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      barber.name,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: statusColor.withOpacity(0.12),
                                                      borderRadius:
                                                          BorderRadius.circular(999),
                                                      border: Border.all(
                                                        color: statusColor.withOpacity(0.35),
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
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          statusLabel,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: statusColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (barber.phone != null &&
                                                  barber.phone!.isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    barber.phone!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFF757575),
                                                    ),
                                                  ),
                                                ),
                                              if (barber.ratingAvg != null)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 4),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: Colors.amber.shade700,
                                                          size: 16),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        barber.ratingAvg!
                                                            .toStringAsFixed(1),
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        if (barber.phone != null &&
                                            barber.phone!.isNotEmpty)
                                          IconButton(
                                            icon: const Icon(Icons.phone),
                                            color: const Color(0xFF2196F3),
                                            onPressed: () async {
                                              final url = 'tel:${barber.phone}';
                                              if (await canLaunchUrl(
                                                  Uri.parse(url))) {
                                                await launchUrl(Uri.parse(url));
                                              }
                                            },
                                          ),
                                        IconButton(
                                          icon: const Icon(Icons.chat_bubble_outline),
                                          color: const Color(0xFF2196F3),
                                          onPressed: () => _openChat(barber),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: () => context.push(
                                        '/barbers/${barber.id}/book',
                                        extra: barber,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2196F3),
                                        foregroundColor: Colors.white,
                                        minimumSize:
                                            const Size(double.infinity, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text('Book Appointment'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
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

