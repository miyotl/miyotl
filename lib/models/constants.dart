import 'package:flutter/material.dart';

const String dictionary_url =
    'https://drive.google.com/uc?export=download&id=1A2_SIrvbM8P9vwHfju7ZYiN3twO9OTp4';
const String app_name = 'Miyotl';

class AppColors {
  // From dark illustration
  static Color darkBlue = Color(0xFF05001E);
  static Color pink = Color(0xFFEC1C58);
  static Color lightPurple = Color(0xFFCB9FC3);
  static Color teal = Color(0xFF85CDC1);

  // From light illustration
  static Color lightBrown = Color(0xFF7C6764);
  static Color darkBrown = Color(0xFF4C3F46);
  static Color lightBlue = Color(0xFFACD2DB);
  static Color lightPink = Color(0xFFFF7A92);
  static Color yellow = Color(0xFFECC730);
}

/// TODO: constant
ThemeData dark_theme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  accentColor: AppColors.pink,
  primaryColor: AppColors.teal,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColors.darkBlue,
    ),
  ),
  scaffoldBackgroundColor: AppColors.darkBlue,
  canvasColor: AppColors.darkBlue,
);
ThemeData light_theme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.teal,
  primaryColor: AppColors.lightBlue,
  accentColor: AppColors.lightPink,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: AppColors.pink,
  ),
  selectedRowColor: AppColors.lightPink,
  textSelectionColor: AppColors.lightPink,
);
