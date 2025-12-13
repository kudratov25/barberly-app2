// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_slots.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AvailableSlotsResponse _$AvailableSlotsResponseFromJson(
  Map<String, dynamic> json,
) {
  return _AvailableSlotsResponse.fromJson(json);
}

/// @nodoc
mixin _$AvailableSlotsResponse {
  @JsonKey(name: 'barber_id')
  int get barberId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_slots')
  List<String> get availableSlots => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_slots')
  List<BookedSlot>? get bookedSlots => throw _privateConstructorUsedError;

  /// Serializes this AvailableSlotsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableSlotsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableSlotsResponseCopyWith<AvailableSlotsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableSlotsResponseCopyWith<$Res> {
  factory $AvailableSlotsResponseCopyWith(
    AvailableSlotsResponse value,
    $Res Function(AvailableSlotsResponse) then,
  ) = _$AvailableSlotsResponseCopyWithImpl<$Res, AvailableSlotsResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'barber_id') int barberId,
    String date,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'available_slots') List<String> availableSlots,
    @JsonKey(name: 'booked_slots') List<BookedSlot>? bookedSlots,
  });
}

/// @nodoc
class _$AvailableSlotsResponseCopyWithImpl<
  $Res,
  $Val extends AvailableSlotsResponse
>
    implements $AvailableSlotsResponseCopyWith<$Res> {
  _$AvailableSlotsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableSlotsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barberId = null,
    Object? date = null,
    Object? durationMinutes = null,
    Object? availableSlots = null,
    Object? bookedSlots = freezed,
  }) {
    return _then(
      _value.copyWith(
            barberId: null == barberId
                ? _value.barberId
                : barberId // ignore: cast_nullable_to_non_nullable
                      as int,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            availableSlots: null == availableSlots
                ? _value.availableSlots
                : availableSlots // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            bookedSlots: freezed == bookedSlots
                ? _value.bookedSlots
                : bookedSlots // ignore: cast_nullable_to_non_nullable
                      as List<BookedSlot>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailableSlotsResponseImplCopyWith<$Res>
    implements $AvailableSlotsResponseCopyWith<$Res> {
  factory _$$AvailableSlotsResponseImplCopyWith(
    _$AvailableSlotsResponseImpl value,
    $Res Function(_$AvailableSlotsResponseImpl) then,
  ) = __$$AvailableSlotsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'barber_id') int barberId,
    String date,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'available_slots') List<String> availableSlots,
    @JsonKey(name: 'booked_slots') List<BookedSlot>? bookedSlots,
  });
}

