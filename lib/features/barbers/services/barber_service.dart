import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/barbers/models/barber.dart';

/// Barber service for fetching barbers, schedules, and updating status
class BarberService {
  final ApiClient _apiClient;

  BarberService(this._apiClient);

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> _normalizeBarberJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    if (normalized.containsKey('location_lat')) {
      normalized['location_lat'] = _toDouble(normalized['location_lat']);
    }
    if (normalized.containsKey('location_lng')) {
      normalized['location_lng'] = _toDouble(normalized['location_lng']);
    }
     if (normalized.containsKey('rating_avg')) {
       normalized['rating_avg'] = _toDouble(normalized['rating_avg']);
     }
     if (normalized.containsKey('distance')) {
       normalized['distance'] = _toDouble(normalized['distance']);
     }
    return normalized;
  }

  /// Get nearby barbers (lat/lng bilan)
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

      final data = response.data['data'] as List;
      return data
          .map(
            (json) => Barber.fromJson(
              _normalizeBarberJson(json as Map<String, dynamic>),
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Search barbers (lat/lngsiz, barber nomi yoki shop nomi bo'yicha)
  Future<List<Barber>> searchBarbers(String search) async {
    try {
      if (search.isEmpty) {
        return [];
      }

      final response = await _apiClient.dio.get(
        ApiEndpoints.barbersNearest,
        queryParameters: {'search': search},
      );

      final data = response.data['data'] as List;
      return data
          .map(
            (json) => Barber.fromJson(
              _normalizeBarberJson(json as Map<String, dynamic>),
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single barber by ID
  Future<Barber> getBarber(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.barber(id));
      return Barber.fromJson(
        _normalizeBarberJson(
          response.data['data'] as Map<String, dynamic>,
        ),
      );
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
      return Barber.fromJson(
        _normalizeBarberJson(
          response.data['data'] as Map<String, dynamic>,
        ),
      );
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
      return Barber.fromJson(
        _normalizeBarberJson(
          response.data['data'] as Map<String, dynamic>,
        ),
      );
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

