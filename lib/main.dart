import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lenguas/src/presentation/pages/home_page.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/core/injection/injection.dart';
import 'src/presentation/blocs/home_bloc.dart';
import 'src/presentation/pages/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);

  /// Run the app, sending exceptions and errors to Sentry
  SentryFlutter.init(
    (options) {
      options.dsn =
          'https://10b347756b75470d9de103b5fc93392b@o542451.ingest.sentry.io/5662242';
    },
    appRunner: () => runApp(MiyotlApp()),
  );
}

class MiyotlApp extends StatelessWidget {
  const MiyotlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeBloc>(
        create: (_) => getIt(),
        child: SocialSignInScreen(),
      ),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('en', '')],
    );
  }
}
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AppState>(create: (context) => AppState()),
//         //ChangeNotifierProvider<Settings>(create: (context) => Settings()),
//         ChangeNotifierProvider<UserAccount>(create: (context) => UserAccount()),
//       ],
//       child: ChangeNotifierProvider<AppState>(
//         create: (context) => AppState(),
//         child: Consumer<Settings>(
//           builder: (context, settings, child) => MaterialApp(
//             navigatorObservers: [
//               FirebaseAnalyticsObserver(analytics: analytics),
//             ],
//             title: app_name,
//             theme: new_light_theme.copyWith(
//               platform: TargetPlatform.android
//                   // TODO make settings
//               // settings.useIOSStyle
//               //     ? TargetPlatform.iOS
//               //     : TargetPlatform.android,
//             ),
//             darkTheme: dark_theme.copyWith(
//               platform: TargetPlatform.android
//               // settings.useIOSStyle
//               //    ? TargetPlatform.iOS
//                 //  : TargetPlatform.android,
//             ),
//             home: child,
//             routes: {
//               '/app': (context) => HomePage(),
//               '/settings': (context) => SettingsPage(),
//               '/onboarding': (context) => OnboardingPage(),
//               '/debug': (context) => DeveloperPage(),
//               '/debug/google': (context) => GoogleApiAvailabilityPage(),
//             },
//             debugShowCheckedModeBanner: false,
//             //themeMode: settings.theme,
//           ),
//           child: ConditionalOnboardingPage(),
//         ),
//       ),
//     );
//   }
// }
