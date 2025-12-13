// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barber.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Barber _$BarberFromJson(Map<String, dynamic> json) {
  return _Barber.fromJson(json);
}

/// @nodoc
mixin _$Barber {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_id')
  int? get shopId => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_lat')
  double? get locationLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_lng')
  double? get locationLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'schedule_status')
  String? get scheduleStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_avg')
  double? get ratingAvg => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  List<BarberService>? get services => throw _privateConstructorUsedError;
  List<BarberSchedule>? get schedules => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_active_at')
  String? get lastActiveAt => throw _privateConstructorUsedError;

  /// Serializes this Barber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Barber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarberCopyWith<Barber> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarberCopyWith<$Res> {
  factory $BarberCopyWith(Barber value, $Res Function(Barber) then) =
      _$BarberCopyWithImpl<$Res, Barber>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'shop_id') int? shopId,
    String? phone,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    @JsonKey(name: 'schedule_status') String? scheduleStatus,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    double? distance,
    List<BarberService>? services,
    List<BarberSchedule>? schedules,
    @JsonKey(name: 'last_active_at') String? lastActiveAt,
  });
}

/// @nodoc
class _$BarberCopyWithImpl<$Res, $Val extends Barber>
    implements $BarberCopyWith<$Res> {
  _$BarberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Barber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shopId = freezed,
    Object? phone = freezed,
    Object? locationLat = freezed,
    Object? locationLng = freezed,
    Object? scheduleStatus = freezed,
    Object? ratingAvg = freezed,
    Object? distance = freezed,
    Object? services = freezed,
    Object? schedules = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            shopId: freezed == shopId
                ? _value.shopId
                : shopId // ignore: cast_nullable_to_non_nullable
                      as int?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationLat: freezed == locationLat
                ? _value.locationLat
                : locationLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            locationLng: freezed == locationLng
                ? _value.locationLng
                : locationLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            scheduleStatus: freezed == scheduleStatus
                ? _value.scheduleStatus
                : scheduleStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            ratingAvg: freezed == ratingAvg
                ? _value.ratingAvg
                : ratingAvg // ignore: cast_nullable_to_non_nullable
                      as double?,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double?,
            services: freezed == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<BarberService>?,
            schedules: freezed == schedules
                ? _value.schedules
                : schedules // ignore: cast_nullable_to_non_nullable
                      as List<BarberSchedule>?,
            lastActiveAt: freezed == lastActiveAt
                ? _value.lastActiveAt
                : lastActiveAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BarberImplCopyWith<$Res> implements $BarberCopyWith<$Res> {
  factory _$$BarberImplCopyWith(
    _$BarberImpl value,
    $Res Function(_$BarberImpl) then,
  ) = __$$BarberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'shop_id') int? shopId,
    String? phone,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    @JsonKey(name: 'schedule_status') String? scheduleStatus,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    double? distance,
    List<BarberService>? services,
    List<BarberSchedule>? schedules,
    @JsonKey(name: 'last_active_at') String? lastActiveAt,
  });
}

