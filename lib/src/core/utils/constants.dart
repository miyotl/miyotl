import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

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
// TextSelectionThemeData.selectionColor: AppColors.rosa,
// );
