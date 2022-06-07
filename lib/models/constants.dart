// @dart=2.9

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

//FirebaseAnalytics analytics = FirebaseAnalytics();

const String dictionary_url = 'https://proyecto-miyotl.web.app/data.json';
const String last_update_url = 'https://proyecto-miyotl.web.app/upd.txt';
// TODO remove later
const String facebook_huawei_form_url =
    'https://docs.google.com/forms/u/0/d/e/1FAIpQLSfMtw1iqjFWUrec0NCmRrYOT0W_f7A3hpJIw4p3GTi04FpRWA/formResponse';
const String app_name = 'Miyotl';
const meses = <String>[
  'ene',
  'feb',
  'mar',
  'abr',
  'may',
  'jun',
  'jul',
  'ago',
  'sep',
  'oct',
  'nov',
  'dic'
];

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

  /// Nuevos colores
  /* #732484 (morado)
#ecfcac (amarillo)
#34347c (azul-morado)
#cc3c74 (rosa)
#146484 (azul-verdoso)
#occ3fb (azul claro) */
  static Color morado = Color(0xFF732484);
  static Color amarillo = Color(0xFFECFCAC);
  static Color amarilloAjolote = Color(0xFFFCFFAC);
  static Color azulMorado = Color(0xFF34347C);
  static Color rosa = Color(0xFFCC3C74);
  static Color azulVerdoso = Color(0xFF146484);
  static Color azulClaro = Color(0xff0cc3fb);
  static Color azulCard = Color(0x37334B);
//static Color verdePrueba = Color(0xff3BCD95);
}

/// TODO: constant
ThemeData dark_theme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  accentColor: AppColors.azulClaro,
  primaryColor: AppColors.lightPink,
  primarySwatch: Colors.pink,

  /// TODO: poner uno ms claro
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColors.darkBlue,
    ),
    titleTextStyle: TextStyle(
      color: AppColors.darkBlue,

      /// TODO: figure out what's going on -- if size is not specified text becomes smaller
      fontSize: 18,
    ),
    backgroundColor: AppColors.lightPink,
  ),
  scaffoldBackgroundColor: AppColors.darkBlue,
  canvasColor: AppColors.darkBlue,
  cardColor: AppColors.azulCard,
);

ThemeData new_light_theme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.pink,
  primaryColor: AppColors.rosa,
  accentColor: AppColors.azulMorado,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: AppColors.azulMorado,
    // backgroundColor: AppColors.amarillo,
  ),
  selectedRowColor: AppColors.rosa,
);
// ThemeData light_theme = ThemeData(
//   visualDensity: VisualDensity.adaptivePlatformDensity,
//   primarySwatch: Colors.teal,
//   primaryColor: AppColors.lightBlue,
//   accentColor: AppColors.lightPink,
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     selectedItemColor: AppColors.pink,
//   ),
//   selectedRowColor: AppColors.lightPink,
//   textSelectionColor: AppColors.lightPink,
// );
