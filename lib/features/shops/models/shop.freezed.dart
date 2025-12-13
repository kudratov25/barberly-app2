// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShopOwner _$ShopOwnerFromJson(Map<String, dynamic> json) {
  return _ShopOwner.fromJson(json);
}

/// @nodoc
mixin _$ShopOwner {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this ShopOwner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopOwnerCopyWith<ShopOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopOwnerCopyWith<$Res> {
  factory $ShopOwnerCopyWith(ShopOwner value, $Res Function(ShopOwner) then) =
      _$ShopOwnerCopyWithImpl<$Res, ShopOwner>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$ShopOwnerCopyWithImpl<$Res, $Val extends ShopOwner>
    implements $ShopOwnerCopyWith<$Res> {
  _$ShopOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopOwner
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
abstract class _$$ShopOwnerImplCopyWith<$Res>
    implements $ShopOwnerCopyWith<$Res> {
  factory _$$ShopOwnerImplCopyWith(
    _$ShopOwnerImpl value,
    $Res Function(_$ShopOwnerImpl) then,
  ) = __$$ShopOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$ShopOwnerImplCopyWithImpl<$Res>
    extends _$ShopOwnerCopyWithImpl<$Res, _$ShopOwnerImpl>
    implements _$$ShopOwnerImplCopyWith<$Res> {
  __$$ShopOwnerImplCopyWithImpl(
    _$ShopOwnerImpl _value,
    $Res Function(_$ShopOwnerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$ShopOwnerImpl(
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
class _$ShopOwnerImpl implements _ShopOwner {
  const _$ShopOwnerImpl({required this.id, required this.name});

  factory _$ShopOwnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopOwnerImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'ShopOwner(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopOwnerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of ShopOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopOwnerImplCopyWith<_$ShopOwnerImpl> get copyWith =>
      __$$ShopOwnerImplCopyWithImpl<_$ShopOwnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopOwnerImplToJson(this);
  }
}

abstract class _ShopOwner implements ShopOwner {
  const factory _ShopOwner({
    required final int id,
    required final String name,
  }) = _$ShopOwnerImpl;

  factory _ShopOwner.fromJson(Map<String, dynamic> json) =
      _$ShopOwnerImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of ShopOwner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopOwnerImplCopyWith<_$ShopOwnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) {
  return _SubscriptionPlan.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPlan {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_days')
  int? get durationDays => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPlanCopyWith<SubscriptionPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPlanCopyWith<$Res> {
  factory $SubscriptionPlanCopyWith(
    SubscriptionPlan value,
    $Res Function(SubscriptionPlan) then,
  ) = _$SubscriptionPlanCopyWithImpl<$Res, SubscriptionPlan>;
  @useResult
  $Res call({
    int id,
    String name,
    int? price,
    @JsonKey(name: 'duration_days') int? durationDays,
  });
}

/// @nodoc
class _$SubscriptionPlanCopyWithImpl<$Res, $Val extends SubscriptionPlan>
    implements $SubscriptionPlanCopyWith<$Res> {
  _$SubscriptionPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = freezed,
    Object? durationDays = freezed,
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
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int?,
            durationDays: freezed == durationDays
                ? _value.durationDays
                : durationDays // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionPlanImplCopyWith<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  factory _$$SubscriptionPlanImplCopyWith(
    _$SubscriptionPlanImpl value,
    $Res Function(_$SubscriptionPlanImpl) then,
  ) = __$$SubscriptionPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    int? price,
    @JsonKey(name: 'duration_days') int? durationDays,
  });
}

/// @nodoc
class __$$SubscriptionPlanImplCopyWithImpl<$Res>
    extends _$SubscriptionPlanCopyWithImpl<$Res, _$SubscriptionPlanImpl>
    implements _$$SubscriptionPlanImplCopyWith<$Res> {
  __$$SubscriptionPlanImplCopyWithImpl(
    _$SubscriptionPlanImpl _value,
    $Res Function(_$SubscriptionPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = freezed,
    Object? durationDays = freezed,
  }) {
    return _then(
      _$SubscriptionPlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int?,
        durationDays: freezed == durationDays
            ? _value.durationDays
            : durationDays // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionPlanImpl implements _SubscriptionPlan {
  const _$SubscriptionPlanImpl({
    required this.id,
    required this.name,
    this.price,
    @JsonKey(name: 'duration_days') this.durationDays,
  });

  factory _$SubscriptionPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPlanImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int? price;
  @override
  @JsonKey(name: 'duration_days')
  final int? durationDays;

  @override
  String toString() {
    return 'SubscriptionPlan(id: $id, name: $name, price: $price, durationDays: $durationDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, durationDays);

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      __$$SubscriptionPlanImplCopyWithImpl<_$SubscriptionPlanImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPlanImplToJson(this);
  }
}

abstract class _SubscriptionPlan implements SubscriptionPlan {
  const factory _SubscriptionPlan({
    required final int id,
    required final String name,
    final int? price,
    @JsonKey(name: 'duration_days') final int? durationDays,
  }) = _$SubscriptionPlanImpl;

  factory _SubscriptionPlan.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPlanImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int? get price;
  @override
  @JsonKey(name: 'duration_days')
  int? get durationDays;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return _Shop.fromJson(json);
}

/// @nodoc
mixin _$Shop {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address =>
      throw _privateConstructorUsedError; // Null bo'lishi mumkin
  String get phone => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_lat')
  double? get locationLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_lng')
  double? get locationLng => throw _privateConstructorUsedError;
  ShopOwner? get owner => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_plan')
  SubscriptionPlan? get subscriptionPlan => throw _privateConstructorUsedError;
  List<ShopService>? get services => throw _privateConstructorUsedError;
  List<ShopWorker>? get workers => throw _privateConstructorUsedError;

  /// Serializes this Shop to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopCopyWith<Shop> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopCopyWith<$Res> {
  factory $ShopCopyWith(Shop value, $Res Function(Shop) then) =
      _$ShopCopyWithImpl<$Res, Shop>;
  @useResult
  $Res call({
    int id,
    String name,
    String? address,
    String phone,
    String status,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    ShopOwner? owner,
    @JsonKey(name: 'subscription_plan') SubscriptionPlan? subscriptionPlan,
    List<ShopService>? services,
    List<ShopWorker>? workers,
  });

  $ShopOwnerCopyWith<$Res>? get owner;
  $SubscriptionPlanCopyWith<$Res>? get subscriptionPlan;
}

/// @nodoc
class _$ShopCopyWithImpl<$Res, $Val extends Shop>
    implements $ShopCopyWith<$Res> {
  _$ShopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
    Object? phone = null,
    Object? status = null,
    Object? locationLat = freezed,
    Object? locationLng = freezed,
    Object? owner = freezed,
    Object? subscriptionPlan = freezed,
    Object? services = freezed,
    Object? workers = freezed,
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
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            locationLat: freezed == locationLat
                ? _value.locationLat
                : locationLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            locationLng: freezed == locationLng
                ? _value.locationLng
                : locationLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            owner: freezed == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                      as ShopOwner?,
            subscriptionPlan: freezed == subscriptionPlan
                ? _value.subscriptionPlan
                : subscriptionPlan // ignore: cast_nullable_to_non_nullable
                      as SubscriptionPlan?,
            services: freezed == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<ShopService>?,
            workers: freezed == workers
                ? _value.workers
                : workers // ignore: cast_nullable_to_non_nullable
                      as List<ShopWorker>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopOwnerCopyWith<$Res>? get owner {
    if (_value.owner == null) {
      return null;
    }

    return $ShopOwnerCopyWith<$Res>(_value.owner!, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanCopyWith<$Res>? get subscriptionPlan {
    if (_value.subscriptionPlan == null) {
      return null;
    }

    return $SubscriptionPlanCopyWith<$Res>(_value.subscriptionPlan!, (value) {
      return _then(_value.copyWith(subscriptionPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShopImplCopyWith<$Res> implements $ShopCopyWith<$Res> {
  factory _$$ShopImplCopyWith(
    _$ShopImpl value,
    $Res Function(_$ShopImpl) then,
  ) = __$$ShopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? address,
    String phone,
    String status,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    ShopOwner? owner,
    @JsonKey(name: 'subscription_plan') SubscriptionPlan? subscriptionPlan,
    List<ShopService>? services,
    List<ShopWorker>? workers,
  });

  @override
  $ShopOwnerCopyWith<$Res>? get owner;
  @override
  $SubscriptionPlanCopyWith<$Res>? get subscriptionPlan;
}

/// @nodoc
class __$$ShopImplCopyWithImpl<$Res>
    extends _$ShopCopyWithImpl<$Res, _$ShopImpl>
    implements _$$ShopImplCopyWith<$Res> {
  __$$ShopImplCopyWithImpl(_$ShopImpl _value, $Res Function(_$ShopImpl) _then)
    : super(_value, _then);

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
    Object? phone = null,
    Object? status = null,
    Object? locationLat = freezed,
    Object? locationLng = freezed,
    Object? owner = freezed,
    Object? subscriptionPlan = freezed,
    Object? services = freezed,
    Object? workers = freezed,
  }) {
    return _then(
      _$ShopImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        locationLat: freezed == locationLat
            ? _value.locationLat
            : locationLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        locationLng: freezed == locationLng
            ? _value.locationLng
            : locationLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        owner: freezed == owner
            ? _value.owner
            : owner // ignore: cast_nullable_to_non_nullable
                  as ShopOwner?,
        subscriptionPlan: freezed == subscriptionPlan
            ? _value.subscriptionPlan
            : subscriptionPlan // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlan?,
        services: freezed == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<ShopService>?,
        workers: freezed == workers
            ? _value._workers
            : workers // ignore: cast_nullable_to_non_nullable
                  as List<ShopWorker>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopImpl implements _Shop {
  const _$ShopImpl({
    required this.id,
    required this.name,
    this.address,
    required this.phone,
    required this.status,
    @JsonKey(name: 'location_lat') this.locationLat,
    @JsonKey(name: 'location_lng') this.locationLng,
    this.owner,
    @JsonKey(name: 'subscription_plan') this.subscriptionPlan,
    final List<ShopService>? services,
    final List<ShopWorker>? workers,
  }) : _services = services,
       _workers = workers;

  factory _$ShopImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? address;
  // Null bo'lishi mumkin
  @override
  final String phone;
  @override
  final String status;
  @override
  @JsonKey(name: 'location_lat')
  final double? locationLat;
  @override
  @JsonKey(name: 'location_lng')
  final double? locationLng;
  @override
  final ShopOwner? owner;
  @override
  @JsonKey(name: 'subscription_plan')
  final SubscriptionPlan? subscriptionPlan;
  final List<ShopService>? _services;
  @override
  List<ShopService>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ShopWorker>? _workers;
  @override
  List<ShopWorker>? get workers {
    final value = _workers;
    if (value == null) return null;
    if (_workers is EqualUnmodifiableListView) return _workers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, address: $address, phone: $phone, status: $status, locationLat: $locationLat, locationLng: $locationLng, owner: $owner, subscriptionPlan: $subscriptionPlan, services: $services, workers: $workers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.locationLat, locationLat) ||
                other.locationLat == locationLat) &&
            (identical(other.locationLng, locationLng) ||
                other.locationLng == locationLng) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.subscriptionPlan, subscriptionPlan) ||
                other.subscriptionPlan == subscriptionPlan) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality().equals(other._workers, _workers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    phone,
    status,
    locationLat,
    locationLng,
    owner,
    subscriptionPlan,
    const DeepCollectionEquality().hash(_services),
    const DeepCollectionEquality().hash(_workers),
  );

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      __$$ShopImplCopyWithImpl<_$ShopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopImplToJson(this);
  }
}

abstract class _Shop implements Shop {
  const factory _Shop({
    required final int id,
    required final String name,
    final String? address,
    required final String phone,
    required final String status,
    @JsonKey(name: 'location_lat') final double? locationLat,
    @JsonKey(name: 'location_lng') final double? locationLng,
    final ShopOwner? owner,
    @JsonKey(name: 'subscription_plan')
    final SubscriptionPlan? subscriptionPlan,
    final List<ShopService>? services,
    final List<ShopWorker>? workers,
  }) = _$ShopImpl;

  factory _Shop.fromJson(Map<String, dynamic> json) = _$ShopImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get address; // Null bo'lishi mumkin
  @override
  String get phone;
  @override
  String get status;
  @override
  @JsonKey(name: 'location_lat')
  double? get locationLat;
  @override
  @JsonKey(name: 'location_lng')
  double? get locationLng;
  @override
  ShopOwner? get owner;
  @override
  @JsonKey(name: 'subscription_plan')
  SubscriptionPlan? get subscriptionPlan;
  @override
  List<ShopService>? get services;
  @override
  List<ShopWorker>? get workers;

  /// Create a copy of Shop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopImplCopyWith<_$ShopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopService _$ShopServiceFromJson(Map<String, dynamic> json) {
  return _ShopService.fromJson(json);
}

/// @nodoc
mixin _$ShopService {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;

  /// Serializes this ShopService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopServiceCopyWith<ShopService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopServiceCopyWith<$Res> {
  factory $ShopServiceCopyWith(
    ShopService value,
    $Res Function(ShopService) then,
  ) = _$ShopServiceCopyWithImpl<$Res, ShopService>;
  @useResult
  $Res call({
    int id,
    String name,
    int price,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
  });
}

/// @nodoc
class _$ShopServiceCopyWithImpl<$Res, $Val extends ShopService>
    implements $ShopServiceCopyWith<$Res> {
  _$ShopServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? durationMinutes = null,
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
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShopServiceImplCopyWith<$Res>
    implements $ShopServiceCopyWith<$Res> {
  factory _$$ShopServiceImplCopyWith(
    _$ShopServiceImpl value,
    $Res Function(_$ShopServiceImpl) then,
  ) = __$$ShopServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    int price,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
  });
}

/// @nodoc
class __$$ShopServiceImplCopyWithImpl<$Res>
    extends _$ShopServiceCopyWithImpl<$Res, _$ShopServiceImpl>
    implements _$$ShopServiceImplCopyWith<$Res> {
  __$$ShopServiceImplCopyWithImpl(
    _$ShopServiceImpl _value,
    $Res Function(_$ShopServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? durationMinutes = null,
  }) {
    return _then(
      _$ShopServiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopServiceImpl implements _ShopService {
  const _$ShopServiceImpl({
    required this.id,
    required this.name,
    required this.price,
    @JsonKey(name: 'duration_minutes') required this.durationMinutes,
  });

  factory _$ShopServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopServiceImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int price;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;

  @override
  String toString() {
    return 'ShopService(id: $id, name: $name, price: $price, durationMinutes: $durationMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, price, durationMinutes);

  /// Create a copy of ShopService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopServiceImplCopyWith<_$ShopServiceImpl> get copyWith =>
      __$$ShopServiceImplCopyWithImpl<_$ShopServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopServiceImplToJson(this);
  }
}

abstract class _ShopService implements ShopService {
  const factory _ShopService({
    required final int id,
    required final String name,
    required final int price,
    @JsonKey(name: 'duration_minutes') required final int durationMinutes,
  }) = _$ShopServiceImpl;

  factory _ShopService.fromJson(Map<String, dynamic> json) =
      _$ShopServiceImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get price;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;

  /// Create a copy of ShopService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopServiceImplCopyWith<_$ShopServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopWorker _$ShopWorkerFromJson(Map<String, dynamic> json) {
  return _ShopWorker.fromJson(json);
}

/// @nodoc
mixin _$ShopWorker {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_avg')
  double? get ratingAvg => throw _privateConstructorUsedError;
  List<ShopService>? get services => throw _privateConstructorUsedError;

  /// Serializes this ShopWorker to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopWorker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopWorkerCopyWith<ShopWorker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopWorkerCopyWith<$Res> {
  factory $ShopWorkerCopyWith(
    ShopWorker value,
    $Res Function(ShopWorker) then,
  ) = _$ShopWorkerCopyWithImpl<$Res, ShopWorker>;
  @useResult
  $Res call({
    int id,
    String name,
    String? phone,
    String? role,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    List<ShopService>? services,
  });
}

/// @nodoc
class _$ShopWorkerCopyWithImpl<$Res, $Val extends ShopWorker>
    implements $ShopWorkerCopyWith<$Res> {
  _$ShopWorkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopWorker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? role = freezed,
    Object? ratingAvg = freezed,
    Object? services = freezed,
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
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            ratingAvg: freezed == ratingAvg
                ? _value.ratingAvg
                : ratingAvg // ignore: cast_nullable_to_non_nullable
                      as double?,
            services: freezed == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<ShopService>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShopWorkerImplCopyWith<$Res>
    implements $ShopWorkerCopyWith<$Res> {
  factory _$$ShopWorkerImplCopyWith(
    _$ShopWorkerImpl value,
    $Res Function(_$ShopWorkerImpl) then,
  ) = __$$ShopWorkerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? phone,
    String? role,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    List<ShopService>? services,
  });
}

/// @nodoc
class __$$ShopWorkerImplCopyWithImpl<$Res>
    extends _$ShopWorkerCopyWithImpl<$Res, _$ShopWorkerImpl>
    implements _$$ShopWorkerImplCopyWith<$Res> {
  __$$ShopWorkerImplCopyWithImpl(
    _$ShopWorkerImpl _value,
    $Res Function(_$ShopWorkerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopWorker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? role = freezed,
    Object? ratingAvg = freezed,
    Object? services = freezed,
  }) {
    return _then(
      _$ShopWorkerImpl(
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
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        ratingAvg: freezed == ratingAvg
            ? _value.ratingAvg
            : ratingAvg // ignore: cast_nullable_to_non_nullable
                  as double?,
        services: freezed == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<ShopService>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopWorkerImpl implements _ShopWorker {
  const _$ShopWorkerImpl({
    required this.id,
    required this.name,
    this.phone,
    this.role,
    @JsonKey(name: 'rating_avg') this.ratingAvg,
    final List<ShopService>? services,
  }) : _services = services;

  factory _$ShopWorkerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopWorkerImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? role;
  @override
  @JsonKey(name: 'rating_avg')
  final double? ratingAvg;
  final List<ShopService>? _services;
  @override
  List<ShopService>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ShopWorker(id: $id, name: $name, phone: $phone, role: $role, ratingAvg: $ratingAvg, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopWorkerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.ratingAvg, ratingAvg) ||
                other.ratingAvg == ratingAvg) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    phone,
    role,
    ratingAvg,
    const DeepCollectionEquality().hash(_services),
  );

  /// Create a copy of ShopWorker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopWorkerImplCopyWith<_$ShopWorkerImpl> get copyWith =>
      __$$ShopWorkerImplCopyWithImpl<_$ShopWorkerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopWorkerImplToJson(this);
  }
}

abstract class _ShopWorker implements ShopWorker {
  const factory _ShopWorker({
    required final int id,
    required final String name,
    final String? phone,
    final String? role,
    @JsonKey(name: 'rating_avg') final double? ratingAvg,
    final List<ShopService>? services,
  }) = _$ShopWorkerImpl;

  factory _ShopWorker.fromJson(Map<String, dynamic> json) =
      _$ShopWorkerImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get role;
  @override
  @JsonKey(name: 'rating_avg')
  double? get ratingAvg;
  @override
  List<ShopService>? get services;

  /// Create a copy of ShopWorker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopWorkerImplCopyWith<_$ShopWorkerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
