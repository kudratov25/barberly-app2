import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats.freezed.dart';
part 'stats.g.dart';

@freezed
class DailyStats with _$DailyStats {
  const factory DailyStats({
    required String month,
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
    required int orders,
    required int revenue,
  }) = _DailyPoint;

  factory DailyPoint.fromJson(Map<String, dynamic> json) =>
      _$DailyPointFromJson(json);
}

@freezed
class DailyTotals with _$DailyTotals {
  const factory DailyTotals({
    required int orders,
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
    required int orders,
    required int revenue,
    int? shops,
  }) = _MonthlyPoint;

  factory MonthlyPoint.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPointFromJson(json);
}

@freezed
class MonthlyTotals with _$MonthlyTotals {
  const factory MonthlyTotals({
    required int orders,
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
    @JsonKey(name: 'change_percent') required double changePercent,
  }) = _MonthlyComparison;

  factory MonthlyComparison.fromJson(Map<String, dynamic> json) =>
      _$MonthlyComparisonFromJson(json);
}

