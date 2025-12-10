// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyStatsImpl _$$DailyStatsImplFromJson(Map<String, dynamic> json) =>
    _$DailyStatsImpl(
      month: json['month'] as String,
      points: (json['points'] as List<dynamic>)
          .map((e) => DailyPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: DailyTotals.fromJson(json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DailyStatsImplToJson(_$DailyStatsImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'points': instance.points,
      'totals': instance.totals,
    };

_$DailyPointImpl _$$DailyPointImplFromJson(Map<String, dynamic> json) =>
    _$DailyPointImpl(
      date: json['date'] as String,
      orders: (json['orders'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyPointImplToJson(_$DailyPointImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'orders': instance.orders,
      'revenue': instance.revenue,
    };

_$DailyTotalsImpl _$$DailyTotalsImplFromJson(Map<String, dynamic> json) =>
    _$DailyTotalsImpl(
      orders: (json['orders'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyTotalsImplToJson(_$DailyTotalsImpl instance) =>
    <String, dynamic>{'orders': instance.orders, 'revenue': instance.revenue};

_$MonthlyStatsImpl _$$MonthlyStatsImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyStatsImpl(
  year: (json['year'] as num).toInt(),
  currency: json['currency'] as String,
  points: (json['points'] as List<dynamic>)
      .map((e) => MonthlyPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  totals: MonthlyTotals.fromJson(json['totals'] as Map<String, dynamic>),
  currentMonth: json['current_month'] == null
      ? null
      : MonthlyPoint.fromJson(json['current_month'] as Map<String, dynamic>),
  comparison: json['comparison'] == null
      ? null
      : MonthlyComparison.fromJson(json['comparison'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$MonthlyStatsImplToJson(_$MonthlyStatsImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'currency': instance.currency,
      'points': instance.points,
      'totals': instance.totals,
      'current_month': instance.currentMonth,
      'comparison': instance.comparison,
    };

_$MonthlyPointImpl _$$MonthlyPointImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyPointImpl(
      month: json['month'] as String,
      orders: (json['orders'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
      shops: (json['shops'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MonthlyPointImplToJson(_$MonthlyPointImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'orders': instance.orders,
      'revenue': instance.revenue,
      'shops': instance.shops,
    };

_$MonthlyTotalsImpl _$$MonthlyTotalsImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyTotalsImpl(
      orders: (json['orders'] as num).toInt(),
      revenue: (json['revenue'] as num).toInt(),
      shops: (json['shops'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MonthlyTotalsImplToJson(_$MonthlyTotalsImpl instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'revenue': instance.revenue,
      'shops': instance.shops,
    };

_$MonthlyComparisonImpl _$$MonthlyComparisonImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyComparisonImpl(
  previousYear: (json['previous_year'] as num).toInt(),
  previousRevenue: (json['previous_revenue'] as num).toInt(),
  changePercent: (json['change_percent'] as num).toDouble(),
);

Map<String, dynamic> _$$MonthlyComparisonImplToJson(
  _$MonthlyComparisonImpl instance,
) => <String, dynamic>{
  'previous_year': instance.previousYear,
  'previous_revenue': instance.previousRevenue,
  'change_percent': instance.changePercent,
};
