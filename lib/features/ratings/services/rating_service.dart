import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/ratings/models/rating.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Rating service for managing ratings
class RatingService {
  final ApiClient _apiClient;

  RatingService(this._apiClient);

  /// List ratings
  Future<PaginatedResponse<Rating>> listRatings({
    int? barberId,
    int? perPage,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (barberId != null) queryParams['barber_id'] = barberId;
      if (perPage != null) queryParams['per_page'] = perPage;

      final response = await _apiClient.dio.get(
        ApiEndpoints.ratings,
        queryParameters: queryParams,
      );

      return PaginatedResponse<Rating>.fromJson(
        response.data['data'],
        (json) => Rating.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create a rating
  Future<Rating> createRating({
    required int orderId,
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.ratings,
        data: {
          'order_id': orderId,
          'rating': rating,
          if (comment != null) 'comment': comment,
        },
      );
      return Rating.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single rating
  Future<Rating> getRating(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.rating(id));
      return Rating.fromJson(response.data['data']);
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

