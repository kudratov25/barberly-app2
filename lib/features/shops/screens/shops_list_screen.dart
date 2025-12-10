import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/shops/models/shop.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Shops list screen
class ShopsListScreen extends ConsumerStatefulWidget {
  const ShopsListScreen({super.key});

  @override
  ConsumerState<ShopsListScreen> createState() => _ShopsListScreenState();
}

class _ShopsListScreenState extends ConsumerState<ShopsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),
      body: FutureBuilder<PaginatedResponse<Shop>>(
        future: ref.read(shopServiceProvider).listShops(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text('No shops found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              final shop = snapshot.data!.data[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(shop.name),
                  subtitle: Text(shop.address),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/shops/${shop.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

