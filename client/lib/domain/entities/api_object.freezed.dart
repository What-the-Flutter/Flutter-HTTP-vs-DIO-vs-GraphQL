// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiObject _$ApiObjectFromJson(Map<String, dynamic> json) {
  return _ApiObject.fromJson(json);
}

/// @nodoc
mixin _$ApiObject {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiObjectCopyWith<$Res> {
  factory $ApiObjectCopyWith(ApiObject value, $Res Function(ApiObject) then) =
      _$ApiObjectCopyWithImpl<$Res, ApiObject>;
}

/// @nodoc
class _$ApiObjectCopyWithImpl<$Res, $Val extends ApiObject>
    implements $ApiObjectCopyWith<$Res> {
  _$ApiObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ApiObjectCopyWith<$Res> {
  factory _$$_ApiObjectCopyWith(
          _$_ApiObject value, $Res Function(_$_ApiObject) then) =
      __$$_ApiObjectCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ApiObjectCopyWithImpl<$Res>
    extends _$ApiObjectCopyWithImpl<$Res, _$_ApiObject>
    implements _$$_ApiObjectCopyWith<$Res> {
  __$$_ApiObjectCopyWithImpl(
      _$_ApiObject _value, $Res Function(_$_ApiObject) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_ApiObject implements _ApiObject {
  const _$_ApiObject();

  factory _$_ApiObject.fromJson(Map<String, dynamic> json) =>
      _$$_ApiObjectFromJson(json);

  @override
  String toString() {
    return 'ApiObject()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ApiObject);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApiObjectToJson(
      this,
    );
  }
}

abstract class _ApiObject implements ApiObject {
  const factory _ApiObject() = _$_ApiObject;

  factory _ApiObject.fromJson(Map<String, dynamic> json) =
      _$_ApiObject.fromJson;
}
