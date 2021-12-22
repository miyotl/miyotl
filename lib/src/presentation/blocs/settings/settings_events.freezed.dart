// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SettingsEventTearOff {
  const _$SettingsEventTearOff();

  LanguageChange languageChange(String languageSelected) {
    return LanguageChange(
      languageSelected,
    );
  }

  LogOut logOut() {
    return const LogOut();
  }

  EnableCollaboration enableCollaboration() {
    return const EnableCollaboration();
  }
}

/// @nodoc
const $SettingsEvent = _$SettingsEventTearOff();

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String languageSelected) languageChange,
    required TResult Function() logOut,
    required TResult Function() enableCollaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LanguageChange value) languageChange,
    required TResult Function(LogOut value) logOut,
    required TResult Function(EnableCollaboration value) enableCollaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
          SettingsEvent value, $Res Function(SettingsEvent) then) =
      _$SettingsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  final SettingsEvent _value;
  // ignore: unused_field
  final $Res Function(SettingsEvent) _then;
}

/// @nodoc
abstract class $LanguageChangeCopyWith<$Res> {
  factory $LanguageChangeCopyWith(
          LanguageChange value, $Res Function(LanguageChange) then) =
      _$LanguageChangeCopyWithImpl<$Res>;
  $Res call({String languageSelected});
}

/// @nodoc
class _$LanguageChangeCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res>
    implements $LanguageChangeCopyWith<$Res> {
  _$LanguageChangeCopyWithImpl(
      LanguageChange _value, $Res Function(LanguageChange) _then)
      : super(_value, (v) => _then(v as LanguageChange));

  @override
  LanguageChange get _value => super._value as LanguageChange;

  @override
  $Res call({
    Object? languageSelected = freezed,
  }) {
    return _then(LanguageChange(
      languageSelected == freezed
          ? _value.languageSelected
          : languageSelected // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LanguageChange implements LanguageChange {
  const _$LanguageChange(this.languageSelected);

  @override
  final String languageSelected;

  @override
  String toString() {
    return 'SettingsEvent.languageChange(languageSelected: $languageSelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LanguageChange &&
            const DeepCollectionEquality()
                .equals(other.languageSelected, languageSelected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(languageSelected));

  @JsonKey(ignore: true)
  @override
  $LanguageChangeCopyWith<LanguageChange> get copyWith =>
      _$LanguageChangeCopyWithImpl<LanguageChange>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String languageSelected) languageChange,
    required TResult Function() logOut,
    required TResult Function() enableCollaboration,
  }) {
    return languageChange(languageSelected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
  }) {
    return languageChange?.call(languageSelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
    required TResult orElse(),
  }) {
    if (languageChange != null) {
      return languageChange(languageSelected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LanguageChange value) languageChange,
    required TResult Function(LogOut value) logOut,
    required TResult Function(EnableCollaboration value) enableCollaboration,
  }) {
    return languageChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
  }) {
    return languageChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
    required TResult orElse(),
  }) {
    if (languageChange != null) {
      return languageChange(this);
    }
    return orElse();
  }
}

abstract class LanguageChange implements SettingsEvent {
  const factory LanguageChange(String languageSelected) = _$LanguageChange;

  String get languageSelected;
  @JsonKey(ignore: true)
  $LanguageChangeCopyWith<LanguageChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogOutCopyWith<$Res> {
  factory $LogOutCopyWith(LogOut value, $Res Function(LogOut) then) =
      _$LogOutCopyWithImpl<$Res>;
}

/// @nodoc
class _$LogOutCopyWithImpl<$Res> extends _$SettingsEventCopyWithImpl<$Res>
    implements $LogOutCopyWith<$Res> {
  _$LogOutCopyWithImpl(LogOut _value, $Res Function(LogOut) _then)
      : super(_value, (v) => _then(v as LogOut));

  @override
  LogOut get _value => super._value as LogOut;
}

/// @nodoc

class _$LogOut implements LogOut {
  const _$LogOut();

  @override
  String toString() {
    return 'SettingsEvent.logOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LogOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String languageSelected) languageChange,
    required TResult Function() logOut,
    required TResult Function() enableCollaboration,
  }) {
    return logOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
  }) {
    return logOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LanguageChange value) languageChange,
    required TResult Function(LogOut value) logOut,
    required TResult Function(EnableCollaboration value) enableCollaboration,
  }) {
    return logOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
  }) {
    return logOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut(this);
    }
    return orElse();
  }
}

abstract class LogOut implements SettingsEvent {
  const factory LogOut() = _$LogOut;
}

/// @nodoc
abstract class $EnableCollaborationCopyWith<$Res> {
  factory $EnableCollaborationCopyWith(
          EnableCollaboration value, $Res Function(EnableCollaboration) then) =
      _$EnableCollaborationCopyWithImpl<$Res>;
}

/// @nodoc
class _$EnableCollaborationCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res>
    implements $EnableCollaborationCopyWith<$Res> {
  _$EnableCollaborationCopyWithImpl(
      EnableCollaboration _value, $Res Function(EnableCollaboration) _then)
      : super(_value, (v) => _then(v as EnableCollaboration));

  @override
  EnableCollaboration get _value => super._value as EnableCollaboration;
}

/// @nodoc

class _$EnableCollaboration implements EnableCollaboration {
  const _$EnableCollaboration();

  @override
  String toString() {
    return 'SettingsEvent.enableCollaboration()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnableCollaboration);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String languageSelected) languageChange,
    required TResult Function() logOut,
    required TResult Function() enableCollaboration,
  }) {
    return enableCollaboration();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
  }) {
    return enableCollaboration?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String languageSelected)? languageChange,
    TResult Function()? logOut,
    TResult Function()? enableCollaboration,
    required TResult orElse(),
  }) {
    if (enableCollaboration != null) {
      return enableCollaboration();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LanguageChange value) languageChange,
    required TResult Function(LogOut value) logOut,
    required TResult Function(EnableCollaboration value) enableCollaboration,
  }) {
    return enableCollaboration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
  }) {
    return enableCollaboration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LanguageChange value)? languageChange,
    TResult Function(LogOut value)? logOut,
    TResult Function(EnableCollaboration value)? enableCollaboration,
    required TResult orElse(),
  }) {
    if (enableCollaboration != null) {
      return enableCollaboration(this);
    }
    return orElse();
  }
}

abstract class EnableCollaboration implements SettingsEvent {
  const factory EnableCollaboration() = _$EnableCollaboration;
}
