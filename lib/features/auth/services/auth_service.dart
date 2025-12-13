import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/common/utils/storage.dart';
import 'package:mobile/features/auth/models/auth_response.dart';
import 'package:mobile/features/auth/models/user.dart';

/// Authentication service for login, register, logout operations
class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  /// Register a new user
  Future<AuthResponse> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'app_type': 'client_side', // Client side app uchun
        },
      );

      final authResponse = AuthResponse.fromJson(response.data['data']);
      await Storage.saveToken(authResponse.token);
      return authResponse;
    } on DioException catch (e) {
      print(e.response?.data);
      throw _handleError(e);
    }
  }

  /// Login with phone and password
  Future<AuthResponse> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.login,
        data: {'phone': phone, 'password': password},
      );

      final authResponse = AuthResponse.fromJson(response.data['data']);
      await Storage.saveToken(authResponse.token);
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      await _apiClient.dio.post(ApiEndpoints.logout);
      await Storage.removeToken();
    } on DioException catch (e) {
      // Even if API call fails, remove token locally
      await Storage.removeToken();
      throw _handleError(e);
    }
  }

  /// Get current authenticated user
  Future<User> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.me);
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update user location
  Future<User> updateLocation({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _apiClient.dio.put(
        ApiEndpoints.updateLocation,
        data: {'lat': lat, 'lng': lng},
      );
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle API errors
  String _handleError(DioException e) {
    if (e.response?.data != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        if (data['message'] != null) {
          return data['message'] as String;
        }
        if (data['errors'] != null) {
          final errors = data['errors'] as Map<String, dynamic>;
          return errors.values.first[0] as String;
        }
      }
    }
    return e.message ?? 'An error occurred';
  }
}
