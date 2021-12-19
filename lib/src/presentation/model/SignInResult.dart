import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/res_google_signin_model.dart';
part 'SignInResult.freezed.dart';

@freezed
class SignInResult with _$SignInResult {
  const factory SignInResult(
      {@Default(false) bool success,
      UserAuthModel? data,
      Exception? error}) = _SignInResult;
}
