import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/stats/models/stats.dart';

/// Stats service for fetching statistics
class StatsService {
  final ApiClient _apiClient;

  StatsService(this._apiClient);

  /// Get daily stats for a month
  Future<DailyStats> getDailyStats(String month) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.statsDaily,
        queryParameters: {'month': month},
      );
      return DailyStats.fromJson(response.data['data']);
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
      return MonthlyStats.fromJson(response.data['data']);
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

