import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/services/models/service.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Service for fetching services
class ServiceService {
  final ApiClient _apiClient;

  ServiceService(this._apiClient);

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
        (json) => Service.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single service details
  Future<Service> getService(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.service(id));
      return Service.fromJson(response.data['data']);
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

