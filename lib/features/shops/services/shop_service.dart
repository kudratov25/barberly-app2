import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/shops/models/shop.dart';

/// Shop service for fetching shops, workers, and shop details
class ShopService {
  final ApiClient _apiClient;

  ShopService(this._apiClient);

  /// List shops with optional filters
  Future<PaginatedResponse<Shop>> listShops({
    double? lat,
    double? lng,
    double? radius,
    String? status,
    int? perPage,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (lat != null) queryParams['lat'] = lat;
      if (lng != null) queryParams['lng'] = lng;
      if (radius != null) queryParams['radius'] = radius;
      if (status != null) queryParams['status'] = status;
      if (perPage != null) queryParams['per_page'] = perPage;

      final response = await _apiClient.dio.get(
        ApiEndpoints.shops,
        queryParameters: queryParams,
      );

      return PaginatedResponse<Shop>.fromJson(
        response.data['data'],
        (json) => Shop.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single shop details
  Future<Shop> getShop(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.shop(id));
      return Shop.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// List workers of a shop
  Future<List<ShopWorker>> getShopWorkers(int shopId) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.shopWorkers(shopId),
      );
      return (response.data['data'] as List)
          .map((json) => ShopWorker.fromJson(json))
          .toList();
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

/// Paginated response wrapper
class PaginatedResponse<T> {
  final int currentPage;
  final List<T> data;
  final int total;
  final int perPage;

  PaginatedResponse({
    required this.currentPage,
    required this.data,
    required this.total,
    required this.perPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      currentPage: json['current_page'] as int,
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      total: json['total'] as int,
      perPage: json['per_page'] as int,
    );
  }
}

