// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AvailableSlotsResponseImpl _$$AvailableSlotsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AvailableSlotsResponseImpl(
  barberId: (json['barber_id'] as num).toInt(),
  date: json['date'] as String,
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  availableSlots: (json['available_slots'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  bookedSlots: (json['booked_slots'] as List<dynamic>?)
      ?.map((e) => BookedSlot.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$AvailableSlotsResponseImplToJson(
  _$AvailableSlotsResponseImpl instance,
) => <String, dynamic>{
  'barber_id': instance.barberId,
  'date': instance.date,
  'duration_minutes': instance.durationMinutes,
  'available_slots': instance.availableSlots,
  'booked_slots': instance.bookedSlots,
};

_$BookedSlotImpl _$$BookedSlotImplFromJson(Map<String, dynamic> json) =>
    _$BookedSlotImpl(
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      orderId: (json['order_id'] as num?)?.toInt(),
      clientName: json['client_name'] as String?,
    );

Map<String, dynamic> _$$BookedSlotImplToJson(_$BookedSlotImpl instance) =>
    <String, dynamic>{
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'order_id': instance.orderId,
      'client_name': instance.clientName,
    };
