import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required int id,
    @JsonKey(name: 'shop_id') int? shopId,
    @JsonKey(name: 'barber_id') required int barberId,
    @JsonKey(name: 'client_id') required int clientId,
    @JsonKey(name: 'service_id') required int serviceId,
    required String status,
    required int price,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'finished_at') String? finishedAt,
    @JsonKey(name: 'cancelled_at') String? cancelledAt,
    @JsonKey(name: 'created_at') String? createdAt,
    OrderBarber? barber,
    OrderClient? client,
    OrderService? service,
    OrderShop? shop,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class OrderBarber with _$OrderBarber {
  const factory OrderBarber({
    required int id,
    required String name,
    String? phone,
  }) = _OrderBarber;

  factory OrderBarber.fromJson(Map<String, dynamic> json) =>
      _$OrderBarberFromJson(json);
}

@freezed
class OrderClient with _$OrderClient {
  const factory OrderClient({
    required int id,
    required String name,
  }) = _OrderClient;

  factory OrderClient.fromJson(Map<String, dynamic> json) =>
      _$OrderClientFromJson(json);
}

@freezed
class OrderService with _$OrderService {
  const factory OrderService({
    required int id,
    required String name,
    required int price,
  }) = _OrderService;

  factory OrderService.fromJson(Map<String, dynamic> json) =>
      _$OrderServiceFromJson(json);
}

@freezed
class OrderShop with _$OrderShop {
  const factory OrderShop({
    required int id,
    required String name,
  }) = _OrderShop;

  factory OrderShop.fromJson(Map<String, dynamic> json) =>
      _$OrderShopFromJson(json);
}

