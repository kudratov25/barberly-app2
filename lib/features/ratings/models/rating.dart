import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating.freezed.dart';
part 'rating.g.dart';

@freezed
class Rating with _$Rating {
  const factory Rating({
    required int id,
    @JsonKey(name: 'barber_id') required int barberId,
    @JsonKey(name: 'client_id') required int clientId,
    @JsonKey(name: 'order_id') required int orderId,
    required int rating,
    String? comment,
    @JsonKey(name: 'created_at') required String createdAt,
    RatingBarber? barber,
    RatingClient? client,
    RatingOrder? order,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) =>
      _$RatingFromJson(json);
}

@freezed
class RatingBarber with _$RatingBarber {
  const factory RatingBarber({
    required int id,
    required String name,
    String? phone,
  }) = _RatingBarber;

  factory RatingBarber.fromJson(Map<String, dynamic> json) =>
      _$RatingBarberFromJson(json);
}

@freezed
class RatingClient with _$RatingClient {
  const factory RatingClient({
    required int id,
    required String name,
  }) = _RatingClient;

  factory RatingClient.fromJson(Map<String, dynamic> json) =>
      _$RatingClientFromJson(json);
}

@freezed
class RatingOrder with _$RatingOrder {
  const factory RatingOrder({
    required int id,
    @JsonKey(name: 'service_id') int? serviceId,
    int? price,
  }) = _RatingOrder;

  factory RatingOrder.fromJson(Map<String, dynamic> json) =>
      _$RatingOrderFromJson(json);
}

