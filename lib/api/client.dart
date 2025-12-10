import 'package:dio/dio.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/common/utils/storage.dart';

/// API client with Dio configuration and interceptors
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    // Log the base URL for debugging
    print('API Client initialized with baseUrl: ${ApiEndpoints.baseUrl}');

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_AuthInterceptor());
    _dio.interceptors.add(_ErrorInterceptor());
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  Dio get dio => _dio;
}

/// Interceptor to add authentication token to requests
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await Storage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// Interceptor to handle errors globally
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log connection errors for debugging
    if (err.type == DioExceptionType.connectionError) {
      print('Connection error: ${err.message}');
      print('Request URL: ${err.requestOptions.uri}');
      print('Base URL: ${ApiEndpoints.baseUrl}');
    }

    // Handle 401 Unauthorized - force logout
    if (err.response?.statusCode == 401) {
      Storage.removeToken();
      // Navigation to login will be handled by the app
    }
    handler.next(err);
  }
}

/// API response wrapper
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      errors: json['errors'] as Map<String, dynamic>?,
    );
  }
}
