import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/barbers/models/available_slots.dart';

/// Service for fetching available time slots for barbers
class AvailableSlotsService {
  final ApiClient _apiClient;

  AvailableSlotsService(this._apiClient);

  /// Get available time slots for a barber
  /// 
  /// [barberId] - Barber ID
  /// [date] - Date in Y-m-d format (e.g., "2025-12-15")
  /// [serviceIds] - Optional list of service IDs (duration will be calculated from services)
  /// [durationMinutes] - Optional duration in minutes (used if serviceIds is not provided)
  Future<AvailableSlotsResponse> getAvailableSlots({
    required int barberId,
    required String date,
    List<int>? serviceIds,
    int? durationMinutes,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'date': date,
      };

      // Add service_ids[] if provided (Laravel expects array format)
      if (serviceIds != null && serviceIds.isNotEmpty) {
        // Dio handles List values correctly for Laravel array format
        queryParams['service_ids[]'] = serviceIds;
      } else if (durationMinutes != null) {
        // Add duration_minutes if no serviceIds provided
        queryParams['duration_minutes'] = durationMinutes;
      }

      final response = await _apiClient.dio.get(
        ApiEndpoints.barberAvailableSlots(barberId),
        queryParameters: queryParams,
      );

      return AvailableSlotsResponse.fromJson(
        response.data['data'] as Map<String, dynamic>,
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
