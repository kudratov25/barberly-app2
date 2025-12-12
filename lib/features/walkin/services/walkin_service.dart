import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/walkin/models/walkin.dart';

/// Walk-in service for managing walk-in sessions
class WalkInService {
  final ApiClient _apiClient;

  WalkInService(this._apiClient);

  /// List walk-in sessions
  Future<List<WalkIn>> listWalkIns({bool? active}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (active != null) queryParams['active'] = active ? 1 : 0;

      final response = await _apiClient.dio.get(
        ApiEndpoints.walkin,
        queryParameters: queryParams,
      );

      return (response.data['data'] as List)
          .map((json) => WalkIn.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Start a new walk-in session
  Future<WalkIn> createWalkIn({
    required String clientName,
    required String clientPhone,
    required List<int> services,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.walkin,
        data: {
          'client_name': clientName,
          'client_phone': clientPhone,
          'services': services,
        },
      );
      return WalkIn.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single walk-in session
  Future<WalkIn> getWalkIn(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.walkinSession(id));
      return WalkIn.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Start a walk-in session
  Future<WalkIn> startWalkIn(int id) async {
    try {
      final response =
          await _apiClient.dio.post(ApiEndpoints.walkinStart(id));
      return WalkIn.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Finish a walk-in session
  Future<WalkIn> finishWalkIn({
    required int id,
    required int price,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.walkinFinish(id),
        data: {'price': price},
      );
      return WalkIn.fromJson(response.data['data']);
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

