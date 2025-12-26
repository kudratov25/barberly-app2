import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class ShopOwner with _$ShopOwner {
  const factory ShopOwner({
    required int id,
    required String name,
  }) = _ShopOwner;

  factory ShopOwner.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerFromJson(json);
}

@freezed
class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    required int id,
    required String name,
    int? price,
    @JsonKey(name: 'duration_days') int? durationDays,
  }) = _SubscriptionPlan;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
}

@freezed
class Shop with _$Shop {
  const factory Shop({
    required int id,
    required String name,
    String? address, // Null bo'lishi mumkin
    required String phone,
    required String status,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    @JsonKey(name: 'barbers_count') int? barbersCount,
    ShopOwner? owner,
    @JsonKey(name: 'subscription_plan') SubscriptionPlan? subscriptionPlan,
    List<ShopService>? services,
    List<ShopWorker>? workers,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}

@freezed
class ShopService with _$ShopService {
  const factory ShopService({
    required int id,
    required String name,
    required int price,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
  }) = _ShopService;

  factory ShopService.fromJson(Map<String, dynamic> json) =>
      _$ShopServiceFromJson(json);
}

@freezed
class ShopWorker with _$ShopWorker {
  const factory ShopWorker({
    required int id,
    required String name,
    String? phone,
    String? role,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    List<ShopService>? services,
  }) = _ShopWorker;

  factory ShopWorker.fromJson(Map<String, dynamic> json) =>
      _$ShopWorkerFromJson(json);
}


