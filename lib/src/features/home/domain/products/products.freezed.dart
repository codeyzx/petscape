// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'products.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return _Products.fromJson(json);
}

/// @nodoc
mixin _$Products {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'desc')
  String? get desc => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String? get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductsCopyWith<Products> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsCopyWith<$Res> {
  factory $ProductsCopyWith(Products value, $Res Function(Products) then) =
      _$ProductsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'desc') String? desc,
      @JsonKey(name: 'category') String? category});
}

/// @nodoc
class _$ProductsCopyWithImpl<$Res> implements $ProductsCopyWith<$Res> {
  _$ProductsCopyWithImpl(this._value, this._then);

  final Products _value;
  // ignore: unused_field
  final $Res Function(Products) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? desc = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductsCopyWith<$Res> implements $ProductsCopyWith<$Res> {
  factory _$$_ProductsCopyWith(
          _$_Products value, $Res Function(_$_Products) then) =
      __$$_ProductsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'desc') String? desc,
      @JsonKey(name: 'category') String? category});
}

/// @nodoc
class __$$_ProductsCopyWithImpl<$Res> extends _$ProductsCopyWithImpl<$Res>
    implements _$$_ProductsCopyWith<$Res> {
  __$$_ProductsCopyWithImpl(
      _$_Products _value, $Res Function(_$_Products) _then)
      : super(_value, (v) => _then(v as _$_Products));

  @override
  _$_Products get _value => super._value as _$_Products;

  @override
  $Res call({
    Object? name = freezed,
    Object? desc = freezed,
    Object? category = freezed,
  }) {
    return _then(_$_Products(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Products implements _Products {
  const _$_Products(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'desc') this.desc,
      @JsonKey(name: 'category') this.category});

  factory _$_Products.fromJson(Map<String, dynamic> json) =>
      _$$_ProductsFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'desc')
  final String? desc;
  @override
  @JsonKey(name: 'category')
  final String? category;

  @override
  String toString() {
    return 'Products(name: $name, desc: $desc, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Products &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.category, category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(category));

  @JsonKey(ignore: true)
  @override
  _$$_ProductsCopyWith<_$_Products> get copyWith =>
      __$$_ProductsCopyWithImpl<_$_Products>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductsToJson(
      this,
    );
  }
}

abstract class _Products implements Products {
  const factory _Products(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'desc') final String? desc,
      @JsonKey(name: 'category') final String? category}) = _$_Products;

  factory _Products.fromJson(Map<String, dynamic> json) = _$_Products.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'desc')
  String? get desc;
  @override
  @JsonKey(name: 'category')
  String? get category;
  @override
  @JsonKey(ignore: true)
  _$$_ProductsCopyWith<_$_Products> get copyWith =>
      throw _privateConstructorUsedError;
}
