part of '../signin/sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent({required String provider}) = _SignInEvent;
}
