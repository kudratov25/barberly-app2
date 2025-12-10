// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingImpl _$$RatingImplFromJson(Map<String, dynamic> json) => _$RatingImpl(
  id: (json['id'] as num).toInt(),
  barberId: (json['barber_id'] as num).toInt(),
  clientId: (json['client_id'] as num).toInt(),
  orderId: (json['order_id'] as num).toInt(),
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  createdAt: json['created_at'] as String,
  barber: json['barber'] == null
      ? null
      : RatingBarber.fromJson(json['barber'] as Map<String, dynamic>),
  client: json['client'] == null
      ? null
      : RatingClient.fromJson(json['client'] as Map<String, dynamic>),
  order: json['order'] == null
      ? null
      : RatingOrder.fromJson(json['order'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$RatingImplToJson(_$RatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barber_id': instance.barberId,
      'client_id': instance.clientId,
      'order_id': instance.orderId,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt,
      'barber': instance.barber,
      'client': instance.client,
      'order': instance.order,
    };

_$RatingBarberImpl _$$RatingBarberImplFromJson(Map<String, dynamic> json) =>
    _$RatingBarberImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$RatingBarberImplToJson(_$RatingBarberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };

_$RatingClientImpl _$$RatingClientImplFromJson(Map<String, dynamic> json) =>
    _$RatingClientImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$RatingClientImplToJson(_$RatingClientImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$RatingOrderImpl _$$RatingOrderImplFromJson(Map<String, dynamic> json) =>
    _$RatingOrderImpl(
      id: (json['id'] as num).toInt(),
      serviceId: (json['service_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RatingOrderImplToJson(_$RatingOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'price': instance.price,
    };
