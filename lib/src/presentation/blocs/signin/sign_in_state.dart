part of '../signin/sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.loginResult({
    @Default(false) bool userLoggedIn,
    UserAuthModel? userData
  }) = _SignInState;
}
