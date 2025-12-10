import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/orders/models/order.dart';

/// Order detail screen
class OrderDetailScreen extends ConsumerWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: FutureBuilder<Order>(
        future: ref.read(orderServiceProvider).getOrder(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Order not found'));
          }

          final order = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${order.status}'),
                const SizedBox(height: 8),
                Text('Price: ${order.price}'),
                const SizedBox(height: 8),
                Text('Start Time: ${order.startTime}'),
                if (order.endTime != null) Text('End Time: ${order.endTime}'),
                const SizedBox(height: 24),
                if (order.status == 'pending')
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(orderServiceProvider).cancelOrder(orderId);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    child: const Text('Cancel Order'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

