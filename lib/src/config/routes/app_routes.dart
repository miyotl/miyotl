import 'package:flutter/material.dart';
import 'package:lenguas/src/presentation/pages/home_page.dart';
import 'package:lenguas/src/presentation/pages/sign_in.dart';

class AppRoutes {
  String className = "";
  static const home = 'home';
  static const signUp = 'signUp';
  static const login = 'login';
  static const culture = 'culture';
  static const profile = 'profile';
  static const settingsPage = 'settings';
  static const dictionary = 'dictionary';
  static const language = 'language';

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(SocialSignInScreen());
      case home:
        return _materialRoute(HomePage());
      case signUp:
        return _materialRoute(const Scaffold());
      case login:
        return _materialRoute(SocialSignInScreen());

      case culture:
        return _materialRoute(const Scaffold());

      case profile:
        return _materialRoute(const Scaffold());

      case settingsPage:
        return _materialRoute(const Scaffold());

      default:
        return _materialRoute(const Scaffold()); // home or something
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
