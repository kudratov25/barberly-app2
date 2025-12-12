import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/walkin/models/walkin.dart';

/// Walk-in list screen
class WalkInListScreen extends ConsumerWidget {
  const WalkInListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walk-in Sessions'),
      ),
      body: FutureBuilder<List<WalkIn>>(
        future: ref.read(walkInServiceProvider).listWalkIns(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No walk-in sessions found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final walkIn = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(walkIn.clientName),
                  subtitle: Text('Status: ${walkIn.status}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/walkin/${walkIn.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

