import 'dart:ui';

import 'localization.dart';

class LocalizationEN implements Localization {
  @override
  String get googleSignInLabel => "Log in with Google";

  @override
  String get facebookSignInLabel => " Log in with Facebook";

  @override
  String get emailSignInLabel => "Login with Email";

  @override
  String get appBarLabel => "Social Flutter";
}
