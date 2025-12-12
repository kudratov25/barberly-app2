import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Order service for managing orders
class OrderService {
  final ApiClient _apiClient;

  OrderService(this._apiClient);

  /// List orders with filters
  Future<PaginatedResponse<Order>> listOrders({
    String? role,
    String? status,
    String? from,
    String? to,
    int? perPage,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (role != null) queryParams['role'] = role;
      if (status != null) queryParams['status'] = status;
      if (from != null) queryParams['from'] = from;
      if (to != null) queryParams['to'] = to;
      if (perPage != null) queryParams['per_page'] = perPage;

      final response = await _apiClient.dio.get(
        ApiEndpoints.orders,
        queryParameters: queryParams,
      );

      return PaginatedResponse<Order>.fromJson(
        response.data['data'],
        (json) => Order.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create a new order
  Future<Order> createOrder({
    required int barberId,
    required int serviceId,
    required String startTime,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.orders,
        data: {
          'barber_id': barberId,
          'service_id': serviceId,
          'start_time': startTime,
        },
      );
      return Order.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single order
  Future<Order> getOrder(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.order(id));
      return Order.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Start an order
  Future<Order> startOrder(int id) async {
    try {
      final response = await _apiClient.dio.post(ApiEndpoints.orderStart(id));
      return Order.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Finish an order
  Future<Order> finishOrder(int id) async {
    try {
      final response =
          await _apiClient.dio.post(ApiEndpoints.orderFinish(id));
      return Order.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Cancel an order
  Future<Order> cancelOrder(int id) async {
    try {
      final response =
          await _apiClient.dio.post(ApiEndpoints.orderCancel(id));
      return Order.fromJson(response.data['data']);
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

