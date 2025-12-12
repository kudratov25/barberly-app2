import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/barbers/models/barber.dart';

/// Barber schedule screen
class BarberScheduleScreen extends ConsumerWidget {
  const BarberScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: FutureBuilder<List<BarberSchedule>>(
        future: ref.read(barberServiceProvider).getSchedule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No schedule found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final schedule = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text('Day ${schedule.dayOfWeek}'),
                  subtitle: Text(
                      '${schedule.startTime} - ${schedule.endTime}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

