// @dart=2.9

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miyotl/screens/conditional_onboarding.dart';
import 'package:miyotl/screens/settings.dart';
import 'models/settings.dart';
import 'screens/home.dart';
import 'screens/onboarding.dart';
import 'screens/developer_menu.dart';
import 'screens/debug/google_service_check.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'models/constants.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  /// Add license entry for Google fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  /// Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Run the app, sending exceptions and errors to Sentry
  SentryFlutter.init(
    (options) {
      options.dsn =
          'https://10b347756b75470d9de103b5fc93392b@o542451.ingest.sentry.io/5662242';
    },
    appRunner: () => runApp(App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
        ChangeNotifierProvider<UserAccount>(create: (context) => UserAccount()),
      ],
      child: ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: Consumer<Settings>(
          builder: (context, settings, child) => MaterialApp(
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
              SentryNavigatorObserver()
            ],
            title: app_name,
            theme: new_light_theme.copyWith(
              platform: settings.useIOSStyle
                  ? TargetPlatform.iOS
                  : TargetPlatform.android,
            ),
            darkTheme: dark_theme.copyWith(
              platform: settings.useIOSStyle
                  ? TargetPlatform.iOS
                  : TargetPlatform.android,
            ),
            home: child,
            routes: {
              '/app': (context) => HomePage(),
              '/settings': (context) => SettingsPage(),
              '/onboarding': (context) => OnboardingPage(),
              '/debug': (context) => DeveloperPage(),
              '/debug/google': (context) => GoogleApiAvailabilityPage(),
            },
            debugShowCheckedModeBanner: false,
            themeMode: settings.theme,
          ),
          child: ConditionalOnboardingPage(),
        ),
      ),
    );
  }
}
