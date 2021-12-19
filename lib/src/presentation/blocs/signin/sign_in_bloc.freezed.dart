// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SignInEventTearOff {
  const _$SignInEventTearOff();

  _SignInEvent call({required String provider}) {
    return _SignInEvent(
      provider: provider,
    );
  }
}

/// @nodoc
const $SignInEvent = _$SignInEventTearOff();

/// @nodoc
mixin _$SignInEvent {
  String get provider => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInEventCopyWith<SignInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInEventCopyWith<$Res> {
  factory $SignInEventCopyWith(
          SignInEvent value, $Res Function(SignInEvent) then) =
      _$SignInEventCopyWithImpl<$Res>;
  $Res call({String provider});
}

/// @nodoc
class _$SignInEventCopyWithImpl<$Res> implements $SignInEventCopyWith<$Res> {
  _$SignInEventCopyWithImpl(this._value, this._then);

  final SignInEvent _value;
  // ignore: unused_field
  final $Res Function(SignInEvent) _then;

  @override
  $Res call({
    Object? provider = freezed,
  }) {
    return _then(_value.copyWith(
      provider: provider == freezed
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$SignInEventCopyWith<$Res>
    implements $SignInEventCopyWith<$Res> {
  factory _$SignInEventCopyWith(
          _SignInEvent value, $Res Function(_SignInEvent) then) =
      __$SignInEventCopyWithImpl<$Res>;
  @override
  $Res call({String provider});
}

/// @nodoc
class __$SignInEventCopyWithImpl<$Res> extends _$SignInEventCopyWithImpl<$Res>
    implements _$SignInEventCopyWith<$Res> {
  __$SignInEventCopyWithImpl(
      _SignInEvent _value, $Res Function(_SignInEvent) _then)
      : super(_value, (v) => _then(v as _SignInEvent));

  @override
  _SignInEvent get _value => super._value as _SignInEvent;

  @override
  $Res call({
    Object? provider = freezed,
  }) {
    return _then(_SignInEvent(
      provider: provider == freezed
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SignInEvent implements _SignInEvent {
  const _$_SignInEvent({required this.provider});

  @override
  final String provider;

  @override
  String toString() {
    return 'SignInEvent(provider: $provider)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignInEvent &&
            const DeepCollectionEquality().equals(other.provider, provider));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(provider));

  @JsonKey(ignore: true)
  @override
  _$SignInEventCopyWith<_SignInEvent> get copyWith =>
      __$SignInEventCopyWithImpl<_SignInEvent>(this, _$identity);
}

abstract class _SignInEvent implements SignInEvent {
  const factory _SignInEvent({required String provider}) = _$_SignInEvent;

  @override
  String get provider;
  @override
  @JsonKey(ignore: true)
  _$SignInEventCopyWith<_SignInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$SignInStateTearOff {
  const _$SignInStateTearOff();

  _SignInState call({bool userLoggedIn = true}) {
    return _SignInState(
      userLoggedIn: userLoggedIn,
    );
  }
}

/// @nodoc
const $SignInState = _$SignInStateTearOff();

/// @nodoc
mixin _$SignInState {
  bool get userLoggedIn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInStateCopyWith<SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res>;
  $Res call({bool userLoggedIn});
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res> implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  final SignInState _value;
  // ignore: unused_field
  final $Res Function(SignInState) _then;

  @override
  $Res call({
    Object? userLoggedIn = freezed,
  }) {
    return _then(_value.copyWith(
      userLoggedIn: userLoggedIn == freezed
          ? _value.userLoggedIn
          : userLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$SignInStateCopyWith<$Res>
    implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(
          _SignInState value, $Res Function(_SignInState) then) =
      __$SignInStateCopyWithImpl<$Res>;
  @override
  $Res call({bool userLoggedIn});
}

/// @nodoc
class __$SignInStateCopyWithImpl<$Res> extends _$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(
      _SignInState _value, $Res Function(_SignInState) _then)
      : super(_value, (v) => _then(v as _SignInState));

  @override
  _SignInState get _value => super._value as _SignInState;

  @override
  $Res call({
    Object? userLoggedIn = freezed,
  }) {
    return _then(_SignInState(
      userLoggedIn: userLoggedIn == freezed
          ? _value.userLoggedIn
          : userLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SignInState implements _SignInState {
  const _$_SignInState({this.userLoggedIn = true});

  @JsonKey()
  @override
  final bool userLoggedIn;

  @override
  String toString() {
    return 'SignInState(userLoggedIn: $userLoggedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignInState &&
            const DeepCollectionEquality()
                .equals(other.userLoggedIn, userLoggedIn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(userLoggedIn));

  @JsonKey(ignore: true)
  @override
  _$SignInStateCopyWith<_SignInState> get copyWith =>
      __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);
}

abstract class _SignInState implements SignInState {
  const factory _SignInState({bool userLoggedIn}) = _$_SignInState;

  @override
  bool get userLoggedIn;
  @override
  @JsonKey(ignore: true)
  _$SignInStateCopyWith<_SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}