/// @nodoc
class __$$BarberImplCopyWithImpl<$Res>
    extends _$BarberCopyWithImpl<$Res, _$BarberImpl>
    implements _$$BarberImplCopyWith<$Res> {
  __$$BarberImplCopyWithImpl(
    _$BarberImpl _value,
    $Res Function(_$BarberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Barber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shopId = freezed,
    Object? phone = freezed,
    Object? locationLat = freezed,
    Object? locationLng = freezed,
    Object? scheduleStatus = freezed,
    Object? ratingAvg = freezed,
    Object? distance = freezed,
    Object? services = freezed,
    Object? schedules = freezed,
    Object? lastActiveAt = freezed,
  }) {
    return _then(
      _$BarberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        shopId: freezed == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as int?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationLat: freezed == locationLat
            ? _value.locationLat
            : locationLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        locationLng: freezed == locationLng
            ? _value.locationLng
            : locationLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        scheduleStatus: freezed == scheduleStatus
            ? _value.scheduleStatus
            : scheduleStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        ratingAvg: freezed == ratingAvg
            ? _value.ratingAvg
            : ratingAvg // ignore: cast_nullable_to_non_nullable
                  as double?,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double?,
        services: freezed == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<BarberService>?,
        schedules: freezed == schedules
            ? _value._schedules
            : schedules // ignore: cast_nullable_to_non_nullable
                  as List<BarberSchedule>?,
        lastActiveAt: freezed == lastActiveAt
            ? _value.lastActiveAt
            : lastActiveAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BarberImpl implements _Barber {
  const _$BarberImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'shop_id') this.shopId,
    this.phone,
    @JsonKey(name: 'location_lat') this.locationLat,
    @JsonKey(name: 'location_lng') this.locationLng,
    @JsonKey(name: 'schedule_status') this.scheduleStatus,
    @JsonKey(name: 'rating_avg') this.ratingAvg,
    this.distance,
    final List<BarberService>? services,
    final List<BarberSchedule>? schedules,
    @JsonKey(name: 'last_active_at') this.lastActiveAt,
  }) : _services = services,
       _schedules = schedules;

  factory _$BarberImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarberImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'shop_id')
  final int? shopId;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'location_lat')
  final double? locationLat;
  @override
  @JsonKey(name: 'location_lng')
  final double? locationLng;
  @override
  @JsonKey(name: 'schedule_status')
  final String? scheduleStatus;
  @override
  @JsonKey(name: 'rating_avg')
  final double? ratingAvg;
  @override
  final double? distance;
  final List<BarberService>? _services;
  @override
  List<BarberService>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<BarberSchedule>? _schedules;
  @override
  List<BarberSchedule>? get schedules {
    final value = _schedules;
    if (value == null) return null;
    if (_schedules is EqualUnmodifiableListView) return _schedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'last_active_at')
  final String? lastActiveAt;

  @override
  String toString() {
    return 'Barber(id: $id, name: $name, shopId: $shopId, phone: $phone, locationLat: $locationLat, locationLng: $locationLng, scheduleStatus: $scheduleStatus, ratingAvg: $ratingAvg, distance: $distance, services: $services, schedules: $schedules, lastActiveAt: $lastActiveAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.locationLat, locationLat) ||
                other.locationLat == locationLat) &&
            (identical(other.locationLng, locationLng) ||
                other.locationLng == locationLng) &&
            (identical(other.scheduleStatus, scheduleStatus) ||
                other.scheduleStatus == scheduleStatus) &&
            (identical(other.ratingAvg, ratingAvg) ||
                other.ratingAvg == ratingAvg) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality().equals(
              other._schedules,
              _schedules,
            ) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    shopId,
    phone,
    locationLat,
    locationLng,
    scheduleStatus,
    ratingAvg,
    distance,
    const DeepCollectionEquality().hash(_services),
    const DeepCollectionEquality().hash(_schedules),
    lastActiveAt,
  );

  /// Create a copy of Barber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarberImplCopyWith<_$BarberImpl> get copyWith =>
      __$$BarberImplCopyWithImpl<_$BarberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BarberImplToJson(this);
  }
}

abstract class _Barber implements Barber {
  const factory _Barber({
    required final int id,
    required final String name,
    @JsonKey(name: 'shop_id') final int? shopId,
    final String? phone,
    @JsonKey(name: 'location_lat') final double? locationLat,
    @JsonKey(name: 'location_lng') final double? locationLng,
    @JsonKey(name: 'schedule_status') final String? scheduleStatus,
    @JsonKey(name: 'rating_avg') final double? ratingAvg,
    final double? distance,
    final List<BarberService>? services,
    final List<BarberSchedule>? schedules,
    @JsonKey(name: 'last_active_at') final String? lastActiveAt,
  }) = _$BarberImpl;

