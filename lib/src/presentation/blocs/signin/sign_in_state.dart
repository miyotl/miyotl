part of '../signin/sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(true) bool userLoggedIn,
  }) = _SignInState;

}
