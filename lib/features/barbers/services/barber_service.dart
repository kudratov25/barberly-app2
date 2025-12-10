import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/barbers/models/barber.dart';

/// Barber service for fetching barbers, schedules, and updating status
class BarberService {
  final ApiClient _apiClient;

  BarberService(this._apiClient);

  /// Get nearby barbers
  Future<List<Barber>> getNearestBarbers({
    required double lat,
    required double lng,
    double? radius,
    String? status,
    double? minRating,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'lat': lat,
        'lng': lng,
      };
      if (radius != null) queryParams['radius'] = radius;
      if (status != null) queryParams['status'] = status;
      if (minRating != null) queryParams['min_rating'] = minRating;

      final response = await _apiClient.dio.get(
        ApiEndpoints.barbersNearest,
        queryParameters: queryParams,
      );

      return (response.data['data'] as List)
          .map((json) => Barber.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get barber weekly schedule
  Future<List<BarberSchedule>> getSchedule() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.barbersSchedule);
      return (response.data['data'] as List)
          .map((json) => BarberSchedule.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update barber status
  Future<Barber> updateStatus(String status) async {
    try {
      final response = await _apiClient.dio.put(
        ApiEndpoints.barbersStatus,
        data: {'status': status},
      );
      return Barber.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update barber location
  Future<Barber> updateLocation({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _apiClient.dio.put(
        ApiEndpoints.barbersLocation,
        data: {'lat': lat, 'lng': lng},
      );
      return Barber.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update barber schedule
  Future<void> updateSchedule(List<Map<String, dynamic>> schedules) async {
    try {
      await _apiClient.dio.put(
        ApiEndpoints.barbersSchedule,
        data: {'schedules': schedules},
      );
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

