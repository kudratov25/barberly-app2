import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/walkin/models/walkin.dart';

/// Walk-in session detail screen
class WalkInSessionScreen extends ConsumerWidget {
  final int walkInId;

  const WalkInSessionScreen({super.key, required this.walkInId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walk-in Session'),
      ),
      body: FutureBuilder<WalkIn>(
        future: ref.read(walkInServiceProvider).getWalkIn(walkInId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Session not found'));
          }

          final walkIn = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Client: ${walkIn.clientName}'),
                const SizedBox(height: 8),
                Text('Phone: ${walkIn.clientPhone}'),
                const SizedBox(height: 8),
                Text('Status: ${walkIn.status}'),
                if (walkIn.price != null)
                  Text('Price: ${walkIn.price}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

