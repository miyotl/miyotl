// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'SignInResult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SignInResultTearOff {
  const _$SignInResultTearOff();

  _SignInResult call(
      {bool success = false, UserAuthModel? data, Exception? error}) {
    return _SignInResult(
      success: success,
      data: data,
      error: error,
    );
  }
}

/// @nodoc
const $SignInResult = _$SignInResultTearOff();

/// @nodoc
mixin _$SignInResult {
  bool get success => throw _privateConstructorUsedError;
  UserAuthModel? get data => throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInResultCopyWith<SignInResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInResultCopyWith<$Res> {
  factory $SignInResultCopyWith(
          SignInResult value, $Res Function(SignInResult) then) =
      _$SignInResultCopyWithImpl<$Res>;
  $Res call({bool success, UserAuthModel? data, Exception? error});
}

/// @nodoc
class _$SignInResultCopyWithImpl<$Res> implements $SignInResultCopyWith<$Res> {
  _$SignInResultCopyWithImpl(this._value, this._then);

  final SignInResult _value;
  // ignore: unused_field
  final $Res Function(SignInResult) _then;

  @override
  $Res call({
    Object? success = freezed,
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UserAuthModel?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc
abstract class _$SignInResultCopyWith<$Res>
    implements $SignInResultCopyWith<$Res> {
  factory _$SignInResultCopyWith(
          _SignInResult value, $Res Function(_SignInResult) then) =
      __$SignInResultCopyWithImpl<$Res>;
  @override
  $Res call({bool success, UserAuthModel? data, Exception? error});
}

/// @nodoc
class __$SignInResultCopyWithImpl<$Res> extends _$SignInResultCopyWithImpl<$Res>
    implements _$SignInResultCopyWith<$Res> {
  __$SignInResultCopyWithImpl(
      _SignInResult _value, $Res Function(_SignInResult) _then)
      : super(_value, (v) => _then(v as _SignInResult));

  @override
  _SignInResult get _value => super._value as _SignInResult;

  @override
  $Res call({
    Object? success = freezed,
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(_SignInResult(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UserAuthModel?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$_SignInResult implements _SignInResult {
  const _$_SignInResult({this.success = false, this.data, this.error});

  @JsonKey()
  @override
  final bool success;
  @override
  final UserAuthModel? data;
  @override
  final Exception? error;

  @override
  String toString() {
    return 'SignInResult(success: $success, data: $data, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignInResult &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$SignInResultCopyWith<_SignInResult> get copyWith =>
      __$SignInResultCopyWithImpl<_SignInResult>(this, _$identity);
}

abstract class _SignInResult implements SignInResult {
  const factory _SignInResult(
      {bool success, UserAuthModel? data, Exception? error}) = _$_SignInResult;

  @override
  bool get success;
  @override
  UserAuthModel? get data;
  @override
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$SignInResultCopyWith<_SignInResult> get copyWith =>
      throw _privateConstructorUsedError;
}
