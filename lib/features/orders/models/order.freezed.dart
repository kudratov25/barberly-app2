// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_id')
  int? get shopId => throw _privateConstructorUsedError;
  @JsonKey(name: 'barber_id')
  int get barberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_id')
  int get clientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  int get serviceId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  String? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'finished_at')
  String? get finishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelled_at')
  String? get cancelledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  OrderBarber? get barber => throw _privateConstructorUsedError;
  OrderClient? get client => throw _privateConstructorUsedError;
  OrderService? get service => throw _privateConstructorUsedError;
  OrderShop? get shop => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'shop_id') int? shopId,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'client_id') int clientId,
    @JsonKey(name: 'service_id') int serviceId,
    String status,
    int price,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'finished_at') String? finishedAt,
    @JsonKey(name: 'cancelled_at') String? cancelledAt,
    @JsonKey(name: 'created_at') String? createdAt,
    OrderBarber? barber,
    OrderClient? client,
    OrderService? service,
    OrderShop? shop,
  });

  $OrderBarberCopyWith<$Res>? get barber;
  $OrderClientCopyWith<$Res>? get client;
  $OrderServiceCopyWith<$Res>? get service;
  $OrderShopCopyWith<$Res>? get shop;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopId = freezed,
    Object? barberId = null,
    Object? clientId = null,
    Object? serviceId = null,
    Object? status = null,
    Object? price = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? cancelledAt = freezed,
    Object? createdAt = freezed,
    Object? barber = freezed,
    Object? client = freezed,
    Object? service = freezed,
    Object? shop = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            shopId: freezed == shopId
                ? _value.shopId
                : shopId // ignore: cast_nullable_to_non_nullable
                      as int?,
            barberId: null == barberId
                ? _value.barberId
                : barberId // ignore: cast_nullable_to_non_nullable
                      as int,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceId: null == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            finishedAt: freezed == finishedAt
                ? _value.finishedAt
                : finishedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            barber: freezed == barber
                ? _value.barber
                : barber // ignore: cast_nullable_to_non_nullable
                      as OrderBarber?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as OrderClient?,
            service: freezed == service
                ? _value.service
                : service // ignore: cast_nullable_to_non_nullable
                      as OrderService?,
            shop: freezed == shop
                ? _value.shop
                : shop // ignore: cast_nullable_to_non_nullable
                      as OrderShop?,
          )
          as $Val,
    );
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderBarberCopyWith<$Res>? get barber {
    if (_value.barber == null) {
      return null;
    }

    return $OrderBarberCopyWith<$Res>(_value.barber!, (value) {
      return _then(_value.copyWith(barber: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $OrderClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderServiceCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $OrderServiceCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderShopCopyWith<$Res>? get shop {
    if (_value.shop == null) {
      return null;
    }

    return $OrderShopCopyWith<$Res>(_value.shop!, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'shop_id') int? shopId,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'client_id') int clientId,
    @JsonKey(name: 'service_id') int serviceId,
    String status,
    int price,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'started_at') String? startedAt,
    @JsonKey(name: 'finished_at') String? finishedAt,
    @JsonKey(name: 'cancelled_at') String? cancelledAt,
    @JsonKey(name: 'created_at') String? createdAt,
    OrderBarber? barber,
    OrderClient? client,
    OrderService? service,
    OrderShop? shop,
  });

  @override
  $OrderBarberCopyWith<$Res>? get barber;
  @override
  $OrderClientCopyWith<$Res>? get client;
  @override
  $OrderServiceCopyWith<$Res>? get service;
  @override
  $OrderShopCopyWith<$Res>? get shop;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopId = freezed,
    Object? barberId = null,
    Object? clientId = null,
    Object? serviceId = null,
    Object? status = null,
    Object? price = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? cancelledAt = freezed,
    Object? createdAt = freezed,
    Object? barber = freezed,
    Object? client = freezed,
    Object? service = freezed,
    Object? shop = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        shopId: freezed == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as int?,
        barberId: null == barberId
            ? _value.barberId
            : barberId // ignore: cast_nullable_to_non_nullable
                  as int,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceId: null == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        finishedAt: freezed == finishedAt
            ? _value.finishedAt
            : finishedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        barber: freezed == barber
            ? _value.barber
            : barber // ignore: cast_nullable_to_non_nullable
                  as OrderBarber?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as OrderClient?,
        service: freezed == service
            ? _value.service
            : service // ignore: cast_nullable_to_non_nullable
                  as OrderService?,
        shop: freezed == shop
            ? _value.shop
            : shop // ignore: cast_nullable_to_non_nullable
                  as OrderShop?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.id,
    @JsonKey(name: 'shop_id') this.shopId,
    @JsonKey(name: 'barber_id') required this.barberId,
    @JsonKey(name: 'client_id') required this.clientId,
    @JsonKey(name: 'service_id') required this.serviceId,
    required this.status,
    required this.price,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') this.endTime,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'finished_at') this.finishedAt,
    @JsonKey(name: 'cancelled_at') this.cancelledAt,
    @JsonKey(name: 'created_at') this.createdAt,
    this.barber,
    this.client,
    this.service,
    this.shop,
  });

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'shop_id')
  final int? shopId;
  @override
  @JsonKey(name: 'barber_id')
  final int barberId;
  @override
  @JsonKey(name: 'client_id')
  final int clientId;
  @override
  @JsonKey(name: 'service_id')
  final int serviceId;
  @override
  final String status;
  @override
  final int price;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String? endTime;
  @override
  @JsonKey(name: 'started_at')
  final String? startedAt;
  @override
  @JsonKey(name: 'finished_at')
  final String? finishedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  final String? cancelledAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final OrderBarber? barber;
  @override
  final OrderClient? client;
  @override
  final OrderService? service;
  @override
  final OrderShop? shop;

  @override
  String toString() {
    return 'Order(id: $id, shopId: $shopId, barberId: $barberId, clientId: $clientId, serviceId: $serviceId, status: $status, price: $price, startTime: $startTime, endTime: $endTime, startedAt: $startedAt, finishedAt: $finishedAt, cancelledAt: $cancelledAt, createdAt: $createdAt, barber: $barber, client: $client, service: $service, shop: $shop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.barber, barber) || other.barber == barber) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.shop, shop) || other.shop == shop));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    shopId,
    barberId,
    clientId,
    serviceId,
    status,
    price,
    startTime,
    endTime,
    startedAt,
    finishedAt,
    cancelledAt,
    createdAt,
    barber,
    client,
    service,
    shop,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    required final int id,
    @JsonKey(name: 'shop_id') final int? shopId,
    @JsonKey(name: 'barber_id') required final int barberId,
    @JsonKey(name: 'client_id') required final int clientId,
    @JsonKey(name: 'service_id') required final int serviceId,
    required final String status,
    required final int price,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') final String? endTime,
    @JsonKey(name: 'started_at') final String? startedAt,
    @JsonKey(name: 'finished_at') final String? finishedAt,
    @JsonKey(name: 'cancelled_at') final String? cancelledAt,
    @JsonKey(name: 'created_at') final String? createdAt,
    final OrderBarber? barber,
    final OrderClient? client,
    final OrderService? service,
    final OrderShop? shop,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'shop_id')
  int? get shopId;
  @override
  @JsonKey(name: 'barber_id')
  int get barberId;
  @override
  @JsonKey(name: 'client_id')
  int get clientId;
  @override
  @JsonKey(name: 'service_id')
  int get serviceId;
  @override
  String get status;
  @override
  int get price;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String? get endTime;
  @override
  @JsonKey(name: 'started_at')
  String? get startedAt;
  @override
  @JsonKey(name: 'finished_at')
  String? get finishedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  String? get cancelledAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  OrderBarber? get barber;
  @override
  OrderClient? get client;
  @override
  OrderService? get service;
  @override
  OrderShop? get shop;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderBarber _$OrderBarberFromJson(Map<String, dynamic> json) {
  return _OrderBarber.fromJson(json);
}

