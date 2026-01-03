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
      return (response.data['data'] as List).map((json) {
        final chatMap = Map<String, dynamic>.from(json as Map<String, dynamic>);
        // Normalize latest_message if exists
        if (chatMap['latest_message'] != null && chatMap['latest_message'] is Map) {
          final latestMsgMap = Map<String, dynamic>.from(chatMap['latest_message'] as Map);
          latestMsgMap['is_read'] = latestMsgMap['is_read'] ?? false;
          chatMap['latest_message'] = latestMsgMap;
        }
        return Chat.fromJson(chatMap);
      }).toList();
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
      final chatMap = Map<String, dynamic>.from(response.data['data'] as Map<String, dynamic>);
      // Normalize latest_message if exists
      if (chatMap['latest_message'] != null && chatMap['latest_message'] is Map) {
        final latestMsgMap = Map<String, dynamic>.from(chatMap['latest_message'] as Map);
        latestMsgMap['is_read'] = latestMsgMap['is_read'] ?? false;
        chatMap['latest_message'] = latestMsgMap;
      }
      return Chat.fromJson(chatMap);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get single chat
  Future<Chat> getChat(int id) async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.chat(id));
      final chatMap = Map<String, dynamic>.from(response.data['data'] as Map<String, dynamic>);
      // Normalize latest_message if exists
      if (chatMap['latest_message'] != null && chatMap['latest_message'] is Map) {
        final latestMsgMap = Map<String, dynamic>.from(chatMap['latest_message'] as Map);
        latestMsgMap['is_read'] = latestMsgMap['is_read'] ?? false;
        chatMap['latest_message'] = latestMsgMap;
      }
      return Chat.fromJson(chatMap);
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
        (json) {
          final map = Map<String, dynamic>.from(json as Map<String, dynamic>);
          // Backend sometimes may send null for is_read; normalize it to false
          map['is_read'] = map['is_read'] ?? false;
          // Normalize nested reply_to message if exists
          if (map['reply_to'] != null && map['reply_to'] is Map) {
            final replyToMap = Map<String, dynamic>.from(map['reply_to'] as Map);
            replyToMap['is_read'] = replyToMap['is_read'] ?? false;
            map['reply_to'] = replyToMap;
          }
          return ChatMessage.fromJson(map);
        },
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
    int? replyToId,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.chatMessages(chatId),
        data: {
          'message': message,
          'message_type': messageType,
          if (orderId != null) 'order_id': orderId,
          if (replyToId != null) 'reply_to_id': replyToId,
        },
      );
      final raw = response.data['data'] as Map<String, dynamic>;
      final map = Map<String, dynamic>.from(raw);
      // Backend ba'zi hollarda is_read ni null yuborishi mumkin – xavfsiz default:
      map['is_read'] = map['is_read'] ?? false;
      // Normalize nested reply_to message if exists
      if (map['reply_to'] != null && map['reply_to'] is Map) {
        final replyToMap = Map<String, dynamic>.from(map['reply_to'] as Map);
        replyToMap['is_read'] = replyToMap['is_read'] ?? false;
        map['reply_to'] = replyToMap;
      }
      return ChatMessage.fromJson(map);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update a message
  Future<ChatMessage> updateMessage({
    required int chatId,
    required int messageId,
    required String message,
  }) async {
    try {
      final response = await _apiClient.dio.patch(
        ApiEndpoints.chatMessage(chatId, messageId),
        data: {'message': message},
      );
      final raw = response.data['data'] as Map<String, dynamic>;
      final map = Map<String, dynamic>.from(raw);
      map['is_read'] = map['is_read'] ?? false;
      // Normalize nested reply_to message if exists
      if (map['reply_to'] != null && map['reply_to'] is Map) {
        final replyToMap = Map<String, dynamic>.from(map['reply_to'] as Map);
        replyToMap['is_read'] = replyToMap['is_read'] ?? false;
        map['reply_to'] = replyToMap;
      }
      return ChatMessage.fromJson(map);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete a message
  Future<void> deleteMessage({
    required int chatId,
    required int messageId,
  }) async {
    try {
      await _apiClient.dio.delete(
        ApiEndpoints.chatMessage(chatId, messageId),
      );
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

