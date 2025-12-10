// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return _Service.fromJson(json);
}

/// @nodoc
mixin _$Service {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_id')
  int? get shopId => throw _privateConstructorUsedError;
  ServiceShop? get shop => throw _privateConstructorUsedError;
  List<ServiceUser>? get users => throw _privateConstructorUsedError;

  /// Serializes this Service to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceCopyWith<Service> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCopyWith<$Res> {
  factory $ServiceCopyWith(Service value, $Res Function(Service) then) =
      _$ServiceCopyWithImpl<$Res, Service>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    int price,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'shop_id') int? shopId,
    ServiceShop? shop,
    List<ServiceUser>? users,
  });

  $ServiceShopCopyWith<$Res>? get shop;
}

/// @nodoc
class _$ServiceCopyWithImpl<$Res, $Val extends Service>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? durationMinutes = null,
    Object? isActive = null,
    Object? shopId = freezed,
    Object? shop = freezed,
    Object? users = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            shopId: freezed == shopId
                ? _value.shopId
                : shopId // ignore: cast_nullable_to_non_nullable
                      as int?,
            shop: freezed == shop
                ? _value.shop
                : shop // ignore: cast_nullable_to_non_nullable
                      as ServiceShop?,
            users: freezed == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<ServiceUser>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceShopCopyWith<$Res>? get shop {
    if (_value.shop == null) {
      return null;
    }

    return $ServiceShopCopyWith<$Res>(_value.shop!, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServiceImplCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$$ServiceImplCopyWith(
    _$ServiceImpl value,
    $Res Function(_$ServiceImpl) then,
  ) = __$$ServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    int price,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'shop_id') int? shopId,
    ServiceShop? shop,
    List<ServiceUser>? users,
  });

  @override
  $ServiceShopCopyWith<$Res>? get shop;
}

/// @nodoc
class __$$ServiceImplCopyWithImpl<$Res>
    extends _$ServiceCopyWithImpl<$Res, _$ServiceImpl>
    implements _$$ServiceImplCopyWith<$Res> {
  __$$ServiceImplCopyWithImpl(
    _$ServiceImpl _value,
    $Res Function(_$ServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? durationMinutes = null,
    Object? isActive = null,
    Object? shopId = freezed,
    Object? shop = freezed,
    Object? users = freezed,
  }) {
    return _then(
      _$ServiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        shopId: freezed == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as int?,
        shop: freezed == shop
            ? _value.shop
            : shop // ignore: cast_nullable_to_non_nullable
                  as ServiceShop?,
        users: freezed == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<ServiceUser>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceImpl implements _Service {
  const _$ServiceImpl({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    @JsonKey(name: 'duration_minutes') required this.durationMinutes,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'shop_id') this.shopId,
    this.shop,
    final List<ServiceUser>? users,
  }) : _users = users;

  factory _$ServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int price;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'shop_id')
  final int? shopId;
  @override
  final ServiceShop? shop;
  final List<ServiceUser>? _users;
  @override
  List<ServiceUser>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Service(id: $id, name: $name, description: $description, price: $price, durationMinutes: $durationMinutes, isActive: $isActive, shopId: $shopId, shop: $shop, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.shop, shop) || other.shop == shop) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    durationMinutes,
    isActive,
    shopId,
    shop,
    const DeepCollectionEquality().hash(_users),
  );

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      __$$ServiceImplCopyWithImpl<_$ServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceImplToJson(this);
  }
}

abstract class _Service implements Service {
  const factory _Service({
    required final int id,
    required final String name,
    final String? description,
    required final int price,
    @JsonKey(name: 'duration_minutes') required final int durationMinutes,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'shop_id') final int? shopId,
    final ServiceShop? shop,
    final List<ServiceUser>? users,
  }) = _$ServiceImpl;

  factory _Service.fromJson(Map<String, dynamic> json) = _$ServiceImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get price;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'shop_id')
  int? get shopId;
  @override
  ServiceShop? get shop;
  @override
  List<ServiceUser>? get users;

  /// Create a copy of Service
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceImplCopyWith<_$ServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceShop _$ServiceShopFromJson(Map<String, dynamic> json) {
  return _ServiceShop.fromJson(json);
}

