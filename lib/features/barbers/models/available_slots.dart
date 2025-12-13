import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_slots.freezed.dart';
part 'available_slots.g.dart';

/// Available slots response model
@freezed
class AvailableSlotsResponse with _$AvailableSlotsResponse {
  const factory AvailableSlotsResponse({
    @JsonKey(name: 'barber_id') required int barberId,
    required String date,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'available_slots') required List<String> availableSlots,
    @JsonKey(name: 'booked_slots') List<BookedSlot>? bookedSlots,
  }) = _AvailableSlotsResponse;

  factory AvailableSlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsResponseFromJson(json);
}

/// Booked slot model
@freezed
class BookedSlot with _$BookedSlot {
  const factory BookedSlot({
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'order_id') int? orderId,
    @JsonKey(name: 'client_name') String? clientName,
  }) = _BookedSlot;

  factory BookedSlot.fromJson(Map<String, dynamic> json) =>
      _$BookedSlotFromJson(json);
}
