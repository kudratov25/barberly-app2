// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toInt(),
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      isActive: json['is_active'] as bool,
      shopId: (json['shop_id'] as num?)?.toInt(),
      shop: json['shop'] == null
          ? null
          : ServiceShop.fromJson(json['shop'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => ServiceUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration_minutes': instance.durationMinutes,
      'is_active': instance.isActive,
      'shop_id': instance.shopId,
      'shop': instance.shop,
      'users': instance.users,
    };

_$ServiceShopImpl _$$ServiceShopImplFromJson(Map<String, dynamic> json) =>
    _$ServiceShopImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$ServiceShopImplToJson(_$ServiceShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
    };

_$ServiceUserImpl _$$ServiceUserImplFromJson(Map<String, dynamic> json) =>
    _$ServiceUserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$ServiceUserImplToJson(_$ServiceUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };
