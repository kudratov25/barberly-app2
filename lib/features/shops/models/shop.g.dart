// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopOwnerImpl _$$ShopOwnerImplFromJson(Map<String, dynamic> json) =>
    _$ShopOwnerImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ShopOwnerImplToJson(_$ShopOwnerImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$SubscriptionPlanImpl _$$SubscriptionPlanImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionPlanImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  price: (json['price'] as num?)?.toInt(),
  durationDays: (json['duration_days'] as num?)?.toInt(),
);

Map<String, dynamic> _$$SubscriptionPlanImplToJson(
  _$SubscriptionPlanImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'duration_days': instance.durationDays,
};

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  address: json['address'] as String,
  phone: json['phone'] as String,
  status: json['status'] as String,
  locationLat: (json['location_lat'] as num?)?.toDouble(),
  locationLng: (json['location_lng'] as num?)?.toDouble(),
  owner: json['owner'] == null
      ? null
      : ShopOwner.fromJson(json['owner'] as Map<String, dynamic>),
  subscriptionPlan: json['subscription_plan'] == null
      ? null
      : SubscriptionPlan.fromJson(
          json['subscription_plan'] as Map<String, dynamic>,
        ),
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => ShopService.fromJson(e as Map<String, dynamic>))
      .toList(),
  workers: (json['workers'] as List<dynamic>?)
      ?.map((e) => ShopWorker.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'status': instance.status,
      'location_lat': instance.locationLat,
      'location_lng': instance.locationLng,
      'owner': instance.owner,
      'subscription_plan': instance.subscriptionPlan,
      'services': instance.services,
      'workers': instance.workers,
    };

_$ShopServiceImpl _$$ShopServiceImplFromJson(Map<String, dynamic> json) =>
    _$ShopServiceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      durationMinutes: (json['duration_minutes'] as num).toInt(),
    );

Map<String, dynamic> _$$ShopServiceImplToJson(_$ShopServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'duration_minutes': instance.durationMinutes,
    };

_$ShopWorkerImpl _$$ShopWorkerImplFromJson(Map<String, dynamic> json) =>
    _$ShopWorkerImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      ratingAvg: (json['rating_avg'] as num?)?.toDouble(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ShopService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ShopWorkerImplToJson(_$ShopWorkerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'role': instance.role,
      'rating_avg': instance.ratingAvg,
      'services': instance.services,
    };
