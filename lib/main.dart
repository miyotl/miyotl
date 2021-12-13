import 'package:flutter/material.dart';
import 'package:lenguas/src/config/routes/app_routes.dart';
import 'package:lenguas/src/config/themes/app_theme.dart';
import 'package:lenguas/src/core/utils/constants.dart';
import 'package:lenguas/src/injector.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_name,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      theme: AppTheme.light,
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
