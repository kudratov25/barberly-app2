// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
mixin _$Rating {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'barber_id')
  int get barberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_id')
  int get clientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  int get orderId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  RatingBarber? get barber => throw _privateConstructorUsedError;
  RatingClient? get client => throw _privateConstructorUsedError;
  RatingOrder? get order => throw _privateConstructorUsedError;

  /// Serializes this Rating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res, Rating>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'client_id') int clientId,
    @JsonKey(name: 'order_id') int orderId,
    int rating,
    String? comment,
    @JsonKey(name: 'created_at') String createdAt,
    RatingBarber? barber,
    RatingClient? client,
    RatingOrder? order,
  });

  $RatingBarberCopyWith<$Res>? get barber;
  $RatingClientCopyWith<$Res>? get client;
  $RatingOrderCopyWith<$Res>? get order;
}

/// @nodoc
class _$RatingCopyWithImpl<$Res, $Val extends Rating>
    implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barberId = null,
    Object? clientId = null,
    Object? orderId = null,
    Object? rating = null,
    Object? comment = freezed,
    Object? createdAt = null,
    Object? barber = freezed,
    Object? client = freezed,
    Object? order = freezed,
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
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as int,
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as int,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            barber: freezed == barber
                ? _value.barber
                : barber // ignore: cast_nullable_to_non_nullable
                      as RatingBarber?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as RatingClient?,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as RatingOrder?,
          )
          as $Val,
    );
  }

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RatingBarberCopyWith<$Res>? get barber {
    if (_value.barber == null) {
      return null;
    }

    return $RatingBarberCopyWith<$Res>(_value.barber!, (value) {
      return _then(_value.copyWith(barber: value) as $Val);
    });
  }

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RatingClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $RatingClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RatingOrderCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $RatingOrderCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RatingImplCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$$RatingImplCopyWith(
    _$RatingImpl value,
    $Res Function(_$RatingImpl) then,
  ) = __$$RatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'barber_id') int barberId,
    @JsonKey(name: 'client_id') int clientId,
    @JsonKey(name: 'order_id') int orderId,
    int rating,
    String? comment,
    @JsonKey(name: 'created_at') String createdAt,
    RatingBarber? barber,
    RatingClient? client,
    RatingOrder? order,
  });

  @override
  $RatingBarberCopyWith<$Res>? get barber;
  @override
  $RatingClientCopyWith<$Res>? get client;
  @override
  $RatingOrderCopyWith<$Res>? get order;
}

/// @nodoc
class __$$RatingImplCopyWithImpl<$Res>
    extends _$RatingCopyWithImpl<$Res, _$RatingImpl>
    implements _$$RatingImplCopyWith<$Res> {
  __$$RatingImplCopyWithImpl(
    _$RatingImpl _value,
    $Res Function(_$RatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? barberId = null,
    Object? clientId = null,
    Object? orderId = null,
    Object? rating = null,
    Object? comment = freezed,
    Object? createdAt = null,
    Object? barber = freezed,
    Object? client = freezed,
    Object? order = freezed,
  }) {
    return _then(
      _$RatingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        barberId: null == barberId
            ? _value.barberId
            : barberId // ignore: cast_nullable_to_non_nullable
                  as int,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as int,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        barber: freezed == barber
            ? _value.barber
            : barber // ignore: cast_nullable_to_non_nullable
                  as RatingBarber?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as RatingClient?,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as RatingOrder?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingImpl implements _Rating {
  const _$RatingImpl({
    required this.id,
    @JsonKey(name: 'barber_id') required this.barberId,
    @JsonKey(name: 'client_id') required this.clientId,
    @JsonKey(name: 'order_id') required this.orderId,
    required this.rating,
    this.comment,
    @JsonKey(name: 'created_at') required this.createdAt,
    this.barber,
    this.client,
    this.order,
  });

  factory _$RatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'barber_id')
  final int barberId;
  @override
  @JsonKey(name: 'client_id')
  final int clientId;
  @override
  @JsonKey(name: 'order_id')
  final int orderId;
  @override
  final int rating;
  @override
  final String? comment;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  final RatingBarber? barber;
  @override
  final RatingClient? client;
  @override
  final RatingOrder? order;

  @override
  String toString() {
    return 'Rating(id: $id, barberId: $barberId, clientId: $clientId, orderId: $orderId, rating: $rating, comment: $comment, createdAt: $createdAt, barber: $barber, client: $client, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.barberId, barberId) ||
                other.barberId == barberId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.barber, barber) || other.barber == barber) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    barberId,
    clientId,
    orderId,
    rating,
    comment,
    createdAt,
    barber,
    client,
    order,
  );

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      __$$RatingImplCopyWithImpl<_$RatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingImplToJson(this);
  }
}

