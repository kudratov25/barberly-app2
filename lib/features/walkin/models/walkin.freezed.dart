// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'walkin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WalkIn _$WalkInFromJson(Map<String, dynamic> json) {
  return _WalkIn.fromJson(json);
}

/// @nodoc
mixin _$WalkIn {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'barber_id')
  int get barberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_phone')
  String get clientPhone => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  String? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'finished_at')
  String? get finishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  WalkInBarber? get barber => throw _privateConstructorUsedError;

  /// Serializes this WalkIn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalkIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalkInCopyWith<WalkIn> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalkInCopyWith<$Res> {
  factory $WalkInCopyWith(WalkIn value, $Res Function(WalkIn) then) =
      _$WalkInCopyWithImpl<$Res, WalkIn>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'client_name') String clientName,
    @JsonKey(name: 'client_phone') String clientPhone,
    String status,
    int? price,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'finished_at') String? finishedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    WalkInBarber? barber,
  });

  $WalkInBarberCopyWith<$Res>? get barber;
}

/// @nodoc
class _$WalkInCopyWithImpl<$Res, $Val extends WalkIn>
    implements $WalkInCopyWith<$Res> {
  _$WalkInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalkIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barberId = null,
    Object? clientName = null,
    Object? clientPhone = null,
    Object? status = null,
    Object? price = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? createdAt = freezed,
    Object? barber = freezed,
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
            clientName: null == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String,
            clientPhone: null == clientPhone
                ? _value.clientPhone
                : clientPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            finishedAt: freezed == finishedAt
                ? _value.finishedAt
                : finishedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            barber: freezed == barber
                ? _value.barber
                : barber // ignore: cast_nullable_to_non_nullable
                      as WalkInBarber?,
          )
          as $Val,
    );
  }

  /// Create a copy of WalkIn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalkInBarberCopyWith<$Res>? get barber {
    if (_value.barber == null) {
      return null;
    }

    return $WalkInBarberCopyWith<$Res>(_value.barber!, (value) {
      return _then(_value.copyWith(barber: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalkInImplCopyWith<$Res> implements $WalkInCopyWith<$Res> {
  factory _$$WalkInImplCopyWith(
    _$WalkInImpl value,
    $Res Function(_$WalkInImpl) then,
  ) = __$$WalkInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'client_name') String clientName,
    @JsonKey(name: 'client_phone') String clientPhone,
    String status,
    int? price,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'finished_at') String? finishedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    WalkInBarber? barber,
  });

  @override
  $WalkInBarberCopyWith<$Res>? get barber;
}

/// @nodoc
class __$$WalkInImplCopyWithImpl<$Res>
    extends _$WalkInCopyWithImpl<$Res, _$WalkInImpl>
    implements _$$WalkInImplCopyWith<$Res> {
  __$$WalkInImplCopyWithImpl(
    _$WalkInImpl _value,
    $Res Function(_$WalkInImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalkIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barberId = null,
    Object? clientName = null,
    Object? clientPhone = null,
    Object? status = null,
    Object? price = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? createdAt = freezed,
    Object? barber = freezed,
  }) {
    return _then(
      _$WalkInImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        barberId: null == barberId
            ? _value.barberId
            : barberId // ignore: cast_nullable_to_non_nullable
                  as int,
        clientName: null == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String,
        clientPhone: null == clientPhone
            ? _value.clientPhone
            : clientPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        finishedAt: freezed == finishedAt
            ? _value.finishedAt
            : finishedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        barber: freezed == barber
            ? _value.barber
            : barber // ignore: cast_nullable_to_non_nullable
                  as WalkInBarber?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalkInImpl implements _WalkIn {
  const _$WalkInImpl({
    required this.id,
    @JsonKey(name: 'barber_id') required this.barberId,
    @JsonKey(name: 'client_name') required this.clientName,
    @JsonKey(name: 'client_phone') required this.clientPhone,
    required this.status,
    this.price,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'finished_at') this.finishedAt,
    @JsonKey(name: 'created_at') this.createdAt,
    this.barber,
  });

  factory _$WalkInImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalkInImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'barber_id')
  final int barberId;
  @override
  @JsonKey(name: 'client_name')
  final String clientName;
  @override
  @JsonKey(name: 'client_phone')
  final String clientPhone;
  @override
  final String status;
  @override
  final int? price;
  @override
  @JsonKey(name: 'started_at')
  final String? startedAt;
  @override
  @JsonKey(name: 'finished_at')
  final String? finishedAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final WalkInBarber? barber;

  @override
  String toString() {
    return 'WalkIn(id: $id, barberId: $barberId, clientName: $clientName, clientPhone: $clientPhone, status: $status, price: $price, startedAt: $startedAt, finishedAt: $finishedAt, createdAt: $createdAt, barber: $barber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalkInImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientPhone, clientPhone) ||
                other.clientPhone == clientPhone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.barber, barber) || other.barber == barber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    barberId,
    clientName,
    clientPhone,
    status,
    price,
    startedAt,
    finishedAt,
    createdAt,
    barber,
  );

  /// Create a copy of WalkIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalkInImplCopyWith<_$WalkInImpl> get copyWith =>
      __$$WalkInImplCopyWithImpl<_$WalkInImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalkInImplToJson(this);
  }
}