/// @nodoc
class __$$AvailableSlotsResponseImplCopyWithImpl<$Res>
    extends
        _$AvailableSlotsResponseCopyWithImpl<$Res, _$AvailableSlotsResponseImpl>
    implements _$$AvailableSlotsResponseImplCopyWith<$Res> {
  __$$AvailableSlotsResponseImplCopyWithImpl(
    _$AvailableSlotsResponseImpl _value,
    $Res Function(_$AvailableSlotsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableSlotsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barberId = null,
    Object? date = null,
    Object? durationMinutes = null,
    Object? availableSlots = null,
    Object? bookedSlots = freezed,
  }) {
    return _then(
      _$AvailableSlotsResponseImpl(
        barberId: null == barberId
            ? _value.barberId
            : barberId // ignore: cast_nullable_to_non_nullable
                  as int,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        availableSlots: null == availableSlots
            ? _value._availableSlots
            : availableSlots // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        bookedSlots: freezed == bookedSlots
            ? _value._bookedSlots
            : bookedSlots // ignore: cast_nullable_to_non_nullable
                  as List<BookedSlot>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableSlotsResponseImpl implements _AvailableSlotsResponse {
  const _$AvailableSlotsResponseImpl({
    @JsonKey(name: 'barber_id') required this.barberId,
    required this.date,
    @JsonKey(name: 'duration_minutes') required this.durationMinutes,
    @JsonKey(name: 'available_slots')
    required final List<String> availableSlots,
    @JsonKey(name: 'booked_slots') final List<BookedSlot>? bookedSlots,
  }) : _availableSlots = availableSlots,
       _bookedSlots = bookedSlots;

  factory _$AvailableSlotsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableSlotsResponseImplFromJson(json);

  @override
  @JsonKey(name: 'barber_id')
  final int barberId;
  @override
  final String date;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  final List<String> _availableSlots;
  @override
  @JsonKey(name: 'available_slots')
  List<String> get availableSlots {
    if (_availableSlots is EqualUnmodifiableListView) return _availableSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSlots);
  }

  final List<BookedSlot>? _bookedSlots;
  @override
  @JsonKey(name: 'booked_slots')
  List<BookedSlot>? get bookedSlots {
    final value = _bookedSlots;
    if (value == null) return null;
    if (_bookedSlots is EqualUnmodifiableListView) return _bookedSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AvailableSlotsResponse(barberId: $barberId, date: $date, durationMinutes: $durationMinutes, availableSlots: $availableSlots, bookedSlots: $bookedSlots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableSlotsResponseImpl &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(
              other._availableSlots,
              _availableSlots,
            ) &&
            const DeepCollectionEquality().equals(
              other._bookedSlots,
              _bookedSlots,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    barberId,
    date,
    durationMinutes,
    const DeepCollectionEquality().hash(_availableSlots),
    const DeepCollectionEquality().hash(_bookedSlots),
  );

  /// Create a copy of AvailableSlotsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableSlotsResponseImplCopyWith<_$AvailableSlotsResponseImpl>
  get copyWith =>
      __$$AvailableSlotsResponseImplCopyWithImpl<_$AvailableSlotsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableSlotsResponseImplToJson(this);
  }
}

abstract class _AvailableSlotsResponse implements AvailableSlotsResponse {
  const factory _AvailableSlotsResponse({
    @JsonKey(name: 'barber_id') required final int barberId,
    required final String date,
    @JsonKey(name: 'duration_minutes') required final int durationMinutes,
    @JsonKey(name: 'available_slots')
    required final List<String> availableSlots,
    @JsonKey(name: 'booked_slots') final List<BookedSlot>? bookedSlots,
  }) = _$AvailableSlotsResponseImpl;

  factory _AvailableSlotsResponse.fromJson(Map<String, dynamic> json) =
      _$AvailableSlotsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'barber_id')
  int get barberId;
  @override
  String get date;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  @JsonKey(name: 'available_slots')
  List<String> get availableSlots;
  @override
  @JsonKey(name: 'booked_slots')
  List<BookedSlot>? get bookedSlots;

  /// Create a copy of AvailableSlotsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableSlotsResponseImplCopyWith<_$AvailableSlotsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BookedSlot _$BookedSlotFromJson(Map<String, dynamic> json) {
  return _BookedSlot.fromJson(json);
}

/// @nodoc
mixin _$BookedSlot {
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  int? get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name')
  String? get clientName => throw _privateConstructorUsedError;

  /// Serializes this BookedSlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookedSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookedSlotCopyWith<BookedSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookedSlotCopyWith<$Res> {
  factory $BookedSlotCopyWith(
    BookedSlot value,
    $Res Function(BookedSlot) then,
  ) = _$BookedSlotCopyWithImpl<$Res, BookedSlot>;
  @useResult
  $Res call({
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'order_id') int? orderId,
    @JsonKey(name: 'client_name') String? clientName,
  });
}

/// @nodoc
class _$BookedSlotCopyWithImpl<$Res, $Val extends BookedSlot>
    implements $BookedSlotCopyWith<$Res> {
  _$BookedSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookedSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? orderId = freezed,
    Object? clientName = freezed,
  }) {
    return _then(
      _value.copyWith(
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            orderId: freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as int?,
            clientName: freezed == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookedSlotImplCopyWith<$Res>
    implements $BookedSlotCopyWith<$Res> {
  factory _$$BookedSlotImplCopyWith(
    _$BookedSlotImpl value,
    $Res Function(_$BookedSlotImpl) then,
  ) = __$$BookedSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'order_id') int? orderId,
    @JsonKey(name: 'client_name') String? clientName,
  });
}

/// @nodoc
class __$$BookedSlotImplCopyWithImpl<$Res>
    extends _$BookedSlotCopyWithImpl<$Res, _$BookedSlotImpl>
    implements _$$BookedSlotImplCopyWith<$Res> {
  __$$BookedSlotImplCopyWithImpl(
    _$BookedSlotImpl _value,
    $Res Function(_$BookedSlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookedSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? orderId = freezed,
    Object? clientName = freezed,
  }) {
    return _then(
      _$BookedSlotImpl(
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: freezed == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as int?,
        clientName: freezed == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookedSlotImpl implements _BookedSlot {
  const _$BookedSlotImpl({
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    @JsonKey(name: 'order_id') this.orderId,
    @JsonKey(name: 'client_name') this.clientName,
  });

  factory _$BookedSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookedSlotImplFromJson(json);

  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  @JsonKey(name: 'order_id')
  final int? orderId;
  @override
  @JsonKey(name: 'client_name')
  final String? clientName;

  @override
  String toString() {
    return 'BookedSlot(startTime: $startTime, endTime: $endTime, orderId: $orderId, clientName: $clientName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookedSlotImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startTime, endTime, orderId, clientName);

  /// Create a copy of BookedSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookedSlotImplCopyWith<_$BookedSlotImpl> get copyWith =>
      __$$BookedSlotImplCopyWithImpl<_$BookedSlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookedSlotImplToJson(this);
  }
}

abstract class _BookedSlot implements BookedSlot {
  const factory _BookedSlot({
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    @JsonKey(name: 'order_id') final int? orderId,
    @JsonKey(name: 'client_name') final String? clientName,
  }) = _$BookedSlotImpl;

  factory _BookedSlot.fromJson(Map<String, dynamic> json) =
      _$BookedSlotImpl.fromJson;

  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  @JsonKey(name: 'order_id')
  int? get orderId;
  @override
  @JsonKey(name: 'client_name')
  String? get clientName;

  /// Create a copy of BookedSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookedSlotImplCopyWith<_$BookedSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
