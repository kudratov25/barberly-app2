import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/barbers/models/barber.dart';
import 'package:mobile/features/shops/models/shop.dart';

/// Shop service for fetching shops, workers, and shop details
class ShopService {
  final ApiClient _apiClient;

  ShopService(this._apiClient);

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

  Map<String, dynamic> _normalizeShopJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    
    // Handle null address
    if (normalized.containsKey('address') && normalized['address'] == null) {
      normalized['address'] = 'Manzil ko\'rsatilmagan'; // Default value
    }
    
    if (normalized.containsKey('location_lat')) {
      normalized['location_lat'] = _toDouble(normalized['location_lat']);
    }
    if (normalized.containsKey('location_lng')) {
      normalized['location_lng'] = _toDouble(normalized['location_lng']);
    }

    // Normalize subscription_plan.price (backend may send "50000.00" as String)
    // subscription_plan null bo'lishi mumkin
    final plan = normalized['subscription_plan'];
    if (plan != null && plan is Map) {
      final planMap = Map<String, dynamic>.from(plan);
      if (planMap.containsKey('price')) {
        planMap['price'] = _toInt(planMap['price']);
      }
      // Some backends use price_monthly instead of price
      if (!planMap.containsKey('price') && planMap.containsKey('price_monthly')) {
        planMap['price'] = _toInt(planMap['price_monthly']);
      }
      normalized['subscription_plan'] = planMap;
    } else {
      // subscription_plan null bo'lsa, uni o'chirish yoki null qoldirish
      normalized['subscription_plan'] = null;
    }

    // Normalize shop services prices
    final services = normalized['services'];
    if (services is List) {
      normalized['services'] = services.map((s) {
        if (s is! Map) return s;
        final m = Map<String, dynamic>.from(s);
        if (m.containsKey('price')) {
          m['price'] = _toInt(m['price']) ?? 0;
        }
        if (m.containsKey('duration_minutes')) {
          m['duration_minutes'] = _toInt(m['duration_minutes']) ?? 0;
        }
        return m;
      }).toList();
    }

    // Normalize workers -> services -> price if present (legacy endpoint)
    final workers = normalized['workers'];
    if (workers is List) {
      normalized['workers'] = workers.map((w) {
        if (w is! Map) return w;
        final wm = Map<String, dynamic>.from(w);

        // Backend may send rating_avg as "5.00" (String) but model expects double?
        if (wm.containsKey('rating_avg')) {
          wm['rating_avg'] = _toDouble(wm['rating_avg']);
        }

        final wServices = wm['services'];
        if (wServices is List) {
          wm['services'] = wServices.map((s) {
            if (s is! Map) return s;
            final sm = Map<String, dynamic>.from(s);
            if (sm.containsKey('price')) {
              sm['price'] = _toInt(sm['price']) ?? 0;
            }
            if (sm.containsKey('duration_minutes')) {
              sm['duration_minutes'] = _toInt(sm['duration_minutes']) ?? 0;
            }
            return sm;
          }).toList();
        }
        return wm;
      }).toList();
    }

    return normalized;
  }

  Map<String, dynamic> _normalizeBarberJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);

    // Some backends send `status` instead of `schedule_status`
    if (!normalized.containsKey('schedule_status') &&
        normalized.containsKey('status')) {
      normalized['schedule_status'] = normalized['status'];
    }
    if (!normalized.containsKey('schedule_status') &&
        normalized.containsKey('current_status')) {
      normalized['schedule_status'] = normalized['current_status'];
    }

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

    // Normalize schedules list (ensure is_active exists & is bool)
    final schedules = normalized['schedules'];
    if (schedules is List) {
      normalized['schedules'] = schedules.map((s) {
        if (s is! Map) return s;
        final m = Map<String, dynamic>.from(s);
        if (!m.containsKey('is_active')) {
          m['is_active'] = true;
        } else {
          m['is_active'] = _toBool(m['is_active']);
        }
        return m;
      }).toList();
    }

    return normalized;
  }

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
        (json) => Shop.fromJson(
          _normalizeShopJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single shop details
  Future<Shop> getShop(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.shop(id));
      return Shop.fromJson(
        _normalizeShopJson(
          response.data['data'] as Map<String, dynamic>,
        ),
      );
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

  /// List barbers of a shop (with optional status filter)
  ///
  /// Backend: GET /api/v1/shops/{shop}/barbers?status=online|offline|busy|walk_in
  /// Returns barbers with services + active schedules
  Future<List<Barber>> getShopBarbers({
    required int shopId,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null && status.isNotEmpty) queryParams['status'] = status;

      final response = await _apiClient.dio.get(
        ApiEndpoints.shopBarbers(shopId),
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      return (response.data['data'] as List)
          .map((json) => Barber.fromJson(
                _normalizeBarberJson(json as Map<String, dynamic>),
              ))
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

