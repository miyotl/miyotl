import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
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

  /// Nuevos colores
  /* #732484 (morado)
#ecfcac (amarillo)
#34347c (azul-morado)
#cc3c74 (rosa)
#146484 (azul-verdoso)
#occ3fb (azul claro) */
  static Color morado = const Color(0xFF732484);
  static Color amarillo = const Color(0xFFECFCAC);
  static Color amarilloAjolote = const Color(0xFFFCFFAC);
  static Color azulMorado = const Color(0xFF34347C);
  static Color rosa = const Color(0xFFCC3C74);
  static Color azulVerdoso = const Color(0xFF146484);
  static Color azulClaro = const Color(0xff0cc3fb);
  static Color azulCard = const Color(0x37334B);
  //static Color verdePrueba = Color(0xff3BCD95);

  ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: rosa,
      secondaryHeaderColor: azulMorado,
      splashColor: Colors.transparent,
      fontFamily: 'FredokaOne',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: azulMorado,
      backgroundColor: amarillo,
    ),
    );
  }

  // /// TODO: constant
  // ThemeData dark_theme = ThemeData(
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //   brightness: Brightness.dark,
  //   accentColor: azulClaro,
  //   primaryColor: lightPink,
  //   primarySwatch: Colors.pink,

  //   /// TODO: poner uno ms claro
  //   appBarTheme: AppBarTheme(
  //     iconTheme: IconThemeData(
  //       color: darkBlue,
  //     ),
  //   ),
  //   scaffoldBackgroundColor: darkBlue,
  //   canvasColor: darkBlue,
  //   cardColor: azulCard,
  // );

  // ThemeData new_light_theme = ThemeData(
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //   primarySwatch: Colors.indigo,
  //   primaryColor: rosa,
  //   secondaryHeaderColor: azulMorado,
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     selectedItemColor: azulMorado,
  //     // backgroundColor: amarillo,
  //   ),

  //   /// Workaround https://github.com/flutter/flutter/issues/72562 by manually specifying the brightness
  //   appBarTheme: const AppBarTheme(
  //     systemOverlayStyle: SystemUiOverlayStyle.light,
  //   ),
  //   selectedRowColor: rosa,
  //   textSelectionColor: rosa,
  // );
}
