import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/orders/models/order.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Order service for managing orders
class OrderService {
  final ApiClient _apiClient;

  OrderService(this._apiClient);

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

  Map<String, dynamic> _normalizeOrderJson(Map<String, dynamic> json) {
    final m = Map<String, dynamic>.from(json);

    if (m.containsKey('price')) {
      m['price'] = _toInt(m['price']) ?? 0;
    }
    if (m.containsKey('service_id')) {
      m['service_id'] = _toInt(m['service_id']);
    }
    if (m.containsKey('barber_id')) {
      m['barber_id'] = _toInt(m['barber_id']);
    }
    if (m.containsKey('client_id')) {
      m['client_id'] = _toInt(m['client_id']);
    }
    if (m.containsKey('shop_id')) {
      m['shop_id'] = _toInt(m['shop_id']);
    }

    // Normalize nested service object if exists (service.price can be "50000.00")
    final service = m['service'];
    if (service is Map) {
      final sm = Map<String, dynamic>.from(service);
      if (sm.containsKey('price')) {
        sm['price'] = _toInt(sm['price']) ?? 0;
      }
      if (sm.containsKey('id')) {
        sm['id'] = _toInt(sm['id']);
      }
      m['service'] = sm;
    }

    // Some backends may return `services: [...]` with price as string; ignore if model doesn't use it,
    // but normalize to avoid potential parsing issues if ever added.
    final services = m['services'];
    if (services is List) {
      m['services'] = services.map((s) {
        if (s is! Map) return s;
        final sm = Map<String, dynamic>.from(s);
        if (sm.containsKey('price')) sm['price'] = _toInt(sm['price']) ?? 0;
        if (sm.containsKey('id')) sm['id'] = _toInt(sm['id']);
        return sm;
      }).toList();
    }

    return m;
  }

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
        (json) => Order.fromJson(
          _normalizeOrderJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create a new order
  Future<Order> createOrder({
    required int barberId,
    required String startTime,
    List<int>? serviceIds,
    int? serviceId,
  }) async {
    try {
      final ids = (serviceIds != null && serviceIds.isNotEmpty)
          ? serviceIds
          : (serviceId != null ? <int>[serviceId] : <int>[]);
      if (ids.isEmpty) {
        throw 'service_ids or service_id is required';
      }

      final response = await _apiClient.dio.post(
        ApiEndpoints.orders,
        data: {
          'barber_id': barberId,
          if (ids.length == 1) 'service_id': ids.first,
          if (ids.length > 1) 'service_ids': ids,
          'start_time': startTime,
        },
      );
      return Order.fromJson(
        _normalizeOrderJson(response.data['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single order
  Future<Order> getOrder(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.order(id));
      return Order.fromJson(
        _normalizeOrderJson(response.data['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Start an order
  Future<Order> startOrder(int id) async {
    try {
      final response = await _apiClient.dio.post(ApiEndpoints.orderStart(id));
      return Order.fromJson(
        _normalizeOrderJson(response.data['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Finish an order
  Future<Order> finishOrder(int id) async {
    try {
      final response =
          await _apiClient.dio.post(ApiEndpoints.orderFinish(id));
      return Order.fromJson(
        _normalizeOrderJson(response.data['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Cancel an order
  Future<Order> cancelOrder(int id) async {
    try {
      final response =
          await _apiClient.dio.post(ApiEndpoints.orderCancel(id));
      return Order.fromJson(
        _normalizeOrderJson(response.data['data'] as Map<String, dynamic>),
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

