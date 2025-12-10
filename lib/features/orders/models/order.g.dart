// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: (json['id'] as num).toInt(),
  shopId: (json['shop_id'] as num?)?.toInt(),
  barberId: (json['barber_id'] as num).toInt(),
  clientId: (json['client_id'] as num).toInt(),
  serviceId: (json['service_id'] as num).toInt(),
  status: json['status'] as String,
  price: (json['price'] as num).toInt(),
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String?,
  startedAt: json['started_at'] as String?,
  finishedAt: json['finished_at'] as String?,
  cancelledAt: json['cancelled_at'] as String?,
  createdAt: json['created_at'] as String?,
  barber: json['barber'] == null
      ? null
      : OrderBarber.fromJson(json['barber'] as Map<String, dynamic>),
  client: json['client'] == null
      ? null
      : OrderClient.fromJson(json['client'] as Map<String, dynamic>),
  service: json['service'] == null
      ? null
      : OrderService.fromJson(json['service'] as Map<String, dynamic>),
  shop: json['shop'] == null
      ? null
      : OrderShop.fromJson(json['shop'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shopId,
      'barber_id': instance.barberId,
      'client_id': instance.clientId,
      'service_id': instance.serviceId,
      'status': instance.status,
      'price': instance.price,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'started_at': instance.startedAt,
      'finished_at': instance.finishedAt,
      'cancelled_at': instance.cancelledAt,
      'created_at': instance.createdAt,
      'barber': instance.barber,
      'client': instance.client,
      'service': instance.service,
      'shop': instance.shop,
    };

_$OrderBarberImpl _$$OrderBarberImplFromJson(Map<String, dynamic> json) =>
    _$OrderBarberImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$OrderBarberImplToJson(_$OrderBarberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };

_$OrderClientImpl _$$OrderClientImplFromJson(Map<String, dynamic> json) =>
    _$OrderClientImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$OrderClientImplToJson(_$OrderClientImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$OrderServiceImpl _$$OrderServiceImplFromJson(Map<String, dynamic> json) =>
    _$OrderServiceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderServiceImplToJson(_$OrderServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };

_$OrderShopImpl _$$OrderShopImplFromJson(Map<String, dynamic> json) =>
    _$OrderShopImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$OrderShopImplToJson(_$OrderShopImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
