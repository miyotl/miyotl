import 'package:flutter/material.dart';

extension ParseToString on ThemeMode {
  String string() {
    switch (this) {
      case ThemeMode.system:
        return 'Usar tema del dispositivo';
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Oscuro';
      default:
        return 'Desconocido';
    }
  }
}

class Settings extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.system;

  ThemeMode get theme => _theme;

  set theme(ThemeMode value) {
    _theme = value;
    notifyListeners();
  }
}