abstract class _Rating implements Rating {
  const factory _Rating({
    required final int id,
    @JsonKey(name: 'barber_id') required final int barberId,
    @JsonKey(name: 'client_id') required final int clientId,
    @JsonKey(name: 'order_id') required final int orderId,
    required final int rating,
    final String? comment,
    @JsonKey(name: 'created_at') required final String createdAt,
    final RatingBarber? barber,
    final RatingClient? client,
    final RatingOrder? order,
  }) = _$RatingImpl;

  factory _Rating.fromJson(Map<String, dynamic> json) = _$RatingImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'barber_id')
  int get barberId;
  @override
  @JsonKey(name: 'client_id')
  int get clientId;
  @override
  @JsonKey(name: 'order_id')
  int get orderId;
  @override
  int get rating;
  @override
  String? get comment;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  RatingBarber? get barber;
  @override
  RatingClient? get client;
  @override
  RatingOrder? get order;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingBarber _$RatingBarberFromJson(Map<String, dynamic> json) {
  return _RatingBarber.fromJson(json);
}

/// @nodoc
mixin _$RatingBarber {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this RatingBarber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingBarber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingBarberCopyWith<RatingBarber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingBarberCopyWith<$Res> {
  factory $RatingBarberCopyWith(
    RatingBarber value,
    $Res Function(RatingBarber) then,
  ) = _$RatingBarberCopyWithImpl<$Res, RatingBarber>;
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class _$RatingBarberCopyWithImpl<$Res, $Val extends RatingBarber>
    implements $RatingBarberCopyWith<$Res> {
  _$RatingBarberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingBarber
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
abstract class _$$RatingBarberImplCopyWith<$Res>
    implements $RatingBarberCopyWith<$Res> {
  factory _$$RatingBarberImplCopyWith(
    _$RatingBarberImpl value,
    $Res Function(_$RatingBarberImpl) then,
  ) = __$$RatingBarberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? phone});
}

/// @nodoc
class __$$RatingBarberImplCopyWithImpl<$Res>
    extends _$RatingBarberCopyWithImpl<$Res, _$RatingBarberImpl>
    implements _$$RatingBarberImplCopyWith<$Res> {
  __$$RatingBarberImplCopyWithImpl(
    _$RatingBarberImpl _value,
    $Res Function(_$RatingBarberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingBarber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? phone = freezed}) {
    return _then(
      _$RatingBarberImpl(
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
class _$RatingBarberImpl implements _RatingBarber {
  const _$RatingBarberImpl({required this.id, required this.name, this.phone});

  factory _$RatingBarberImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingBarberImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'RatingBarber(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingBarberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  /// Create a copy of RatingBarber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingBarberImplCopyWith<_$RatingBarberImpl> get copyWith =>
      __$$RatingBarberImplCopyWithImpl<_$RatingBarberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingBarberImplToJson(this);
  }
}

abstract class _RatingBarber implements RatingBarber {
  const factory _RatingBarber({
    required final int id,
    required final String name,
    final String? phone,
  }) = _$RatingBarberImpl;

  factory _RatingBarber.fromJson(Map<String, dynamic> json) =
      _$RatingBarberImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get phone;

  /// Create a copy of RatingBarber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingBarberImplCopyWith<_$RatingBarberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingClient _$RatingClientFromJson(Map<String, dynamic> json) {
  return _RatingClient.fromJson(json);
}

/// @nodoc
mixin _$RatingClient {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this RatingClient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingClientCopyWith<RatingClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingClientCopyWith<$Res> {
  factory $RatingClientCopyWith(
    RatingClient value,
    $Res Function(RatingClient) then,
  ) = _$RatingClientCopyWithImpl<$Res, RatingClient>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$RatingClientCopyWithImpl<$Res, $Val extends RatingClient>
    implements $RatingClientCopyWith<$Res> {
  _$RatingClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingClient
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
abstract class _$$RatingClientImplCopyWith<$Res>
    implements $RatingClientCopyWith<$Res> {
  factory _$$RatingClientImplCopyWith(
    _$RatingClientImpl value,
    $Res Function(_$RatingClientImpl) then,
  ) = __$$RatingClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$RatingClientImplCopyWithImpl<$Res>
    extends _$RatingClientCopyWithImpl<$Res, _$RatingClientImpl>
    implements _$$RatingClientImplCopyWith<$Res> {
  __$$RatingClientImplCopyWithImpl(
    _$RatingClientImpl _value,
    $Res Function(_$RatingClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$RatingClientImpl(
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
class _$RatingClientImpl implements _RatingClient {
  const _$RatingClientImpl({required this.id, required this.name});

  factory _$RatingClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingClientImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'RatingClient(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of RatingClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingClientImplCopyWith<_$RatingClientImpl> get copyWith =>
      __$$RatingClientImplCopyWithImpl<_$RatingClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingClientImplToJson(this);
  }
}

abstract class _RatingClient implements RatingClient {
  const factory _RatingClient({
    required final int id,
    required final String name,
  }) = _$RatingClientImpl;

  factory _RatingClient.fromJson(Map<String, dynamic> json) =
      _$RatingClientImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of RatingClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingClientImplCopyWith<_$RatingClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingOrder _$RatingOrderFromJson(Map<String, dynamic> json) {
  return _RatingOrder.fromJson(json);
}

/// @nodoc
mixin _$RatingOrder {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  int? get serviceId => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;

  /// Serializes this RatingOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingOrderCopyWith<RatingOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingOrderCopyWith<$Res> {
  factory $RatingOrderCopyWith(
    RatingOrder value,
    $Res Function(RatingOrder) then,
  ) = _$RatingOrderCopyWithImpl<$Res, RatingOrder>;
  @useResult
  $Res call({int id, @JsonKey(name: 'service_id') int? serviceId, int? price});
}

/// @nodoc
class _$RatingOrderCopyWithImpl<$Res, $Val extends RatingOrder>
    implements $RatingOrderCopyWith<$Res> {
  _$RatingOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceId: freezed == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as int?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingOrderImplCopyWith<$Res>
    implements $RatingOrderCopyWith<$Res> {
  factory _$$RatingOrderImplCopyWith(
    _$RatingOrderImpl value,
    $Res Function(_$RatingOrderImpl) then,
  ) = __$$RatingOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, @JsonKey(name: 'service_id') int? serviceId, int? price});
}

/// @nodoc
class __$$RatingOrderImplCopyWithImpl<$Res>
    extends _$RatingOrderCopyWithImpl<$Res, _$RatingOrderImpl>
    implements _$$RatingOrderImplCopyWith<$Res> {
  __$$RatingOrderImplCopyWithImpl(
    _$RatingOrderImpl _value,
    $Res Function(_$RatingOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _$RatingOrderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceId: freezed == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as int?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingOrderImpl implements _RatingOrder {
  const _$RatingOrderImpl({
    required this.id,
    @JsonKey(name: 'service_id') this.serviceId,
    this.price,
  });

  factory _$RatingOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingOrderImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'service_id')
  final int? serviceId;
  @override
  final int? price;

  @override
  String toString() {
    return 'RatingOrder(id: $id, serviceId: $serviceId, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, serviceId, price);

  /// Create a copy of RatingOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingOrderImplCopyWith<_$RatingOrderImpl> get copyWith =>
      __$$RatingOrderImplCopyWithImpl<_$RatingOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingOrderImplToJson(this);
  }
}

abstract class _RatingOrder implements RatingOrder {
  const factory _RatingOrder({
    required final int id,
    @JsonKey(name: 'service_id') final int? serviceId,
    final int? price,
  }) = _$RatingOrderImpl;

  factory _RatingOrder.fromJson(Map<String, dynamic> json) =
      _$RatingOrderImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'service_id')
  int? get serviceId;
  @override
  int? get price;

  /// Create a copy of RatingOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingOrderImplCopyWith<_$RatingOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
