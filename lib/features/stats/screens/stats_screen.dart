import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/features/stats/models/stats.dart';

/// Stats screen
class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Daily'),
                Tab(text: 'Monthly'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _DailyStatsTab(),
                  _MonthlyStatsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyStatsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMonth =
        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';

    return FutureBuilder<DailyStats>(
      future: ref.read(statsServiceProvider).getDailyStats(currentMonth),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        final stats = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Orders: ${stats.totals.orders}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Revenue: ${stats.totals.revenue}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...stats.points.map((point) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(point.date),
                    subtitle: Text('Orders: ${point.orders}'),
                    trailing: Text('Revenue: ${point.revenue}'),
                  ),
                )),
          ],
        );
      },
    );
  }
}

class _MonthlyStatsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentYear = DateTime.now().year;

    return FutureBuilder<MonthlyStats>(
      future: ref.read(statsServiceProvider).getMonthlyStats(currentYear),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        final stats = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Orders: ${stats.totals.orders}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Revenue: ${stats.totals.revenue}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...stats.points.map((point) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(point.month),
                    subtitle: Text('Orders: ${point.orders}'),
                    trailing: Text('Revenue: ${point.revenue}'),
                  ),
                )),
          ],
        );
      },
    );
  }
}