abstract class _WalkIn implements WalkIn {
  const factory _WalkIn({
    required final int id,
    @JsonKey(name: 'barber_id') required final int barberId,
    @JsonKey(name: 'client_name') required final String clientName,
    @JsonKey(name: 'client_phone') required final String clientPhone,
    required final String status,
    final int? price,
    @JsonKey(name: 'started_at') final String? startedAt,
    @JsonKey(name: 'finished_at') final String? finishedAt,
    @JsonKey(name: 'created_at') final String? createdAt,
    final WalkInBarber? barber,
  }) = _$WalkInImpl;

  factory _WalkIn.fromJson(Map<String, dynamic> json) = _$WalkInImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'barber_id')
  int get barberId;
  @override
  @JsonKey(name: 'client_name')
  String get clientName;
  @override
  @JsonKey(name: 'client_phone')
  String get clientPhone;
  @override
  String get status;
  @override
  int? get price;
  @override
  @JsonKey(name: 'started_at')
  String? get startedAt;
  @override
  @JsonKey(name: 'finished_at')
  String? get finishedAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  WalkInBarber? get barber;

  /// Create a copy of WalkIn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalkInImplCopyWith<_$WalkInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WalkInBarber _$WalkInBarberFromJson(Map<String, dynamic> json) {
  return _WalkInBarber.fromJson(json);
}

/// @nodoc
mixin _$WalkInBarber {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this WalkInBarber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalkInBarber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalkInBarberCopyWith<WalkInBarber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalkInBarberCopyWith<$Res> {
  factory $WalkInBarberCopyWith(
    WalkInBarber value,
    $Res Function(WalkInBarber) then,
  ) = _$WalkInBarberCopyWithImpl<$Res, WalkInBarber>;
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class _$WalkInBarberCopyWithImpl<$Res, $Val extends WalkInBarber>
    implements $WalkInBarberCopyWith<$Res> {
  _$WalkInBarberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalkInBarber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? phone = freezed}) {
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
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalkInBarberImplCopyWith<$Res>
    implements $WalkInBarberCopyWith<$Res> {
  factory _$$WalkInBarberImplCopyWith(
    _$WalkInBarberImpl value,
    $Res Function(_$WalkInBarberImpl) then,
  ) = __$$WalkInBarberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class __$$WalkInBarberImplCopyWithImpl<$Res>
    extends _$WalkInBarberCopyWithImpl<$Res, _$WalkInBarberImpl>
    implements _$$WalkInBarberImplCopyWith<$Res> {
  __$$WalkInBarberImplCopyWithImpl(
    _$WalkInBarberImpl _value,
    $Res Function(_$WalkInBarberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalkInBarber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? phone = freezed}) {
    return _then(
      _$WalkInBarberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalkInBarberImpl implements _WalkInBarber {
  const _$WalkInBarberImpl({required this.id, required this.name, this.phone});

  factory _$WalkInBarberImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalkInBarberImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'WalkInBarber(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalkInBarberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  /// Create a copy of WalkInBarber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalkInBarberImplCopyWith<_$WalkInBarberImpl> get copyWith =>
      __$$WalkInBarberImplCopyWithImpl<_$WalkInBarberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalkInBarberImplToJson(this);
  }
}

abstract class _WalkInBarber implements WalkInBarber {
  const factory _WalkInBarber({
    required final int id,
    required final String name,
    final String? phone,
  }) = _$WalkInBarberImpl;

  factory _WalkInBarber.fromJson(Map<String, dynamic> json) =
      _$WalkInBarberImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get phone;

  /// Create a copy of WalkInBarber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalkInBarberImplCopyWith<_$WalkInBarberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
