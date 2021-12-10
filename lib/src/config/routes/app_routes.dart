import 'package:flutter/material.dart';

class AppRoutes {
  static const home = 'home';
  static const signUp = 'signUp';
  static const login = 'login';
  static const culture = 'culture';
  static const profile = 'profile';
  static const settingsPage = 'settings';
  static const dictionary = 'dictionary';
  static const language = 'language';

  Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _materialRoute(const Scaffold());
      case signUp:
        return _materialRoute(const Scaffold());

      case login:
        return _materialRoute(const Scaffold());

      case culture:
        return _materialRoute(const Scaffold());

      case profile:
        return _materialRoute(const Scaffold());

      case settingsPage:
        return _materialRoute(const Scaffold());

      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