/// @nodoc
mixin _$OrderBarber {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this OrderBarber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderBarber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderBarberCopyWith<OrderBarber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderBarberCopyWith<$Res> {
  factory $OrderBarberCopyWith(
    OrderBarber value,
    $Res Function(OrderBarber) then,
  ) = _$OrderBarberCopyWithImpl<$Res, OrderBarber>;
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class _$OrderBarberCopyWithImpl<$Res, $Val extends OrderBarber>
    implements $OrderBarberCopyWith<$Res> {
  _$OrderBarberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderBarber
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
abstract class _$$OrderBarberImplCopyWith<$Res>
    implements $OrderBarberCopyWith<$Res> {
  factory _$$OrderBarberImplCopyWith(
    _$OrderBarberImpl value,
    $Res Function(_$OrderBarberImpl) then,
  ) = __$$OrderBarberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class __$$OrderBarberImplCopyWithImpl<$Res>
    extends _$OrderBarberCopyWithImpl<$Res, _$OrderBarberImpl>
    implements _$$OrderBarberImplCopyWith<$Res> {
  __$$OrderBarberImplCopyWithImpl(
    _$OrderBarberImpl _value,
    $Res Function(_$OrderBarberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderBarber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? phone = freezed}) {
    return _then(
      _$OrderBarberImpl(
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
class _$OrderBarberImpl implements _OrderBarber {
  const _$OrderBarberImpl({required this.id, required this.name, this.phone});

  factory _$OrderBarberImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderBarberImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'OrderBarber(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderBarberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  /// Create a copy of OrderBarber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderBarberImplCopyWith<_$OrderBarberImpl> get copyWith =>
      __$$OrderBarberImplCopyWithImpl<_$OrderBarberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderBarberImplToJson(this);
  }
}

abstract class _OrderBarber implements OrderBarber {
  const factory _OrderBarber({
    required final int id,
    required final String name,
    final String? phone,
  }) = _$OrderBarberImpl;

  factory _OrderBarber.fromJson(Map<String, dynamic> json) =
      _$OrderBarberImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get phone;

  /// Create a copy of OrderBarber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderBarberImplCopyWith<_$OrderBarberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderClient _$OrderClientFromJson(Map<String, dynamic> json) {
  return _OrderClient.fromJson(json);
}

/// @nodoc
mixin _$OrderClient {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this OrderClient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderClientCopyWith<OrderClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderClientCopyWith<$Res> {
  factory $OrderClientCopyWith(
    OrderClient value,
    $Res Function(OrderClient) then,
  ) = _$OrderClientCopyWithImpl<$Res, OrderClient>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$OrderClientCopyWithImpl<$Res, $Val extends OrderClient>
    implements $OrderClientCopyWith<$Res> {
  _$OrderClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderClient
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
abstract class _$$OrderClientImplCopyWith<$Res>
    implements $OrderClientCopyWith<$Res> {
  factory _$$OrderClientImplCopyWith(
    _$OrderClientImpl value,
    $Res Function(_$OrderClientImpl) then,
  ) = __$$OrderClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$OrderClientImplCopyWithImpl<$Res>
    extends _$OrderClientCopyWithImpl<$Res, _$OrderClientImpl>
    implements _$$OrderClientImplCopyWith<$Res> {
  __$$OrderClientImplCopyWithImpl(
    _$OrderClientImpl _value,
    $Res Function(_$OrderClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$OrderClientImpl(
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
class _$OrderClientImpl implements _OrderClient {
  const _$OrderClientImpl({required this.id, required this.name});

  factory _$OrderClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderClientImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'OrderClient(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of OrderClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderClientImplCopyWith<_$OrderClientImpl> get copyWith =>
      __$$OrderClientImplCopyWithImpl<_$OrderClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderClientImplToJson(this);
  }
}

abstract class _OrderClient implements OrderClient {
  const factory _OrderClient({
    required final int id,
    required final String name,
  }) = _$OrderClientImpl;

  factory _OrderClient.fromJson(Map<String, dynamic> json) =
      _$OrderClientImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of OrderClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderClientImplCopyWith<_$OrderClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderService _$OrderServiceFromJson(Map<String, dynamic> json) {
  return _OrderService.fromJson(json);
}

/// @nodoc
mixin _$OrderService {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;

  /// Serializes this OrderService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderServiceCopyWith<OrderService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderServiceCopyWith<$Res> {
  factory $OrderServiceCopyWith(
    OrderService value,
    $Res Function(OrderService) then,
  ) = _$OrderServiceCopyWithImpl<$Res, OrderService>;
  @useResult
  $Res call({int id, String name, int price});
}

/// @nodoc
class _$OrderServiceCopyWithImpl<$Res, $Val extends OrderService>
    implements $OrderServiceCopyWith<$Res> {
  _$OrderServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? price = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderServiceImplCopyWith<$Res>
    implements $OrderServiceCopyWith<$Res> {
  factory _$$OrderServiceImplCopyWith(
    _$OrderServiceImpl value,
    $Res Function(_$OrderServiceImpl) then,
  ) = __$$OrderServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, int price});
}

/// @nodoc
class __$$OrderServiceImplCopyWithImpl<$Res>
    extends _$OrderServiceCopyWithImpl<$Res, _$OrderServiceImpl>
    implements _$$OrderServiceImplCopyWith<$Res> {
  __$$OrderServiceImplCopyWithImpl(
    _$OrderServiceImpl _value,
    $Res Function(_$OrderServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? price = null}) {
    return _then(
      _$OrderServiceImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderServiceImpl implements _OrderService {
  const _$OrderServiceImpl({
    required this.id,
    required this.name,
    required this.price,
  });

  factory _$OrderServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderServiceImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int price;

  @override
  String toString() {
    return 'OrderService(id: $id, name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price);

  /// Create a copy of OrderService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderServiceImplCopyWith<_$OrderServiceImpl> get copyWith =>
      __$$OrderServiceImplCopyWithImpl<_$OrderServiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderServiceImplToJson(this);
  }
}

abstract class _OrderService implements OrderService {
  const factory _OrderService({
    required final int id,
    required final String name,
    required final int price,
  }) = _$OrderServiceImpl;

  factory _OrderService.fromJson(Map<String, dynamic> json) =
      _$OrderServiceImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get price;

  /// Create a copy of OrderService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderServiceImplCopyWith<_$OrderServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderShop _$OrderShopFromJson(Map<String, dynamic> json) {
  return _OrderShop.fromJson(json);
}

/// @nodoc
mixin _$OrderShop {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this OrderShop to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderShop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderShopCopyWith<OrderShop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderShopCopyWith<$Res> {
  factory $OrderShopCopyWith(OrderShop value, $Res Function(OrderShop) then) =
      _$OrderShopCopyWithImpl<$Res, OrderShop>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$OrderShopCopyWithImpl<$Res, $Val extends OrderShop>
    implements $OrderShopCopyWith<$Res> {
  _$OrderShopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderShop
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
abstract class _$$OrderShopImplCopyWith<$Res>
    implements $OrderShopCopyWith<$Res> {
  factory _$$OrderShopImplCopyWith(
    _$OrderShopImpl value,
    $Res Function(_$OrderShopImpl) then,
  ) = __$$OrderShopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$OrderShopImplCopyWithImpl<$Res>
    extends _$OrderShopCopyWithImpl<$Res, _$OrderShopImpl>
    implements _$$OrderShopImplCopyWith<$Res> {
  __$$OrderShopImplCopyWithImpl(
    _$OrderShopImpl _value,
    $Res Function(_$OrderShopImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderShop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$OrderShopImpl(
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
class _$OrderShopImpl implements _OrderShop {
  const _$OrderShopImpl({required this.id, required this.name});

  factory _$OrderShopImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderShopImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'OrderShop(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderShopImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of OrderShop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderShopImplCopyWith<_$OrderShopImpl> get copyWith =>
      __$$OrderShopImplCopyWithImpl<_$OrderShopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderShopImplToJson(this);
  }
}

abstract class _OrderShop implements OrderShop {
  const factory _OrderShop({
    required final int id,
    required final String name,
  }) = _$OrderShopImpl;

  factory _OrderShop.fromJson(Map<String, dynamic> json) =
      _$OrderShopImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of OrderShop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderShopImplCopyWith<_$OrderShopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