  factory _Barber.fromJson(Map<String, dynamic> json) = _$BarberImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'shop_id')
  int? get shopId;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'location_lat')
  double? get locationLat;
  @override
  @JsonKey(name: 'location_lng')
  double? get locationLng;
  @override
  @JsonKey(name: 'schedule_status')
  String? get scheduleStatus;
  @override
  @JsonKey(name: 'rating_avg')
  double? get ratingAvg;
  @override
  double? get distance;
  @override
  List<BarberService>? get services;
  @override
  List<BarberSchedule>? get schedules;
  @override
  @JsonKey(name: 'last_active_at')
  String? get lastActiveAt;

  /// Create a copy of Barber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarberImplCopyWith<_$BarberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BarberService _$BarberServiceFromJson(Map<String, dynamic> json) {
  return _BarberService.fromJson(json);
}

/// @nodoc
mixin _$BarberService {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this BarberService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BarberService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarberServiceCopyWith<BarberService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarberServiceCopyWith<$Res> {
  factory $BarberServiceCopyWith(
    BarberService value,
    $Res Function(BarberService) then,
  ) = _$BarberServiceCopyWithImpl<$Res, BarberService>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$BarberServiceCopyWithImpl<$Res, $Val extends BarberService>
    implements $BarberServiceCopyWith<$Res> {
  _$BarberServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BarberService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BarberServiceImplCopyWith<$Res>
    implements $BarberServiceCopyWith<$Res> {
  factory _$$BarberServiceImplCopyWith(
    _$BarberServiceImpl value,
    $Res Function(_$BarberServiceImpl) then,
  ) = __$$BarberServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$BarberServiceImplCopyWithImpl<$Res>
    extends _$BarberServiceCopyWithImpl<$Res, _$BarberServiceImpl>
    implements _$$BarberServiceImplCopyWith<$Res> {
  __$$BarberServiceImplCopyWithImpl(
    _$BarberServiceImpl _value,
    $Res Function(_$BarberServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BarberService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$BarberServiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BarberServiceImpl implements _BarberService {
  const _$BarberServiceImpl({required this.id, required this.name});

  factory _$BarberServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarberServiceImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'BarberService(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarberServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of BarberService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarberServiceImplCopyWith<_$BarberServiceImpl> get copyWith =>
      __$$BarberServiceImplCopyWithImpl<_$BarberServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BarberServiceImplToJson(this);
  }
}

abstract class _BarberService implements BarberService {
  const factory _BarberService({
    required final int id,
    required final String name,
  }) = _$BarberServiceImpl;

  factory _BarberService.fromJson(Map<String, dynamic> json) =
      _$BarberServiceImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of BarberService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarberServiceImplCopyWith<_$BarberServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BarberSchedule _$BarberScheduleFromJson(Map<String, dynamic> json) {
  return _BarberSchedule.fromJson(json);
}

/// @nodoc
mixin _$BarberSchedule {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'barber_id')
  int get barberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_of_week')
  int get dayOfWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'break_start')
  String? get breakStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'break_end')
  String? get breakEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this BarberSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BarberSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarberScheduleCopyWith<BarberSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarberScheduleCopyWith<$Res> {
  factory $BarberScheduleCopyWith(
    BarberSchedule value,
    $Res Function(BarberSchedule) then,
  ) = _$BarberScheduleCopyWithImpl<$Res, BarberSchedule>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'day_of_week') int dayOfWeek,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'break_start') String? breakStart,
    @JsonKey(name: 'break_end') String? breakEnd,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$BarberScheduleCopyWithImpl<$Res, $Val extends BarberSchedule>
    implements $BarberScheduleCopyWith<$Res> {
  _$BarberScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BarberSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barberId = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? breakStart = freezed,
    Object? breakEnd = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            barberId: null == barberId
                ? _value.barberId
                : barberId // ignore: cast_nullable_to_non_nullable
                      as int,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            breakStart: freezed == breakStart
                ? _value.breakStart
                : breakStart // ignore: cast_nullable_to_non_nullable
                      as String?,
            breakEnd: freezed == breakEnd
                ? _value.breakEnd
                : breakEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BarberScheduleImplCopyWith<$Res>
    implements $BarberScheduleCopyWith<$Res> {
  factory _$$BarberScheduleImplCopyWith(
    _$BarberScheduleImpl value,
    $Res Function(_$BarberScheduleImpl) then,
  ) = __$$BarberScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'day_of_week') int dayOfWeek,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'break_start') String? breakStart,
    @JsonKey(name: 'break_end') String? breakEnd,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$BarberScheduleImplCopyWithImpl<$Res>
    extends _$BarberScheduleCopyWithImpl<$Res, _$BarberScheduleImpl>
    implements _$$BarberScheduleImplCopyWith<$Res> {
  __$$BarberScheduleImplCopyWithImpl(
    _$BarberScheduleImpl _value,
    $Res Function(_$BarberScheduleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BarberSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barberId = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? breakStart = freezed,
    Object? breakEnd = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$BarberScheduleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        barberId: null == barberId
            ? _value.barberId
            : barberId // ignore: cast_nullable_to_non_nullable
                  as int,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        breakStart: freezed == breakStart
            ? _value.breakStart
            : breakStart // ignore: cast_nullable_to_non_nullable
                  as String?,
        breakEnd: freezed == breakEnd
            ? _value.breakEnd
            : breakEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BarberScheduleImpl implements _BarberSchedule {
  const _$BarberScheduleImpl({
    required this.id,
    @JsonKey(name: 'barber_id') required this.barberId,
    @JsonKey(name: 'day_of_week') required this.dayOfWeek,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    @JsonKey(name: 'break_start') this.breakStart,
    @JsonKey(name: 'break_end') this.breakEnd,
    @JsonKey(name: 'is_active') required this.isActive,
  });

  factory _$BarberScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarberScheduleImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'barber_id')
  final int barberId;
  @override
  @JsonKey(name: 'day_of_week')
  final int dayOfWeek;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  @JsonKey(name: 'break_start')
  final String? breakStart;
  @override
  @JsonKey(name: 'break_end')
  final String? breakEnd;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'BarberSchedule(id: $id, barberId: $barberId, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, breakStart: $breakStart, breakEnd: $breakEnd, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarberScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.breakStart, breakStart) ||
                other.breakStart == breakStart) &&
            (identical(other.breakEnd, breakEnd) ||
                other.breakEnd == breakEnd) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    barberId,
    dayOfWeek,
    startTime,
    endTime,
    breakStart,
    breakEnd,
    isActive,
  );

  /// Create a copy of BarberSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarberScheduleImplCopyWith<_$BarberScheduleImpl> get copyWith =>
      __$$BarberScheduleImplCopyWithImpl<_$BarberScheduleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BarberScheduleImplToJson(this);
  }
}

abstract class _BarberSchedule implements BarberSchedule {
  const factory _BarberSchedule({
    required final int id,
    @JsonKey(name: 'barber_id') required final int barberId,
    @JsonKey(name: 'day_of_week') required final int dayOfWeek,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    @JsonKey(name: 'break_start') final String? breakStart,
    @JsonKey(name: 'break_end') final String? breakEnd,
    @JsonKey(name: 'is_active') required final bool isActive,
  }) = _$BarberScheduleImpl;

  factory _BarberSchedule.fromJson(Map<String, dynamic> json) =
      _$BarberScheduleImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'barber_id')
  int get barberId;
  @override
  @JsonKey(name: 'day_of_week')
  int get dayOfWeek;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  @JsonKey(name: 'break_start')
  String? get breakStart;
  @override
  @JsonKey(name: 'break_end')
  String? get breakEnd;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of BarberSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarberScheduleImplCopyWith<_$BarberScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
