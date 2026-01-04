import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobile/common/providers/providers.dart';
import 'package:mobile/common/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/stats/models/stats.dart';
import 'package:intl/intl.dart';

/// Stats screen with GitHub-style combined charts
class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  String _selectedPeriod = 'daily'; // 'daily' or 'monthly'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Period selector
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _PeriodButton(
                    label: 'Daily',
                    isSelected: _selectedPeriod == 'daily',
                    onTap: () => setState(() => _selectedPeriod = 'daily'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PeriodButton(
                    label: 'Monthly',
                    isSelected: _selectedPeriod == 'monthly',
                    onTap: () => setState(() => _selectedPeriod = 'monthly'),
                  ),
                ),
              ],
            ),
          ),
          // Stats content
          Expanded(
            child: _selectedPeriod == 'daily'
                ? _DailyStatsView()
                : _MonthlyStatsView(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 5),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PeriodButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2C4B77) .withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2C4B77)
                : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? const Color(0xFF2C4B77)
                : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }
}

class _DailyStatsView extends ConsumerWidget {
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
        return _StatsContent(
          dailyStats: stats,
          monthlyStats: null,
        );
      },
    );
  }
}

class _MonthlyStatsView extends ConsumerWidget {
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
        return _StatsContent(
          dailyStats: null,
          monthlyStats: stats,
        );
      },
    );
  }
}

class _StatsContent extends StatelessWidget {
  final DailyStats? dailyStats;
  final MonthlyStats? monthlyStats;

  const _StatsContent({
    this.dailyStats,
    this.monthlyStats,
  });

  @override
  Widget build(BuildContext context) {
    final isDaily = dailyStats != null;
    final ordersTotal =
        isDaily ? dailyStats!.totals.ordersCount : monthlyStats!.totals.ordersCount;
    final walkinsTotal =
        isDaily ? dailyStats!.totals.walkinsCount : monthlyStats!.totals.walkinsCount;
    final totalCount =
        isDaily ? dailyStats!.totals.totalCount : monthlyStats!.totals.totalCount;
    final revenueTotal =
        isDaily ? dailyStats!.totals.revenue : monthlyStats!.totals.revenue;
    final nf = NumberFormat.decimalPattern();
    String fmt(int v) => nf.format(v);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary cards
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'Orders',
                value: fmt(ordersTotal),
                icon: Icons.receipt_long,
                color: const Color(0xFF2C4B77) ,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                title: 'Walk-ins',
                value: fmt(walkinsTotal),
                icon: Icons.directions_walk,
                color: const Color(0xFFF59E0B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                title: 'Total',
                value: fmt(totalCount),
                icon: Icons.event_note,
                color: const Color(0xFF6366F1),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                title: 'Revenue',
                value: '${fmt(revenueTotal)} UZS',
                icon: Icons.payments,
                color: const Color(0xFF10B981),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Combined chart (GitHub style)
        if (isDaily && dailyStats!.points.isNotEmpty ||
            !isDaily && monthlyStats!.points.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDaily ? 'Daily Statistics' : 'Monthly Statistics',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 250,
                  child: isDaily
                      ? _buildDailyChart(dailyStats!.points)
                      : _buildMonthlyChart(monthlyStats!.points),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        // Data table
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 16),
              if (isDaily)
                ...dailyStats!.points.map((point) => _DataRow(
                      date:
                          DateFormat('MMM dd').format(DateTime.parse(point.date)),
                      orders: point.ordersCount,
                      walkins: point.walkinsCount,
                      total: point.totalCount,
                      revenue: point.revenue,
                    ))
              else
                ...monthlyStats!.points.map((point) => _DataRow(
                      date: point.month,
                      orders: point.ordersCount,
                      walkins: point.walkinsCount,
                      total: point.totalCount,
                      revenue: point.revenue,
                    )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyChart(List<DailyPoint> points) {
    final maxOrders = points
            .map((p) => p.totalCount)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() +
        5;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxOrders / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xFFE5E7EB),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: points.length > 10 ? 5 : 1,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < points.length) {
                  final point = points[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('dd').format(DateTime.parse(point.date)),
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        minX: 0,
        maxX: (points.length - 1).toDouble(),
        minY: 0,
        maxY: maxOrders,
        lineBarsData: [
          // Orders line
          LineChartBarData(
            spots: points.asMap().entries.map((entry) {
              return FlSpot(
                entry.key.toDouble(),
                entry.value.ordersCount.toDouble(),
              );
            }).toList(),
            isCurved: true,
            color: const Color(0xFF2C4B77) ,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF2C4B77) .withOpacity(0.1),
            ),
          ),
          // Walk-ins line
          LineChartBarData(
            spots: points.asMap().entries.map((entry) {
              return FlSpot(
                entry.key.toDouble(),
                entry.value.walkinsCount.toDouble(),
              );
            }).toList(),
            isCurved: true,
            color: const Color(0xFFF59E0B),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart(List<MonthlyPoint> points) {
    final maxOrders = points
            .map((p) => p.totalCount)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() +
        5;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxOrders,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < points.length) {
                  final point = points[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MMM').format(
                        DateTime.parse('${point.month}-01'),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xFFE5E7EB),
              strokeWidth: 1,
            );
          },
        ),
        barGroups: points.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.ordersCount.toDouble(),
                color: const Color(0xFF2C4B77) ,
                width: 8,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
              BarChartRodData(
                toY: entry.value.walkinsCount.toDouble(),
                color: const Color(0xFFF59E0B),
                width: 8,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String date;
  final int orders;
  final int walkins;
  final int total;
  final int revenue;

  const _DataRow({
    required this.date,
    required this.orders,
    required this.walkins,
    required this.total,
    required this.revenue,
  });

  @override
  Widget build(BuildContext context) {
    final nf = NumberFormat.decimalPattern();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111827),
              ),
            ),
          ),
          Text(
            '${nf.format(total)} (O:${nf.format(orders)} W:${nf.format(walkins)})',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${nf.format(revenue)} UZS',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }
}
