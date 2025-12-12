import 'package:freezed_annotation/freezed_annotation.dart';

part 'barber.freezed.dart';
part 'barber.g.dart';

@freezed
class Barber with _$Barber {
  const factory Barber({
    required int id,
    required String name,
    String? phone,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    @JsonKey(name: 'schedule_status') String? scheduleStatus,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    double? distance,
    List<BarberService>? services,
    List<BarberSchedule>? schedules,
    @JsonKey(name: 'last_active_at') String? lastActiveAt,
  }) = _Barber;

  factory Barber.fromJson(Map<String, dynamic> json) =>
      _$BarberFromJson(json);
}

@freezed
class BarberService with _$BarberService {
  const factory BarberService({
    required int id,
    required String name,
  }) = _BarberService;

  factory BarberService.fromJson(Map<String, dynamic> json) =>
      _$BarberServiceFromJson(json);
}

@freezed
class BarberSchedule with _$BarberSchedule {
  const factory BarberSchedule({
    required int id,
    @JsonKey(name: 'barber_id') required int barberId,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'break_start') String? breakStart,
    @JsonKey(name: 'break_end') String? breakEnd,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _BarberSchedule;

  factory BarberSchedule.fromJson(Map<String, dynamic> json) =>
      _$BarberScheduleFromJson(json);
}

