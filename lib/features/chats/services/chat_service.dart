import 'package:dio/dio.dart';
import 'package:mobile/api/client.dart';
import 'package:mobile/api/endpoints.dart';
import 'package:mobile/features/chats/models/chat.dart';
import 'package:mobile/features/shops/services/shop_service.dart';

/// Chat service for managing chats and messages
class ChatService {
  final ApiClient _apiClient;

  ChatService(this._apiClient);

  /// List chats
  Future<List<Chat>> listChats() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.chats);
      return (response.data['data'] as List)
          .map((json) => Chat.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create or get private chat
  Future<Chat> createOrGetChat(int userId) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.chats,
        data: {'user_id': userId},
      );
      return Chat.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single chat
  Future<Chat> getChat(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.chat(id));
      return Chat.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// List messages of a chat
  Future<PaginatedResponse<ChatMessage>> listMessages({
    required int chatId,
    int? perPage,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (perPage != null) queryParams['per_page'] = perPage;

      final response = await _apiClient.dio.get(
        ApiEndpoints.chatMessages(chatId),
        queryParameters: queryParams,
      );

      return PaginatedResponse<ChatMessage>.fromJson(
        response.data['data'],
        (json) => ChatMessage.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Send a message
  Future<ChatMessage> sendMessage({
    required int chatId,
    required String message,
    String messageType = 'text',
    int? orderId,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.chatMessages(chatId),
        data: {
          'message': message,
          'message_type': messageType,
          if (orderId != null) 'order_id': orderId,
        },
      );
      return ChatMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Mark messages as read
  Future<void> markAsRead(int chatId) async {
    try {
      await _apiClient.dio.post(ApiEndpoints.chatRead(chatId));
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

