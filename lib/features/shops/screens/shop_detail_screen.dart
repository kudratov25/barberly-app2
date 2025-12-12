import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/shops/models/shop.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shop Detail Page with workers list and map navigation
class ShopDetailScreen extends ConsumerWidget {
  final int shopId;

  const ShopDetailScreen({super.key, required this.shopId});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: FutureBuilder<Shop>(
        future: ref.read(shopServiceProvider).getShop(shopId),
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
                              shop.address,
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${shop.workers?.length ?? 0}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Barbers list
              if (shop.workers == null || shop.workers!.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No barbers available'),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final worker = shop.workers![index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Worker avatar
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
                                    // Worker info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            worker.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (worker.role != null)
                                            Text(
                                              worker.role!,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xFF757575),
                                              ),
                                            ),
                                          if (worker.ratingAvg != null)
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber.shade700,
                                                    size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  worker.ratingAvg!
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    // Actions
                                    if (worker.phone != null)
                                      IconButton(
                                        icon: const Icon(Icons.phone),
                                        color: const Color(0xFF2196F3),
                                        onPressed: () async {
                                          final url = 'tel:${worker.phone}';
                                          if (await canLaunchUrl(Uri.parse(url))) {
                                            await launchUrl(Uri.parse(url));
                                          }
                                        },
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.chat_bubble_outline),
                                      color: const Color(0xFF2196F3),
                                      onPressed: () => context.push('/chats'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Book button
                                ElevatedButton(
                                  onPressed: () =>
                                      context.push('/barbers/${worker.id}/book'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2196F3),
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Book Appointment'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: shop.workers!.length,
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

