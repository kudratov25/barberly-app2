import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/stats/models/stats.dart';

/// Stats service for fetching statistics
class StatsService {
  final ApiClient _apiClient;

  StatsService(this._apiClient);

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      final v = value.trim();
      final asInt = int.tryParse(v);
      if (asInt != null) return asInt;
      final asDouble = double.tryParse(v);
      if (asDouble != null) return asDouble.toInt();
    }
    return null;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> _normalizeDailyStatsJson(Map<String, dynamic> json) {
    final m = Map<String, dynamic>.from(json);
    
    // Normalize totals
    if (m['totals'] is Map) {
      final totals = Map<String, dynamic>.from(m['totals']);
      if (totals.containsKey('orders_count')) {
        totals['orders_count'] = _toInt(totals['orders_count']) ?? 0;
      }
      if (totals.containsKey('revenue')) {
        totals['revenue'] = _toInt(totals['revenue']) ?? 0;
      }
      m['totals'] = totals;
    }
    
    // Normalize points
    if (m['points'] is List) {
      m['points'] = (m['points'] as List).map((p) {
        if (p is! Map) return p;
        final pm = Map<String, dynamic>.from(p);
        if (pm.containsKey('orders_count')) {
          pm['orders_count'] = _toInt(pm['orders_count']) ?? 0;
        }
        if (pm.containsKey('revenue')) {
          pm['revenue'] = _toInt(pm['revenue']) ?? 0;
        }
        if (pm.containsKey('avg_ticket')) {
          pm['avg_ticket'] = _toInt(pm['avg_ticket']);
        }
        return pm;
      }).toList();
    }
    
    return m;
  }

  Map<String, dynamic> _normalizeMonthlyStatsJson(Map<String, dynamic> json) {
    final m = Map<String, dynamic>.from(json);
    
    // Normalize totals
    if (m['totals'] is Map) {
      final totals = Map<String, dynamic>.from(m['totals']);
      if (totals.containsKey('orders_count')) {
        totals['orders_count'] = _toInt(totals['orders_count']) ?? 0;
      }
      if (totals.containsKey('revenue')) {
        totals['revenue'] = _toInt(totals['revenue']) ?? 0;
      }
      m['totals'] = totals;
    }
    
    // Normalize points
    if (m['points'] is List) {
      m['points'] = (m['points'] as List).map((p) {
        if (p is! Map) return p;
        final pm = Map<String, dynamic>.from(p);
        if (pm.containsKey('orders_count')) {
          pm['orders_count'] = _toInt(pm['orders_count']) ?? 0;
        }
        if (pm.containsKey('revenue')) {
          pm['revenue'] = _toInt(pm['revenue']) ?? 0;
        }
        return pm;
      }).toList();
    }
    
    // Normalize comparison
    if (m['comparison'] is Map) {
      final comp = Map<String, dynamic>.from(m['comparison']);
      if (comp.containsKey('change_percent')) {
        comp['change_percent'] = _toDouble(comp['change_percent']);
      }
      m['comparison'] = comp;
    }
    
    return m;
  }

  /// Get daily stats for a month
  Future<DailyStats> getDailyStats(String month) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.statsDaily,
        queryParameters: {'month': month},
      );
      return DailyStats.fromJson(
        _normalizeDailyStatsJson(response.data['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get monthly stats for a year
  Future<MonthlyStats> getMonthlyStats(int year) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.statsMonthly,
        queryParameters: {'year': year},
      );
      return MonthlyStats.fromJson(
        _normalizeMonthlyStatsJson(response.data['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get admin monthly stats
  Future<MonthlyStats> getAdminMonthlyStats(int year) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.statsAdminMonthly,
        queryParameters: {'year': year},
      );
      return MonthlyStats.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get admin subscription stats
  Future<MonthlyStats> getAdminSubscriptionStats(int year) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.statsAdminSubscriptions,
        queryParameters: {'year': year},
      );
      return MonthlyStats.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response?.data != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic> && data['message'] != null) {
        return data['message'] as String;
      }
    }
    return e.message ?? 'An error occurred';
  }
}

