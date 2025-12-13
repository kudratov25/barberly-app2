import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required int id,
    required String type,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'latest_message') ChatMessage? latestMessage,
    @JsonKey(name: 'unread_count') int? unreadCount,
    required List<ChatUser> users,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

@freezed
class ChatUser with _$ChatUser {
  const factory ChatUser({
    required int id,
    required String name,
  }) = _ChatUser;

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    @JsonKey(name: 'chat_id') required int chatId,
    @JsonKey(name: 'user_id') required int userId,
    required String message,
    @JsonKey(name: 'message_type') required String messageType,
    @JsonKey(name: 'order_id') int? orderId,
    @JsonKey(name: 'reply_to_id') int? replyToId,
    @JsonKey(name: 'reply_to') ChatMessage? replyTo,
    @JsonKey(name: 'is_read') required bool isRead,
    @JsonKey(name: 'created_at') required String createdAt,
    ChatUser? user,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

