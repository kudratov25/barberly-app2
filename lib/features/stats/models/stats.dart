import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats.freezed.dart';
part 'stats.g.dart';

@freezed
class DailyStats with _$DailyStats {
  const factory DailyStats({
    String? period,
    String? from,
    String? to,
    String? currency,
    required List<DailyPoint> points,
    required DailyTotals totals,
  }) = _DailyStats;

  factory DailyStats.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsFromJson(json);
}

@freezed
class DailyPoint with _$DailyPoint {
  const factory DailyPoint({
    required String date,
    @JsonKey(name: 'orders_count') required int ordersCount,
    required int revenue,
    @JsonKey(name: 'avg_ticket') int? avgTicket,
  }) = _DailyPoint;

  factory DailyPoint.fromJson(Map<String, dynamic> json) =>
      _$DailyPointFromJson(json);
}

@freezed
class DailyTotals with _$DailyTotals {
  const factory DailyTotals({
    @JsonKey(name: 'orders_count') required int ordersCount,
    required int revenue,
  }) = _DailyTotals;

  factory DailyTotals.fromJson(Map<String, dynamic> json) =>
      _$DailyTotalsFromJson(json);
}

@freezed
class MonthlyStats with _$MonthlyStats {
  const factory MonthlyStats({
    required int year,
    required String currency,
    required List<MonthlyPoint> points,
    required MonthlyTotals totals,
    @JsonKey(name: 'current_month') MonthlyPoint? currentMonth,
    MonthlyComparison? comparison,
  }) = _MonthlyStats;

  factory MonthlyStats.fromJson(Map<String, dynamic> json) =>
      _$MonthlyStatsFromJson(json);
}

@freezed
class MonthlyPoint with _$MonthlyPoint {
  const factory MonthlyPoint({
    required String month,
    @JsonKey(name: 'orders_count') required int ordersCount,
    required int revenue,
    int? shops,
  }) = _MonthlyPoint;

  factory MonthlyPoint.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPointFromJson(json);
}

@freezed
class MonthlyTotals with _$MonthlyTotals {
  const factory MonthlyTotals({
    @JsonKey(name: 'orders_count') required int ordersCount,
    required int revenue,
    int? shops,
  }) = _MonthlyTotals;

  factory MonthlyTotals.fromJson(Map<String, dynamic> json) =>
      _$MonthlyTotalsFromJson(json);
}

@freezed
class MonthlyComparison with _$MonthlyComparison {
  const factory MonthlyComparison({
    @JsonKey(name: 'previous_year') required int previousYear,
    @JsonKey(name: 'previous_revenue') required int previousRevenue,
    @JsonKey(name: 'change_percent') double? changePercent,
  }) = _MonthlyComparison;

  factory MonthlyComparison.fromJson(Map<String, dynamic> json) =>
      _$MonthlyComparisonFromJson(json);
}

