import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/shops/models/shop.dart';

/// Workers list screen for a shop
class WorkersListScreen extends ConsumerWidget {
  final int shopId;

  const WorkersListScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workers'),
      ),
      body: FutureBuilder<List<ShopWorker>>(
        future: ref.read(shopServiceProvider).getShopWorkers(shopId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No workers found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final worker = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(worker.name),
                  subtitle: worker.ratingAvg != null
                      ? Text('Rating: ${worker.ratingAvg!.toStringAsFixed(1)}')
                      : null,
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

