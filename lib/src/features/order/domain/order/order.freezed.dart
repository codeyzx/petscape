// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'customerId')
  String? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sellerId')
  String? get sellerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<Map<String, dynamic>>? get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'itemsCategory')
  String? get itemsCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalPayment')
  int? get totalPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'methodPayment')
  String? get methodPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'statusPayment')
  String? get statusPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'tokenPayment')
  String? get tokenPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'customerId') String? customerId,
      @JsonKey(name: 'sellerId') String? sellerId,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'items') List<Map<String, dynamic>>? items,
      @JsonKey(name: 'itemsCategory') String? itemsCategory,
      @JsonKey(name: 'totalPayment') int? totalPayment,
      @JsonKey(name: 'methodPayment') String? methodPayment,
      @JsonKey(name: 'statusPayment') String? statusPayment,
      @JsonKey(name: 'tokenPayment') String? tokenPayment});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? sellerId = freezed,
    Object? createdAt = freezed,
    Object? items = freezed,
    Object? itemsCategory = freezed,
    Object? totalPayment = freezed,
    Object? methodPayment = freezed,
    Object? statusPayment = freezed,
    Object? tokenPayment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      itemsCategory: freezed == itemsCategory
          ? _value.itemsCategory
          : itemsCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      methodPayment: freezed == methodPayment
          ? _value.methodPayment
          : methodPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenPayment: freezed == tokenPayment
          ? _value.tokenPayment
          : tokenPayment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$_OrderCopyWith(_$_Order value, $Res Function(_$_Order) then) =
      __$$_OrderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'customerId') String? customerId,
      @JsonKey(name: 'sellerId') String? sellerId,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'items') List<Map<String, dynamic>>? items,
      @JsonKey(name: 'itemsCategory') String? itemsCategory,
      @JsonKey(name: 'totalPayment') int? totalPayment,
      @JsonKey(name: 'methodPayment') String? methodPayment,
      @JsonKey(name: 'statusPayment') String? statusPayment,
      @JsonKey(name: 'tokenPayment') String? tokenPayment});
}

/// @nodoc
class __$$_OrderCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res, _$_Order>
    implements _$$_OrderCopyWith<$Res> {
  __$$_OrderCopyWithImpl(_$_Order _value, $Res Function(_$_Order) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customerId = freezed,
    Object? sellerId = freezed,
    Object? createdAt = freezed,
    Object? items = freezed,
    Object? itemsCategory = freezed,
    Object? totalPayment = freezed,
    Object? methodPayment = freezed,
    Object? statusPayment = freezed,
    Object? tokenPayment = freezed,
  }) {
    return _then(_$_Order(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      itemsCategory: freezed == itemsCategory
          ? _value.itemsCategory
          : itemsCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      methodPayment: freezed == methodPayment
          ? _value.methodPayment
          : methodPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenPayment: freezed == tokenPayment
          ? _value.tokenPayment
          : tokenPayment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Order implements _Order {
  const _$_Order(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'customerId') this.customerId,
      @JsonKey(name: 'sellerId') this.sellerId,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'items') final List<Map<String, dynamic>>? items,
      @JsonKey(name: 'itemsCategory') this.itemsCategory,
      @JsonKey(name: 'totalPayment') this.totalPayment,
      @JsonKey(name: 'methodPayment') this.methodPayment,
      @JsonKey(name: 'statusPayment') this.statusPayment,
      @JsonKey(name: 'tokenPayment') this.tokenPayment})
      : _items = items;

  factory _$_Order.fromJson(Map<String, dynamic> json) =>
      _$$_OrderFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'customerId')
  final String? customerId;
  @override
  @JsonKey(name: 'sellerId')
  final String? sellerId;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  final List<Map<String, dynamic>>? _items;
  @override
  @JsonKey(name: 'items')
  List<Map<String, dynamic>>? get items {
    final value = _items;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'itemsCategory')
  final String? itemsCategory;
  @override
  @JsonKey(name: 'totalPayment')
  final int? totalPayment;
  @override
  @JsonKey(name: 'methodPayment')
  final String? methodPayment;
  @override
  @JsonKey(name: 'statusPayment')
  final String? statusPayment;
  @override
  @JsonKey(name: 'tokenPayment')
  final String? tokenPayment;

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, sellerId: $sellerId, createdAt: $createdAt, items: $items, itemsCategory: $itemsCategory, totalPayment: $totalPayment, methodPayment: $methodPayment, statusPayment: $statusPayment, tokenPayment: $tokenPayment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.itemsCategory, itemsCategory) ||
                other.itemsCategory == itemsCategory) &&
            (identical(other.totalPayment, totalPayment) ||
                other.totalPayment == totalPayment) &&
            (identical(other.methodPayment, methodPayment) ||
                other.methodPayment == methodPayment) &&
            (identical(other.statusPayment, statusPayment) ||
                other.statusPayment == statusPayment) &&
            (identical(other.tokenPayment, tokenPayment) ||
                other.tokenPayment == tokenPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      customerId,
      sellerId,
      createdAt,
      const DeepCollectionEquality().hash(_items),
      itemsCategory,
      totalPayment,
      methodPayment,
      statusPayment,
      tokenPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderCopyWith<_$_Order> get copyWith =>
      __$$_OrderCopyWithImpl<_$_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'customerId') final String? customerId,
      @JsonKey(name: 'sellerId') final String? sellerId,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'items') final List<Map<String, dynamic>>? items,
      @JsonKey(name: 'itemsCategory') final String? itemsCategory,
      @JsonKey(name: 'totalPayment') final int? totalPayment,
      @JsonKey(name: 'methodPayment') final String? methodPayment,
      @JsonKey(name: 'statusPayment') final String? statusPayment,
      @JsonKey(name: 'tokenPayment') final String? tokenPayment}) = _$_Order;

  factory _Order.fromJson(Map<String, dynamic> json) = _$_Order.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'customerId')
  String? get customerId;
  @override
  @JsonKey(name: 'sellerId')
  String? get sellerId;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'items')
  List<Map<String, dynamic>>? get items;
  @override
  @JsonKey(name: 'itemsCategory')
  String? get itemsCategory;
  @override
  @JsonKey(name: 'totalPayment')
  int? get totalPayment;
  @override
  @JsonKey(name: 'methodPayment')
  String? get methodPayment;
  @override
  @JsonKey(name: 'statusPayment')
  String? get statusPayment;
  @override
  @JsonKey(name: 'tokenPayment')
  String? get tokenPayment;
  @override
  @JsonKey(ignore: true)
  _$$_OrderCopyWith<_$_Order> get copyWith =>
      throw _privateConstructorUsedError;
}
