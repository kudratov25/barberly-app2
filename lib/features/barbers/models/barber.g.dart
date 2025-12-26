// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BarberImpl _$$BarberImplFromJson(Map<String, dynamic> json) => _$BarberImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  shopId: (json['shop_id'] as num?)?.toInt(),
  phone: json['phone'] as String?,
  locationLat: (json['location_lat'] as num?)?.toDouble(),
  locationLng: (json['location_lng'] as num?)?.toDouble(),
  scheduleStatus: json['schedule_status'] as String?,
  ratingAvg: (json['rating_avg'] as num?)?.toDouble(),
  distance: (json['distance'] as num?)?.toDouble(),
  shopName: json['shop_name'] as String?,
  shopBarbersCount: (json['shop_barbers_count'] as num?)?.toInt(),
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => BarberService.fromJson(e as Map<String, dynamic>))
      .toList(),
  schedules: (json['schedules'] as List<dynamic>?)
      ?.map((e) => BarberSchedule.fromJson(e as Map<String, dynamic>))
      .toList(),
  lastActiveAt: json['last_active_at'] as String?,
);

Map<String, dynamic> _$$BarberImplToJson(_$BarberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shop_id': instance.shopId,
      'phone': instance.phone,
      'location_lat': instance.locationLat,
      'location_lng': instance.locationLng,
      'schedule_status': instance.scheduleStatus,
      'rating_avg': instance.ratingAvg,
      'distance': instance.distance,
      'shop_name': instance.shopName,
      'shop_barbers_count': instance.shopBarbersCount,
      'services': instance.services,
      'schedules': instance.schedules,
      'last_active_at': instance.lastActiveAt,
    };

_$BarberServiceImpl _$$BarberServiceImplFromJson(Map<String, dynamic> json) =>
    _$BarberServiceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$BarberServiceImplToJson(_$BarberServiceImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$BarberScheduleImpl _$$BarberScheduleImplFromJson(Map<String, dynamic> json) =>
    _$BarberScheduleImpl(
      id: (json['id'] as num).toInt(),
      barberId: (json['barber_id'] as num).toInt(),
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      breakStart: json['break_start'] as String?,
      breakEnd: json['break_end'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$$BarberScheduleImplToJson(
  _$BarberScheduleImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'barber_id': instance.barberId,
  'day_of_week': instance.dayOfWeek,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'break_start': instance.breakStart,
  'break_end': instance.breakEnd,
  'is_active': instance.isActive,
};
