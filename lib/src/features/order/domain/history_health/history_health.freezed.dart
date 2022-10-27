// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'history_health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HistoryHealth _$HistoryHealthFromJson(Map<String, dynamic> json) {
  return _HistoryHealth.fromJson(json);
}

/// @nodoc
mixin _$HistoryHealth {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'petId')
  String? get petId => throw _privateConstructorUsedError;
  @JsonKey(name: 'time')
  String? get time => throw _privateConstructorUsedError;
  @JsonKey(name: 'problem')
  List<String>? get problem => throw _privateConstructorUsedError;
  @JsonKey(name: 'desc')
  String? get desc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryHealthCopyWith<HistoryHealth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryHealthCopyWith<$Res> {
  factory $HistoryHealthCopyWith(
          HistoryHealth value, $Res Function(HistoryHealth) then) =
      _$HistoryHealthCopyWithImpl<$Res, HistoryHealth>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'petId') String? petId,
      @JsonKey(name: 'time') String? time,
      @JsonKey(name: 'problem') List<String>? problem,
      @JsonKey(name: 'desc') String? desc});
}

/// @nodoc
class _$HistoryHealthCopyWithImpl<$Res, $Val extends HistoryHealth>
    implements $HistoryHealthCopyWith<$Res> {
  _$HistoryHealthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? petId = freezed,
    Object? time = freezed,
    Object? problem = freezed,
    Object? desc = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      petId: freezed == petId
          ? _value.petId
          : petId // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      problem: freezed == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HistoryHealthCopyWith<$Res>
    implements $HistoryHealthCopyWith<$Res> {
  factory _$$_HistoryHealthCopyWith(
          _$_HistoryHealth value, $Res Function(_$_HistoryHealth) then) =
      __$$_HistoryHealthCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'petId') String? petId,
      @JsonKey(name: 'time') String? time,
      @JsonKey(name: 'problem') List<String>? problem,
      @JsonKey(name: 'desc') String? desc});
}

/// @nodoc
class __$$_HistoryHealthCopyWithImpl<$Res>
    extends _$HistoryHealthCopyWithImpl<$Res, _$_HistoryHealth>
    implements _$$_HistoryHealthCopyWith<$Res> {
  __$$_HistoryHealthCopyWithImpl(
      _$_HistoryHealth _value, $Res Function(_$_HistoryHealth) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? petId = freezed,
    Object? time = freezed,
    Object? problem = freezed,
    Object? desc = freezed,
  }) {
    return _then(_$_HistoryHealth(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      petId: freezed == petId
          ? _value.petId
          : petId // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      problem: freezed == problem
          ? _value._problem
          : problem // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HistoryHealth implements _HistoryHealth {
  const _$_HistoryHealth(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'petId') this.petId,
      @JsonKey(name: 'time') this.time,
      @JsonKey(name: 'problem') final List<String>? problem,
      @JsonKey(name: 'desc') this.desc})
      : _problem = problem;

  factory _$_HistoryHealth.fromJson(Map<String, dynamic> json) =>
      _$$_HistoryHealthFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'petId')
  final String? petId;
  @override
  @JsonKey(name: 'time')
  final String? time;
  final List<String>? _problem;
  @override
  @JsonKey(name: 'problem')
  List<String>? get problem {
    final value = _problem;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'desc')
  final String? desc;

  @override
  String toString() {
    return 'HistoryHealth(id: $id, petId: $petId, time: $time, problem: $problem, desc: $desc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HistoryHealth &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.petId, petId) || other.petId == petId) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._problem, _problem) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, petId, time,
      const DeepCollectionEquality().hash(_problem), desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HistoryHealthCopyWith<_$_HistoryHealth> get copyWith =>
      __$$_HistoryHealthCopyWithImpl<_$_HistoryHealth>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HistoryHealthToJson(
      this,
    );
  }
}

abstract class _HistoryHealth implements HistoryHealth {
  const factory _HistoryHealth(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'petId') final String? petId,
      @JsonKey(name: 'time') final String? time,
      @JsonKey(name: 'problem') final List<String>? problem,
      @JsonKey(name: 'desc') final String? desc}) = _$_HistoryHealth;

  factory _HistoryHealth.fromJson(Map<String, dynamic> json) =
      _$_HistoryHealth.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'petId')
  String? get petId;
  @override
  @JsonKey(name: 'time')
  String? get time;
  @override
  @JsonKey(name: 'problem')
  List<String>? get problem;
  @override
  @JsonKey(name: 'desc')
  String? get desc;
  @override
  @JsonKey(ignore: true)
  _$$_HistoryHealthCopyWith<_$_HistoryHealth> get copyWith =>
      throw _privateConstructorUsedError;
}