/// @nodoc
mixin _$ServiceShop {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this ServiceShop to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceShop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceShopCopyWith<ServiceShop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceShopCopyWith<$Res> {
  factory $ServiceShopCopyWith(
    ServiceShop value,
    $Res Function(ServiceShop) then,
  ) = _$ServiceShopCopyWithImpl<$Res, ServiceShop>;
  @useResult
  $Res call({int id, String name, String? address});
}

/// @nodoc
class _$ServiceShopCopyWithImpl<$Res, $Val extends ServiceShop>
    implements $ServiceShopCopyWith<$Res> {
  _$ServiceShopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceShop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceShopImplCopyWith<$Res>
    implements $ServiceShopCopyWith<$Res> {
  factory _$$ServiceShopImplCopyWith(
    _$ServiceShopImpl value,
    $Res Function(_$ServiceShopImpl) then,
  ) = __$$ServiceShopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? address});
}

/// @nodoc
class __$$ServiceShopImplCopyWithImpl<$Res>
    extends _$ServiceShopCopyWithImpl<$Res, _$ServiceShopImpl>
    implements _$$ServiceShopImplCopyWith<$Res> {
  __$$ServiceShopImplCopyWithImpl(
    _$ServiceShopImpl _value,
    $Res Function(_$ServiceShopImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceShop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
  }) {
    return _then(
      _$ServiceShopImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceShopImpl implements _ServiceShop {
  const _$ServiceShopImpl({required this.id, required this.name, this.address});

  factory _$ServiceShopImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceShopImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? address;

  @override
  String toString() {
    return 'ServiceShop(id: $id, name: $name, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceShopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address);

  /// Create a copy of ServiceShop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceShopImplCopyWith<_$ServiceShopImpl> get copyWith =>
      __$$ServiceShopImplCopyWithImpl<_$ServiceShopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceShopImplToJson(this);
  }
}

abstract class _ServiceShop implements ServiceShop {
  const factory _ServiceShop({
    required final int id,
    required final String name,
    final String? address,
  }) = _$ServiceShopImpl;

  factory _ServiceShop.fromJson(Map<String, dynamic> json) =
      _$ServiceShopImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get address;

  /// Create a copy of ServiceShop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceShopImplCopyWith<_$ServiceShopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceUser _$ServiceUserFromJson(Map<String, dynamic> json) {
  return _ServiceUser.fromJson(json);
}

/// @nodoc
mixin _$ServiceUser {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this ServiceUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceUserCopyWith<ServiceUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceUserCopyWith<$Res> {
  factory $ServiceUserCopyWith(
    ServiceUser value,
    $Res Function(ServiceUser) then,
  ) = _$ServiceUserCopyWithImpl<$Res, ServiceUser>;
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class _$ServiceUserCopyWithImpl<$Res, $Val extends ServiceUser>
    implements $ServiceUserCopyWith<$Res> {
  _$ServiceUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceUser
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
abstract class _$$ServiceUserImplCopyWith<$Res>
    implements $ServiceUserCopyWith<$Res> {
  factory _$$ServiceUserImplCopyWith(
    _$ServiceUserImpl value,
    $Res Function(_$ServiceUserImpl) then,
  ) = __$$ServiceUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class __$$ServiceUserImplCopyWithImpl<$Res>
    extends _$ServiceUserCopyWithImpl<$Res, _$ServiceUserImpl>
    implements _$$ServiceUserImplCopyWith<$Res> {
  __$$ServiceUserImplCopyWithImpl(
    _$ServiceUserImpl _value,
    $Res Function(_$ServiceUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? phone = freezed}) {
    return _then(
      _$ServiceUserImpl(
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
class _$ServiceUserImpl implements _ServiceUser {
  const _$ServiceUserImpl({required this.id, required this.name, this.phone});

  factory _$ServiceUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceUserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'ServiceUser(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  /// Create a copy of ServiceUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceUserImplCopyWith<_$ServiceUserImpl> get copyWith =>
      __$$ServiceUserImplCopyWithImpl<_$ServiceUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceUserImplToJson(this);
  }
}

abstract class _ServiceUser implements ServiceUser {
  const factory _ServiceUser({
    required final int id,
    required final String name,
    final String? phone,
  }) = _$ServiceUserImpl;

  factory _ServiceUser.fromJson(Map<String, dynamic> json) =
      _$ServiceUserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get phone;

  /// Create a copy of ServiceUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceUserImplCopyWith<_$ServiceUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
