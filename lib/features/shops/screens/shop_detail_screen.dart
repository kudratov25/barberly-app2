import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/shops/models/shop.dart';

/// Shop detail screen
class ShopDetailScreen extends ConsumerWidget {
  final int shopId;

  const ShopDetailScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Details'),
      ),
      body: FutureBuilder<Shop>(
        future: ref.read(shopServiceProvider).getShop(shopId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Shop not found'));
          }

          final shop = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(shop.address),
                const SizedBox(height: 8),
                Text(shop.phone),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.push('/shops/$shopId/workers'),
                  child: const Text('View Workers'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

