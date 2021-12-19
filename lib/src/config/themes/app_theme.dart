import 'package:flutter/material.dart';

class AppTheme {
  var appversion = 23;

  // Sign in
  static const Color purpleColor = Color(0xff3A559F);
  static const Color whiteColor = Color(0Xffffffff);

  // From dark illustration
  static Color darkBlue = const Color(0xFF05001E);
  static Color pink = const Color(0xFFEC1C58);
  static Color lightPurple = const Color(0xFFCB9FC3);
  static Color teal = const Color(0xFF85CDC1);

  // From light illustration
  static Color lightBrown = const Color(0xFF7C6764);
  static Color darkBrown = const Color(0xFF4C3F46);
  static Color lightBlue = const Color(0xFFACD2DB);
  static Color lightPink = const Color(0xFFFF7A92);
  static Color yellow = const Color(0xFFECC730);
  static Color morado = const Color(0xFF732484);
  static Color amarillo = const Color(0xFFECFCAC);
  static Color amarilloAjolote = const Color(0xFFFCFFAC);
  static Color azulMorado = const Color(0xFF34347C);
  static Color rosa = const Color(0xFFCC3C74);
  static Color azulVerdoso = const Color(0xFF146484);
  static Color azulClaro = const Color(0xff0cc3fb);
  static Color azulCard = const Color(0x37334B);

  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(color: darkBlue)),
      scaffoldBackgroundColor: darkBlue,
      primaryColor: rosa,
      secondaryHeaderColor: azulMorado,
      canvasColor: darkBlue,
      splashColor: Colors.transparent,
      cardColor: azulCard,
      fontFamily: 'FredokaOne',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: azulMorado,
        backgroundColor: amarillo,
      ),
    );
  }
}
