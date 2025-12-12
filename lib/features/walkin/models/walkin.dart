import 'package:freezed_annotation/freezed_annotation.dart';

part 'walkin.freezed.dart';
part 'walkin.g.dart';

@freezed
class WalkIn with _$WalkIn {
  const factory WalkIn({
    required int id,
    @JsonKey(name: 'barber_id') required int barberId,
    @JsonKey(name: 'client_name') required String clientName,
    @JsonKey(name: 'client_phone') required String clientPhone,
    required String status,
    int? price,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'finished_at') String? finishedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    WalkInBarber? barber,
  }) = _WalkIn;

  factory WalkIn.fromJson(Map<String, dynamic> json) =>
      _$WalkInFromJson(json);
}

@freezed
class WalkInBarber with _$WalkInBarber {
  const factory WalkInBarber({
    required int id,
    required String name,
    String? phone,
  }) = _WalkInBarber;

  factory WalkInBarber.fromJson(Map<String, dynamic> json) =>
      _$WalkInBarberFromJson(json);
}

