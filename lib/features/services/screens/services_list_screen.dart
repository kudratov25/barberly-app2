import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/services/models/service.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Services list screen
class ServicesListScreen extends ConsumerWidget {
  const ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: FutureBuilder<PaginatedResponse<Service>>(
        future: ref.read(serviceServiceProvider).listServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text('No services found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              final service = snapshot.data!.data[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(service.name),
                  subtitle: Text('Price: ${service.price}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/services/${service.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

