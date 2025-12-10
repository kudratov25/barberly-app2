import 'package:freezed_annotation/freezed_annotation.dart';

part 'service.freezed.dart';
part 'service.g.dart';

@freezed
class Service with _$Service {
  const factory Service({
    required int id,
    required String name,
    String? description,
    required int price,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'shop_id') int? shopId,
    ServiceShop? shop,
    List<ServiceUser>? users,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

@freezed
class ServiceShop with _$ServiceShop {
  const factory ServiceShop({
    required int id,
    required String name,
    String? address,
  }) = _ServiceShop;

  factory ServiceShop.fromJson(Map<String, dynamic> json) =>
      _$ServiceShopFromJson(json);
}

@freezed
class ServiceUser with _$ServiceUser {
  const factory ServiceUser({
    required int id,
    required String name,
    String? phone,
  }) = _ServiceUser;

  factory ServiceUser.fromJson(Map<String, dynamic> json) =>
      _$ServiceUserFromJson(json);
}

