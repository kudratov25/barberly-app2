// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stats.freezed.dart';
part 'stats.g.dart';

@freezed
class DailyStats with _$DailyStats {
  @JsonSerializable(fieldRename: FieldRename.snake)
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
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DailyPoint({
    required String date,
    @Default(0) int ordersCount,
    @Default(0) int walkinsCount,
    @Default(0) int totalCount,
    @Default(0) int revenue,
    @Default(0) int ordersRevenue,
    @Default(0) int walkinsRevenue,
    int? avgTicket,
  }) = _DailyPoint;

  factory DailyPoint.fromJson(Map<String, dynamic> json) =>
      _$DailyPointFromJson(json);
}

@freezed
class DailyTotals with _$DailyTotals {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DailyTotals({
    @Default(0) int ordersCount,
    @Default(0) int walkinsCount,
    @Default(0) int totalCount,
    @Default(0) int revenue,
    @Default(0) int ordersRevenue,
    @Default(0) int walkinsRevenue,
  }) = _DailyTotals;

  factory DailyTotals.fromJson(Map<String, dynamic> json) =>
      _$DailyTotalsFromJson(json);
}

@freezed
class MonthlyStats with _$MonthlyStats {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MonthlyStats({
    required int year,
    required String currency,
    required List<MonthlyPoint> points,
    required MonthlyTotals totals,
    MonthlyPoint? currentMonth,
    MonthlyComparison? comparison,
  }) = _MonthlyStats;

  factory MonthlyStats.fromJson(Map<String, dynamic> json) =>
      _$MonthlyStatsFromJson(json);
}

@freezed
class MonthlyPoint with _$MonthlyPoint {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MonthlyPoint({
    required String month,
    @Default(0) int ordersCount,
    @Default(0) int walkinsCount,
    @Default(0) int totalCount,
    @Default(0) int revenue,
    @Default(0) int ordersRevenue,
    @Default(0) int walkinsRevenue,
    int? shops,
  }) = _MonthlyPoint;

  factory MonthlyPoint.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPointFromJson(json);
}

@freezed
class MonthlyTotals with _$MonthlyTotals {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MonthlyTotals({
    @Default(0) int ordersCount,
    @Default(0) int walkinsCount,
    @Default(0) int totalCount,
    @Default(0) int revenue,
    @Default(0) int ordersRevenue,
    @Default(0) int walkinsRevenue,
    int? shops,
  }) = _MonthlyTotals;

  factory MonthlyTotals.fromJson(Map<String, dynamic> json) =>
      _$MonthlyTotalsFromJson(json);
}

@freezed
class MonthlyComparison with _$MonthlyComparison {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MonthlyComparison({
    required int previousYear,
    required int previousRevenue,
    double? changePercent,
  }) = _MonthlyComparison;

  factory MonthlyComparison.fromJson(Map<String, dynamic> json) =>
      _$MonthlyComparisonFromJson(json);
}

