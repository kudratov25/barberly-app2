// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  createdAt: json['created_at'] as String,
  latestMessage: json['latest_message'] == null
      ? null
      : ChatMessage.fromJson(json['latest_message'] as Map<String, dynamic>),
  users: (json['users'] as List<dynamic>)
      .map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'created_at': instance.createdAt,
      'latest_message': instance.latestMessage,
      'users': instance.users,
    };

_$ChatUserImpl _$$ChatUserImplFromJson(Map<String, dynamic> json) =>
    _$ChatUserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ChatUserImplToJson(_$ChatUserImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: (json['id'] as num).toInt(),
      chatId: (json['chat_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      message: json['message'] as String,
      messageType: json['message_type'] as String,
      orderId: (json['order_id'] as num?)?.toInt(),
      replyToId: (json['reply_to_id'] as num?)?.toInt(),
      replyTo: json['reply_to'] == null
          ? null
          : ChatMessage.fromJson(json['reply_to'] as Map<String, dynamic>),
      isRead: json['is_read'] as bool,
      createdAt: json['created_at'] as String,
      user: json['user'] == null
          ? null
          : ChatUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'user_id': instance.userId,
      'message': instance.message,
      'message_type': instance.messageType,
      'order_id': instance.orderId,
      'reply_to_id': instance.replyToId,
      'reply_to': instance.replyTo,
      'is_read': instance.isRead,
      'created_at': instance.createdAt,
      'user': instance.user,
    };
