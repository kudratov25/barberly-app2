// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalkInImpl _$$WalkInImplFromJson(Map<String, dynamic> json) => _$WalkInImpl(
  id: (json['id'] as num).toInt(),
  barberId: (json['barber_id'] as num).toInt(),
  clientName: json['client_name'] as String,
  clientPhone: json['client_phone'] as String,
  status: json['status'] as String,
  price: (json['price'] as num?)?.toInt(),
  startedAt: json['started_at'] as String?,
  finishedAt: json['finished_at'] as String?,
  createdAt: json['created_at'] as String?,
  barber: json['barber'] == null
      ? null
      : WalkInBarber.fromJson(json['barber'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$WalkInImplToJson(_$WalkInImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barber_id': instance.barberId,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'status': instance.status,
      'price': instance.price,
      'started_at': instance.startedAt,
      'finished_at': instance.finishedAt,
      'created_at': instance.createdAt,
      'barber': instance.barber,
    };

_$WalkInBarberImpl _$$WalkInBarberImplFromJson(Map<String, dynamic> json) =>
    _$WalkInBarberImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$WalkInBarberImplToJson(_$WalkInBarberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };
