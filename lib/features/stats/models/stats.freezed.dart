// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyStats _$DailyStatsFromJson(Map<String, dynamic> json) {
  return _DailyStats.fromJson(json);
}

/// @nodoc
mixin _$DailyStats {
  String? get period => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  List<DailyPoint> get points => throw _privateConstructorUsedError;
  DailyTotals get totals => throw _privateConstructorUsedError;

  /// Serializes this DailyStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyStatsCopyWith<DailyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStatsCopyWith<$Res> {
  factory $DailyStatsCopyWith(
    DailyStats value,
    $Res Function(DailyStats) then,
  ) = _$DailyStatsCopyWithImpl<$Res, DailyStats>;
  @useResult
  $Res call({
    String? period,
    String? from,
    String? to,
    String? currency,
    List<DailyPoint> points,
    DailyTotals totals,
  });

  $DailyTotalsCopyWith<$Res> get totals;
}

/// @nodoc
class _$DailyStatsCopyWithImpl<$Res, $Val extends DailyStats>
    implements $DailyStatsCopyWith<$Res> {
  _$DailyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? currency = freezed,
    Object? points = null,
    Object? totals = null,
  }) {
    return _then(
      _value.copyWith(
            period: freezed == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String?,
            from: freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as String?,
            to: freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as String?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as List<DailyPoint>,
            totals: null == totals
                ? _value.totals
                : totals // ignore: cast_nullable_to_non_nullable
                      as DailyTotals,
          )
          as $Val,
    );
  }

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyTotalsCopyWith<$Res> get totals {
    return $DailyTotalsCopyWith<$Res>(_value.totals, (value) {
      return _then(_value.copyWith(totals: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyStatsImplCopyWith<$Res>
    implements $DailyStatsCopyWith<$Res> {
  factory _$$DailyStatsImplCopyWith(
    _$DailyStatsImpl value,
    $Res Function(_$DailyStatsImpl) then,
  ) = __$$DailyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? period,
    String? from,
    String? to,
    String? currency,
    List<DailyPoint> points,
    DailyTotals totals,
  });

  @override
  $DailyTotalsCopyWith<$Res> get totals;
}

/// @nodoc
class __$$DailyStatsImplCopyWithImpl<$Res>
    extends _$DailyStatsCopyWithImpl<$Res, _$DailyStatsImpl>
    implements _$$DailyStatsImplCopyWith<$Res> {
  __$$DailyStatsImplCopyWithImpl(
    _$DailyStatsImpl _value,
    $Res Function(_$DailyStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? currency = freezed,
    Object? points = null,
    Object? totals = null,
  }) {
    return _then(
      _$DailyStatsImpl(
        period: freezed == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String?,
        from: freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String?,
        to: freezed == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        points: null == points
            ? _value._points
            : points // ignore: cast_nullable_to_non_nullable
                  as List<DailyPoint>,
        totals: null == totals
            ? _value.totals
            : totals // ignore: cast_nullable_to_non_nullable
                  as DailyTotals,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DailyStatsImpl implements _DailyStats {
  const _$DailyStatsImpl({
    this.period,
    this.from,
    this.to,
    this.currency,
    required final List<DailyPoint> points,
    required this.totals,
  }) : _points = points;

  factory _$DailyStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStatsImplFromJson(json);

  @override
  final String? period;
  @override
  final String? from;
  @override
  final String? to;
  @override
  final String? currency;
  final List<DailyPoint> _points;
  @override
  List<DailyPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final DailyTotals totals;

  @override
  String toString() {
    return 'DailyStats(period: $period, from: $from, to: $to, currency: $currency, points: $points, totals: $totals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStatsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.totals, totals) || other.totals == totals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    period,
    from,
    to,
    currency,
    const DeepCollectionEquality().hash(_points),
    totals,
  );

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      __$$DailyStatsImplCopyWithImpl<_$DailyStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStatsImplToJson(this);
  }
}

abstract class _DailyStats implements DailyStats {
  const factory _DailyStats({
    final String? period,
    final String? from,
    final String? to,
    final String? currency,
    required final List<DailyPoint> points,
    required final DailyTotals totals,
  }) = _$DailyStatsImpl;

  factory _DailyStats.fromJson(Map<String, dynamic> json) =
      _$DailyStatsImpl.fromJson;

  @override
  String? get period;
  @override
  String? get from;
  @override
  String? get to;
  @override
  String? get currency;
  @override
  List<DailyPoint> get points;
  @override
  DailyTotals get totals;

  /// Create a copy of DailyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyPoint _$DailyPointFromJson(Map<String, dynamic> json) {
  return _DailyPoint.fromJson(json);
}

/// @nodoc
mixin _$DailyPoint {
  String get date => throw _privateConstructorUsedError;
  int get ordersCount => throw _privateConstructorUsedError;
  int get walkinsCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get revenue => throw _privateConstructorUsedError;
  int get ordersRevenue => throw _privateConstructorUsedError;
  int get walkinsRevenue => throw _privateConstructorUsedError;
  int? get avgTicket => throw _privateConstructorUsedError;

  /// Serializes this DailyPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyPointCopyWith<DailyPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPointCopyWith<$Res> {
  factory $DailyPointCopyWith(
    DailyPoint value,
    $Res Function(DailyPoint) then,
  ) = _$DailyPointCopyWithImpl<$Res, DailyPoint>;
  @useResult
  $Res call({
    String date,
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
    int? avgTicket,
  });
}

/// @nodoc
class _$DailyPointCopyWithImpl<$Res, $Val extends DailyPoint>
    implements $DailyPointCopyWith<$Res> {
  _$DailyPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
    Object? avgTicket = freezed,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            ordersCount: null == ordersCount
                ? _value.ordersCount
                : ordersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsCount: null == walkinsCount
                ? _value.walkinsCount
                : walkinsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            ordersRevenue: null == ordersRevenue
                ? _value.ordersRevenue
                : ordersRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsRevenue: null == walkinsRevenue
                ? _value.walkinsRevenue
                : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            avgTicket: freezed == avgTicket
                ? _value.avgTicket
                : avgTicket // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyPointImplCopyWith<$Res>
    implements $DailyPointCopyWith<$Res> {
  factory _$$DailyPointImplCopyWith(
    _$DailyPointImpl value,
    $Res Function(_$DailyPointImpl) then,
  ) = __$$DailyPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
    int? avgTicket,
  });
}

/// @nodoc
class __$$DailyPointImplCopyWithImpl<$Res>
    extends _$DailyPointCopyWithImpl<$Res, _$DailyPointImpl>
    implements _$$DailyPointImplCopyWith<$Res> {
  __$$DailyPointImplCopyWithImpl(
    _$DailyPointImpl _value,
    $Res Function(_$DailyPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
    Object? avgTicket = freezed,
  }) {
    return _then(
      _$DailyPointImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        ordersCount: null == ordersCount
            ? _value.ordersCount
            : ordersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsCount: null == walkinsCount
            ? _value.walkinsCount
            : walkinsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        ordersRevenue: null == ordersRevenue
            ? _value.ordersRevenue
            : ordersRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsRevenue: null == walkinsRevenue
            ? _value.walkinsRevenue
            : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        avgTicket: freezed == avgTicket
            ? _value.avgTicket
            : avgTicket // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DailyPointImpl implements _DailyPoint {
  const _$DailyPointImpl({
    required this.date,
    this.ordersCount = 0,
    this.walkinsCount = 0,
    this.totalCount = 0,
    this.revenue = 0,
    this.ordersRevenue = 0,
    this.walkinsRevenue = 0,
    this.avgTicket,
  });

  factory _$DailyPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyPointImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey()
  final int ordersCount;
  @override
  @JsonKey()
  final int walkinsCount;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int revenue;
  @override
  @JsonKey()
  final int ordersRevenue;
  @override
  @JsonKey()
  final int walkinsRevenue;
  @override
  final int? avgTicket;

  @override
  String toString() {
    return 'DailyPoint(date: $date, ordersCount: $ordersCount, walkinsCount: $walkinsCount, totalCount: $totalCount, revenue: $revenue, ordersRevenue: $ordersRevenue, walkinsRevenue: $walkinsRevenue, avgTicket: $avgTicket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount) &&
            (identical(other.walkinsCount, walkinsCount) ||
                other.walkinsCount == walkinsCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.ordersRevenue, ordersRevenue) ||
                other.ordersRevenue == ordersRevenue) &&
            (identical(other.walkinsRevenue, walkinsRevenue) ||
                other.walkinsRevenue == walkinsRevenue) &&
            (identical(other.avgTicket, avgTicket) ||
                other.avgTicket == avgTicket));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    ordersCount,
    walkinsCount,
    totalCount,
    revenue,
    ordersRevenue,
    walkinsRevenue,
    avgTicket,
  );

  /// Create a copy of DailyPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPointImplCopyWith<_$DailyPointImpl> get copyWith =>
      __$$DailyPointImplCopyWithImpl<_$DailyPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyPointImplToJson(this);
  }
}

abstract class _DailyPoint implements DailyPoint {
  const factory _DailyPoint({
    required final String date,
    final int ordersCount,
    final int walkinsCount,
    final int totalCount,
    final int revenue,
    final int ordersRevenue,
    final int walkinsRevenue,
    final int? avgTicket,
  }) = _$DailyPointImpl;

  factory _DailyPoint.fromJson(Map<String, dynamic> json) =
      _$DailyPointImpl.fromJson;

  @override
  String get date;
  @override
  int get ordersCount;
  @override
  int get walkinsCount;
  @override
  int get totalCount;
  @override
  int get revenue;
  @override
  int get ordersRevenue;
  @override
  int get walkinsRevenue;
  @override
  int? get avgTicket;

  /// Create a copy of DailyPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyPointImplCopyWith<_$DailyPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyTotals _$DailyTotalsFromJson(Map<String, dynamic> json) {
  return _DailyTotals.fromJson(json);
}

/// @nodoc
mixin _$DailyTotals {
  int get ordersCount => throw _privateConstructorUsedError;
  int get walkinsCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get revenue => throw _privateConstructorUsedError;
  int get ordersRevenue => throw _privateConstructorUsedError;
  int get walkinsRevenue => throw _privateConstructorUsedError;

  /// Serializes this DailyTotals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyTotalsCopyWith<DailyTotals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyTotalsCopyWith<$Res> {
  factory $DailyTotalsCopyWith(
    DailyTotals value,
    $Res Function(DailyTotals) then,
  ) = _$DailyTotalsCopyWithImpl<$Res, DailyTotals>;
  @useResult
  $Res call({
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
  });
}

/// @nodoc
class _$DailyTotalsCopyWithImpl<$Res, $Val extends DailyTotals>
    implements $DailyTotalsCopyWith<$Res> {
  _$DailyTotalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
  }) {
    return _then(
      _value.copyWith(
            ordersCount: null == ordersCount
                ? _value.ordersCount
                : ordersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsCount: null == walkinsCount
                ? _value.walkinsCount
                : walkinsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            ordersRevenue: null == ordersRevenue
                ? _value.ordersRevenue
                : ordersRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsRevenue: null == walkinsRevenue
                ? _value.walkinsRevenue
                : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyTotalsImplCopyWith<$Res>
    implements $DailyTotalsCopyWith<$Res> {
  factory _$$DailyTotalsImplCopyWith(
    _$DailyTotalsImpl value,
    $Res Function(_$DailyTotalsImpl) then,
  ) = __$$DailyTotalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
  });
}

/// @nodoc
class __$$DailyTotalsImplCopyWithImpl<$Res>
    extends _$DailyTotalsCopyWithImpl<$Res, _$DailyTotalsImpl>
    implements _$$DailyTotalsImplCopyWith<$Res> {
  __$$DailyTotalsImplCopyWithImpl(
    _$DailyTotalsImpl _value,
    $Res Function(_$DailyTotalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
  }) {
    return _then(
      _$DailyTotalsImpl(
        ordersCount: null == ordersCount
            ? _value.ordersCount
            : ordersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsCount: null == walkinsCount
            ? _value.walkinsCount
            : walkinsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        ordersRevenue: null == ordersRevenue
            ? _value.ordersRevenue
            : ordersRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsRevenue: null == walkinsRevenue
            ? _value.walkinsRevenue
            : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DailyTotalsImpl implements _DailyTotals {
  const _$DailyTotalsImpl({
    this.ordersCount = 0,
    this.walkinsCount = 0,
    this.totalCount = 0,
    this.revenue = 0,
    this.ordersRevenue = 0,
    this.walkinsRevenue = 0,
  });

  factory _$DailyTotalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyTotalsImplFromJson(json);

  @override
  @JsonKey()
  final int ordersCount;
  @override
  @JsonKey()
  final int walkinsCount;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int revenue;
  @override
  @JsonKey()
  final int ordersRevenue;
  @override
  @JsonKey()
  final int walkinsRevenue;

  @override
  String toString() {
    return 'DailyTotals(ordersCount: $ordersCount, walkinsCount: $walkinsCount, totalCount: $totalCount, revenue: $revenue, ordersRevenue: $ordersRevenue, walkinsRevenue: $walkinsRevenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyTotalsImpl &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount) &&
            (identical(other.walkinsCount, walkinsCount) ||
                other.walkinsCount == walkinsCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.ordersRevenue, ordersRevenue) ||
                other.ordersRevenue == ordersRevenue) &&
            (identical(other.walkinsRevenue, walkinsRevenue) ||
                other.walkinsRevenue == walkinsRevenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ordersCount,
    walkinsCount,
    totalCount,
    revenue,
    ordersRevenue,
    walkinsRevenue,
  );

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyTotalsImplCopyWith<_$DailyTotalsImpl> get copyWith =>
      __$$DailyTotalsImplCopyWithImpl<_$DailyTotalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyTotalsImplToJson(this);
  }
}

abstract class _DailyTotals implements DailyTotals {
  const factory _DailyTotals({
    final int ordersCount,
    final int walkinsCount,
    final int totalCount,
    final int revenue,
    final int ordersRevenue,
    final int walkinsRevenue,
  }) = _$DailyTotalsImpl;

  factory _DailyTotals.fromJson(Map<String, dynamic> json) =
      _$DailyTotalsImpl.fromJson;

  @override
  int get ordersCount;
  @override
  int get walkinsCount;
  @override
  int get totalCount;
  @override
  int get revenue;
  @override
  int get ordersRevenue;
  @override
  int get walkinsRevenue;

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyTotalsImplCopyWith<_$DailyTotalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyStats _$MonthlyStatsFromJson(Map<String, dynamic> json) {
  return _MonthlyStats.fromJson(json);
}

/// @nodoc
mixin _$MonthlyStats {
  int get year => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<MonthlyPoint> get points => throw _privateConstructorUsedError;
  MonthlyTotals get totals => throw _privateConstructorUsedError;
  MonthlyPoint? get currentMonth => throw _privateConstructorUsedError;
  MonthlyComparison? get comparison => throw _privateConstructorUsedError;

  /// Serializes this MonthlyStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyStatsCopyWith<MonthlyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyStatsCopyWith<$Res> {
  factory $MonthlyStatsCopyWith(
    MonthlyStats value,
    $Res Function(MonthlyStats) then,
  ) = _$MonthlyStatsCopyWithImpl<$Res, MonthlyStats>;
  @useResult
  $Res call({
    int year,
    String currency,
    List<MonthlyPoint> points,
    MonthlyTotals totals,
    MonthlyPoint? currentMonth,
    MonthlyComparison? comparison,
  });

  $MonthlyTotalsCopyWith<$Res> get totals;
  $MonthlyPointCopyWith<$Res>? get currentMonth;
  $MonthlyComparisonCopyWith<$Res>? get comparison;
}

/// @nodoc
class _$MonthlyStatsCopyWithImpl<$Res, $Val extends MonthlyStats>
    implements $MonthlyStatsCopyWith<$Res> {
  _$MonthlyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? currency = null,
    Object? points = null,
    Object? totals = null,
    Object? currentMonth = freezed,
    Object? comparison = freezed,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyPoint>,
            totals: null == totals
                ? _value.totals
                : totals // ignore: cast_nullable_to_non_nullable
                      as MonthlyTotals,
            currentMonth: freezed == currentMonth
                ? _value.currentMonth
                : currentMonth // ignore: cast_nullable_to_non_nullable
                      as MonthlyPoint?,
            comparison: freezed == comparison
                ? _value.comparison
                : comparison // ignore: cast_nullable_to_non_nullable
                      as MonthlyComparison?,
          )
          as $Val,
    );
  }

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonthlyTotalsCopyWith<$Res> get totals {
    return $MonthlyTotalsCopyWith<$Res>(_value.totals, (value) {
      return _then(_value.copyWith(totals: value) as $Val);
    });
  }

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonthlyPointCopyWith<$Res>? get currentMonth {
    if (_value.currentMonth == null) {
      return null;
    }

    return $MonthlyPointCopyWith<$Res>(_value.currentMonth!, (value) {
      return _then(_value.copyWith(currentMonth: value) as $Val);
    });
  }

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonthlyComparisonCopyWith<$Res>? get comparison {
    if (_value.comparison == null) {
      return null;
    }

    return $MonthlyComparisonCopyWith<$Res>(_value.comparison!, (value) {
      return _then(_value.copyWith(comparison: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MonthlyStatsImplCopyWith<$Res>
    implements $MonthlyStatsCopyWith<$Res> {
  factory _$$MonthlyStatsImplCopyWith(
    _$MonthlyStatsImpl value,
    $Res Function(_$MonthlyStatsImpl) then,
  ) = __$$MonthlyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int year,
    String currency,
    List<MonthlyPoint> points,
    MonthlyTotals totals,
    MonthlyPoint? currentMonth,
    MonthlyComparison? comparison,
  });

  @override
  $MonthlyTotalsCopyWith<$Res> get totals;
  @override
  $MonthlyPointCopyWith<$Res>? get currentMonth;
  @override
  $MonthlyComparisonCopyWith<$Res>? get comparison;
}

/// @nodoc
class __$$MonthlyStatsImplCopyWithImpl<$Res>
    extends _$MonthlyStatsCopyWithImpl<$Res, _$MonthlyStatsImpl>
    implements _$$MonthlyStatsImplCopyWith<$Res> {
  __$$MonthlyStatsImplCopyWithImpl(
    _$MonthlyStatsImpl _value,
    $Res Function(_$MonthlyStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? currency = null,
    Object? points = null,
    Object? totals = null,
    Object? currentMonth = freezed,
    Object? comparison = freezed,
  }) {
    return _then(
      _$MonthlyStatsImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value._points
            : points // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyPoint>,
        totals: null == totals
            ? _value.totals
            : totals // ignore: cast_nullable_to_non_nullable
                  as MonthlyTotals,
        currentMonth: freezed == currentMonth
            ? _value.currentMonth
            : currentMonth // ignore: cast_nullable_to_non_nullable
                  as MonthlyPoint?,
        comparison: freezed == comparison
            ? _value.comparison
            : comparison // ignore: cast_nullable_to_non_nullable
                  as MonthlyComparison?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$MonthlyStatsImpl implements _MonthlyStats {
  const _$MonthlyStatsImpl({
    required this.year,
    required this.currency,
    required final List<MonthlyPoint> points,
    required this.totals,
    this.currentMonth,
    this.comparison,
  }) : _points = points;

  factory _$MonthlyStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyStatsImplFromJson(json);

  @override
  final int year;
  @override
  final String currency;
  final List<MonthlyPoint> _points;
  @override
  List<MonthlyPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final MonthlyTotals totals;
  @override
  final MonthlyPoint? currentMonth;
  @override
  final MonthlyComparison? comparison;

  @override
  String toString() {
    return 'MonthlyStats(year: $year, currency: $currency, points: $points, totals: $totals, currentMonth: $currentMonth, comparison: $comparison)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyStatsImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.totals, totals) || other.totals == totals) &&
            (identical(other.currentMonth, currentMonth) ||
                other.currentMonth == currentMonth) &&
            (identical(other.comparison, comparison) ||
                other.comparison == comparison));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    year,
    currency,
    const DeepCollectionEquality().hash(_points),
    totals,
    currentMonth,
    comparison,
  );

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyStatsImplCopyWith<_$MonthlyStatsImpl> get copyWith =>
      __$$MonthlyStatsImplCopyWithImpl<_$MonthlyStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyStatsImplToJson(this);
  }
}

abstract class _MonthlyStats implements MonthlyStats {
  const factory _MonthlyStats({
    required final int year,
    required final String currency,
    required final List<MonthlyPoint> points,
    required final MonthlyTotals totals,
    final MonthlyPoint? currentMonth,
    final MonthlyComparison? comparison,
  }) = _$MonthlyStatsImpl;

  factory _MonthlyStats.fromJson(Map<String, dynamic> json) =
      _$MonthlyStatsImpl.fromJson;

  @override
  int get year;
  @override
  String get currency;
  @override
  List<MonthlyPoint> get points;
  @override
  MonthlyTotals get totals;
  @override
  MonthlyPoint? get currentMonth;
  @override
  MonthlyComparison? get comparison;

  /// Create a copy of MonthlyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyStatsImplCopyWith<_$MonthlyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyPoint _$MonthlyPointFromJson(Map<String, dynamic> json) {
  return _MonthlyPoint.fromJson(json);
}

/// @nodoc
mixin _$MonthlyPoint {
  String get month => throw _privateConstructorUsedError;
  int get ordersCount => throw _privateConstructorUsedError;
  int get walkinsCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get revenue => throw _privateConstructorUsedError;
  int get ordersRevenue => throw _privateConstructorUsedError;
  int get walkinsRevenue => throw _privateConstructorUsedError;
  int? get shops => throw _privateConstructorUsedError;

  /// Serializes this MonthlyPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyPointCopyWith<MonthlyPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyPointCopyWith<$Res> {
  factory $MonthlyPointCopyWith(
    MonthlyPoint value,
    $Res Function(MonthlyPoint) then,
  ) = _$MonthlyPointCopyWithImpl<$Res, MonthlyPoint>;
  @useResult
  $Res call({
    String month,
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
    int? shops,
  });
}

/// @nodoc
class _$MonthlyPointCopyWithImpl<$Res, $Val extends MonthlyPoint>
    implements $MonthlyPointCopyWith<$Res> {
  _$MonthlyPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
    Object? shops = freezed,
  }) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            ordersCount: null == ordersCount
                ? _value.ordersCount
                : ordersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsCount: null == walkinsCount
                ? _value.walkinsCount
                : walkinsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            ordersRevenue: null == ordersRevenue
                ? _value.ordersRevenue
                : ordersRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsRevenue: null == walkinsRevenue
                ? _value.walkinsRevenue
                : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            shops: freezed == shops
                ? _value.shops
                : shops // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyPointImplCopyWith<$Res>
    implements $MonthlyPointCopyWith<$Res> {
  factory _$$MonthlyPointImplCopyWith(
    _$MonthlyPointImpl value,
    $Res Function(_$MonthlyPointImpl) then,
  ) = __$$MonthlyPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String month,
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
    int? shops,
  });
}

/// @nodoc
class __$$MonthlyPointImplCopyWithImpl<$Res>
    extends _$MonthlyPointCopyWithImpl<$Res, _$MonthlyPointImpl>
    implements _$$MonthlyPointImplCopyWith<$Res> {
  __$$MonthlyPointImplCopyWithImpl(
    _$MonthlyPointImpl _value,
    $Res Function(_$MonthlyPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
    Object? shops = freezed,
  }) {
    return _then(
      _$MonthlyPointImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        ordersCount: null == ordersCount
            ? _value.ordersCount
            : ordersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsCount: null == walkinsCount
            ? _value.walkinsCount
            : walkinsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        ordersRevenue: null == ordersRevenue
            ? _value.ordersRevenue
            : ordersRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsRevenue: null == walkinsRevenue
            ? _value.walkinsRevenue
            : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        shops: freezed == shops
            ? _value.shops
            : shops // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$MonthlyPointImpl implements _MonthlyPoint {
  const _$MonthlyPointImpl({
    required this.month,
    this.ordersCount = 0,
    this.walkinsCount = 0,
    this.totalCount = 0,
    this.revenue = 0,
    this.ordersRevenue = 0,
    this.walkinsRevenue = 0,
    this.shops,
  });

  factory _$MonthlyPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyPointImplFromJson(json);

  @override
  final String month;
  @override
  @JsonKey()
  final int ordersCount;
  @override
  @JsonKey()
  final int walkinsCount;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int revenue;
  @override
  @JsonKey()
  final int ordersRevenue;
  @override
  @JsonKey()
  final int walkinsRevenue;
  @override
  final int? shops;

  @override
  String toString() {
    return 'MonthlyPoint(month: $month, ordersCount: $ordersCount, walkinsCount: $walkinsCount, totalCount: $totalCount, revenue: $revenue, ordersRevenue: $ordersRevenue, walkinsRevenue: $walkinsRevenue, shops: $shops)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyPointImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount) &&
            (identical(other.walkinsCount, walkinsCount) ||
                other.walkinsCount == walkinsCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.ordersRevenue, ordersRevenue) ||
                other.ordersRevenue == ordersRevenue) &&
            (identical(other.walkinsRevenue, walkinsRevenue) ||
                other.walkinsRevenue == walkinsRevenue) &&
            (identical(other.shops, shops) || other.shops == shops));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    month,
    ordersCount,
    walkinsCount,
    totalCount,
    revenue,
    ordersRevenue,
    walkinsRevenue,
    shops,
  );

  /// Create a copy of MonthlyPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyPointImplCopyWith<_$MonthlyPointImpl> get copyWith =>
      __$$MonthlyPointImplCopyWithImpl<_$MonthlyPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyPointImplToJson(this);
  }
}

abstract class _MonthlyPoint implements MonthlyPoint {
  const factory _MonthlyPoint({
    required final String month,
    final int ordersCount,
    final int walkinsCount,
    final int totalCount,
    final int revenue,
    final int ordersRevenue,
    final int walkinsRevenue,
    final int? shops,
  }) = _$MonthlyPointImpl;

  factory _MonthlyPoint.fromJson(Map<String, dynamic> json) =
      _$MonthlyPointImpl.fromJson;

  @override
  String get month;
  @override
  int get ordersCount;
  @override
  int get walkinsCount;
  @override
  int get totalCount;
  @override
  int get revenue;
  @override
  int get ordersRevenue;
  @override
  int get walkinsRevenue;
  @override
  int? get shops;

  /// Create a copy of MonthlyPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyPointImplCopyWith<_$MonthlyPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyTotals _$MonthlyTotalsFromJson(Map<String, dynamic> json) {
  return _MonthlyTotals.fromJson(json);
}

/// @nodoc
mixin _$MonthlyTotals {
  int get ordersCount => throw _privateConstructorUsedError;
  int get walkinsCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get revenue => throw _privateConstructorUsedError;
  int get ordersRevenue => throw _privateConstructorUsedError;
  int get walkinsRevenue => throw _privateConstructorUsedError;
  int? get shops => throw _privateConstructorUsedError;

  /// Serializes this MonthlyTotals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyTotalsCopyWith<MonthlyTotals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyTotalsCopyWith<$Res> {
  factory $MonthlyTotalsCopyWith(
    MonthlyTotals value,
    $Res Function(MonthlyTotals) then,
  ) = _$MonthlyTotalsCopyWithImpl<$Res, MonthlyTotals>;
  @useResult
  $Res call({
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
    int? shops,
  });
}

/// @nodoc
class _$MonthlyTotalsCopyWithImpl<$Res, $Val extends MonthlyTotals>
    implements $MonthlyTotalsCopyWith<$Res> {
  _$MonthlyTotalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
    Object? shops = freezed,
  }) {
    return _then(
      _value.copyWith(
            ordersCount: null == ordersCount
                ? _value.ordersCount
                : ordersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsCount: null == walkinsCount
                ? _value.walkinsCount
                : walkinsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as int,
            ordersRevenue: null == ordersRevenue
                ? _value.ordersRevenue
                : ordersRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            walkinsRevenue: null == walkinsRevenue
                ? _value.walkinsRevenue
                : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            shops: freezed == shops
                ? _value.shops
                : shops // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyTotalsImplCopyWith<$Res>
    implements $MonthlyTotalsCopyWith<$Res> {
  factory _$$MonthlyTotalsImplCopyWith(
    _$MonthlyTotalsImpl value,
    $Res Function(_$MonthlyTotalsImpl) then,
  ) = __$$MonthlyTotalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int ordersCount,
    int walkinsCount,
    int totalCount,
    int revenue,
    int ordersRevenue,
    int walkinsRevenue,
    int? shops,
  });
}

/// @nodoc
class __$$MonthlyTotalsImplCopyWithImpl<$Res>
    extends _$MonthlyTotalsCopyWithImpl<$Res, _$MonthlyTotalsImpl>
    implements _$$MonthlyTotalsImplCopyWith<$Res> {
  __$$MonthlyTotalsImplCopyWithImpl(
    _$MonthlyTotalsImpl _value,
    $Res Function(_$MonthlyTotalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ordersCount = null,
    Object? walkinsCount = null,
    Object? totalCount = null,
    Object? revenue = null,
    Object? ordersRevenue = null,
    Object? walkinsRevenue = null,
    Object? shops = freezed,
  }) {
    return _then(
      _$MonthlyTotalsImpl(
        ordersCount: null == ordersCount
            ? _value.ordersCount
            : ordersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsCount: null == walkinsCount
            ? _value.walkinsCount
            : walkinsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as int,
        ordersRevenue: null == ordersRevenue
            ? _value.ordersRevenue
            : ordersRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        walkinsRevenue: null == walkinsRevenue
            ? _value.walkinsRevenue
            : walkinsRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        shops: freezed == shops
            ? _value.shops
            : shops // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$MonthlyTotalsImpl implements _MonthlyTotals {
  const _$MonthlyTotalsImpl({
    this.ordersCount = 0,
    this.walkinsCount = 0,
    this.totalCount = 0,
    this.revenue = 0,
    this.ordersRevenue = 0,
    this.walkinsRevenue = 0,
    this.shops,
  });

  factory _$MonthlyTotalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyTotalsImplFromJson(json);

  @override
  @JsonKey()
  final int ordersCount;
  @override
  @JsonKey()
  final int walkinsCount;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int revenue;
  @override
  @JsonKey()
  final int ordersRevenue;
  @override
  @JsonKey()
  final int walkinsRevenue;
  @override
  final int? shops;

  @override
  String toString() {
    return 'MonthlyTotals(ordersCount: $ordersCount, walkinsCount: $walkinsCount, totalCount: $totalCount, revenue: $revenue, ordersRevenue: $ordersRevenue, walkinsRevenue: $walkinsRevenue, shops: $shops)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyTotalsImpl &&
            (identical(other.ordersCount, ordersCount) ||
                other.ordersCount == ordersCount) &&
            (identical(other.walkinsCount, walkinsCount) ||
                other.walkinsCount == walkinsCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.ordersRevenue, ordersRevenue) ||
                other.ordersRevenue == ordersRevenue) &&
            (identical(other.walkinsRevenue, walkinsRevenue) ||
                other.walkinsRevenue == walkinsRevenue) &&
            (identical(other.shops, shops) || other.shops == shops));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ordersCount,
    walkinsCount,
    totalCount,
    revenue,
    ordersRevenue,
    walkinsRevenue,
    shops,
  );

  /// Create a copy of MonthlyTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyTotalsImplCopyWith<_$MonthlyTotalsImpl> get copyWith =>
      __$$MonthlyTotalsImplCopyWithImpl<_$MonthlyTotalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyTotalsImplToJson(this);
  }
}

abstract class _MonthlyTotals implements MonthlyTotals {
  const factory _MonthlyTotals({
    final int ordersCount,
    final int walkinsCount,
    final int totalCount,
    final int revenue,
    final int ordersRevenue,
    final int walkinsRevenue,
    final int? shops,
  }) = _$MonthlyTotalsImpl;

  factory _MonthlyTotals.fromJson(Map<String, dynamic> json) =
      _$MonthlyTotalsImpl.fromJson;

  @override
  int get ordersCount;
  @override
  int get walkinsCount;
  @override
  int get totalCount;
  @override
  int get revenue;
  @override
  int get ordersRevenue;
  @override
  int get walkinsRevenue;
  @override
  int? get shops;

  /// Create a copy of MonthlyTotals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyTotalsImplCopyWith<_$MonthlyTotalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyComparison _$MonthlyComparisonFromJson(Map<String, dynamic> json) {
  return _MonthlyComparison.fromJson(json);
}

/// @nodoc
mixin _$MonthlyComparison {
  int get previousYear => throw _privateConstructorUsedError;
  int get previousRevenue => throw _privateConstructorUsedError;
  double? get changePercent => throw _privateConstructorUsedError;

  /// Serializes this MonthlyComparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyComparisonCopyWith<MonthlyComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyComparisonCopyWith<$Res> {
  factory $MonthlyComparisonCopyWith(
    MonthlyComparison value,
    $Res Function(MonthlyComparison) then,
  ) = _$MonthlyComparisonCopyWithImpl<$Res, MonthlyComparison>;
  @useResult
  $Res call({int previousYear, int previousRevenue, double? changePercent});
}

/// @nodoc
class _$MonthlyComparisonCopyWithImpl<$Res, $Val extends MonthlyComparison>
    implements $MonthlyComparisonCopyWith<$Res> {
  _$MonthlyComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousYear = null,
    Object? previousRevenue = null,
    Object? changePercent = freezed,
  }) {
    return _then(
      _value.copyWith(
            previousYear: null == previousYear
                ? _value.previousYear
                : previousYear // ignore: cast_nullable_to_non_nullable
                      as int,
            previousRevenue: null == previousRevenue
                ? _value.previousRevenue
                : previousRevenue // ignore: cast_nullable_to_non_nullable
                      as int,
            changePercent: freezed == changePercent
                ? _value.changePercent
                : changePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyComparisonImplCopyWith<$Res>
    implements $MonthlyComparisonCopyWith<$Res> {
  factory _$$MonthlyComparisonImplCopyWith(
    _$MonthlyComparisonImpl value,
    $Res Function(_$MonthlyComparisonImpl) then,
  ) = __$$MonthlyComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int previousYear, int previousRevenue, double? changePercent});
}

/// @nodoc
class __$$MonthlyComparisonImplCopyWithImpl<$Res>
    extends _$MonthlyComparisonCopyWithImpl<$Res, _$MonthlyComparisonImpl>
    implements _$$MonthlyComparisonImplCopyWith<$Res> {
  __$$MonthlyComparisonImplCopyWithImpl(
    _$MonthlyComparisonImpl _value,
    $Res Function(_$MonthlyComparisonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousYear = null,
    Object? previousRevenue = null,
    Object? changePercent = freezed,
  }) {
    return _then(
      _$MonthlyComparisonImpl(
        previousYear: null == previousYear
            ? _value.previousYear
            : previousYear // ignore: cast_nullable_to_non_nullable
                  as int,
        previousRevenue: null == previousRevenue
            ? _value.previousRevenue
            : previousRevenue // ignore: cast_nullable_to_non_nullable
                  as int,
        changePercent: freezed == changePercent
            ? _value.changePercent
            : changePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$MonthlyComparisonImpl implements _MonthlyComparison {
  const _$MonthlyComparisonImpl({
    required this.previousYear,
    required this.previousRevenue,
    this.changePercent,
  });

  factory _$MonthlyComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyComparisonImplFromJson(json);

  @override
  final int previousYear;
  @override
  final int previousRevenue;
  @override
  final double? changePercent;

  @override
  String toString() {
    return 'MonthlyComparison(previousYear: $previousYear, previousRevenue: $previousRevenue, changePercent: $changePercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyComparisonImpl &&
            (identical(other.previousYear, previousYear) ||
                other.previousYear == previousYear) &&
            (identical(other.previousRevenue, previousRevenue) ||
                other.previousRevenue == previousRevenue) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, previousYear, previousRevenue, changePercent);

  /// Create a copy of MonthlyComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyComparisonImplCopyWith<_$MonthlyComparisonImpl> get copyWith =>
      __$$MonthlyComparisonImplCopyWithImpl<_$MonthlyComparisonImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyComparisonImplToJson(this);
  }
}

abstract class _MonthlyComparison implements MonthlyComparison {
  const factory _MonthlyComparison({
    required final int previousYear,
    required final int previousRevenue,
    final double? changePercent,
  }) = _$MonthlyComparisonImpl;

  factory _MonthlyComparison.fromJson(Map<String, dynamic> json) =
      _$MonthlyComparisonImpl.fromJson;

  @override
  int get previousYear;
  @override
  int get previousRevenue;
  @override
  double? get changePercent;

  /// Create a copy of MonthlyComparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyComparisonImplCopyWith<_$MonthlyComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
