import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int toInt() {
    int i = 0;
    for (ThemeMode value in ThemeMode.values) {
      if (value == this) {
        return i;
      }
      i++;
    }
    return 0;
  }
}

ThemeMode themeModeFromInt(int x) {
  return ThemeMode.values[x];
}

class Settings extends ChangeNotifier {
  Settings() {
    SharedPreferences.getInstance().then((prefs) {
      _theme = themeModeFromInt(prefs.getInt('theme'));
      notifyListeners();
    });
  }

  ThemeMode _theme = ThemeMode.system;

  ThemeMode get theme => _theme;

  set theme(ThemeMode value) {
    _theme = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('theme', value.toInt());
    });
  }
}
