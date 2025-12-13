import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/services/models/service.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Service for fetching services
class ServiceService {
  final ApiClient _apiClient;

  ServiceService(this._apiClient);

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

  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final v = value.toLowerCase().trim();
      return v == 'true' || v == '1' || v == 'yes';
    }
    return false;
  }

  Map<String, dynamic> _normalizeServiceJson(Map<String, dynamic> json) {
    final m = Map<String, dynamic>.from(json);
    if (m.containsKey('price')) {
      m['price'] = _toInt(m['price']) ?? 0;
    }
    if (m.containsKey('duration_minutes')) {
      m['duration_minutes'] = _toInt(m['duration_minutes']) ?? 0;
    }
    if (m.containsKey('is_active')) {
      m['is_active'] = _toBool(m['is_active']);
    }
    if (m.containsKey('shop_id')) {
      m['shop_id'] = _toInt(m['shop_id']);
    }
    return m;
  }

  /// List services with optional shop filter
  Future<PaginatedResponse<Service>> listServices({
    int? shopId,
    int? perPage,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (shopId != null) queryParams['shop_id'] = shopId;
      if (perPage != null) queryParams['per_page'] = perPage;

      final response = await _apiClient.dio.get(
        ApiEndpoints.services,
        queryParameters: queryParams,
      );

      return PaginatedResponse<Service>.fromJson(
        response.data['data'],
        (json) => Service.fromJson(
          _normalizeServiceJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single service details
  Future<Service> getService(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.service(id));
      return Service.fromJson(
        _normalizeServiceJson(response.data['data'] as Map<String, dynamic>),
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

