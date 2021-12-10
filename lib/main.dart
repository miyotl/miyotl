import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenguas/src/core/utils/constants.dart';
import 'package:lenguas/src/presentation/views/conditional_onboarding.dart';
import 'package:lenguas/src/presentation/views/debug/google_service_check.dart';
import 'package:lenguas/src/presentation/views/developer_menu.dart';
import 'package:lenguas/src/presentation/views/models/app_state.dart';
import 'package:lenguas/src/presentation/views/settings.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'src/presentation/views/home.dart';
import 'src/presentation/views/onboarding.dart';

Future<void> main() async {
  /// Add license entry for Google fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

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
        //ChangeNotifierProvider<Settings>(create: (context) => Settings()),
        ChangeNotifierProvider<UserAccount>(create: (context) => UserAccount()),
      ],
      child: ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: Consumer<Settings>(
          builder: (context, settings, child) => MaterialApp(
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            title: app_name,
            theme: new_light_theme.copyWith(
              platform: TargetPlatform.android
                  // TODO make settings
              // settings.useIOSStyle
              //     ? TargetPlatform.iOS
              //     : TargetPlatform.android,
            ),
            darkTheme: dark_theme.copyWith(
              platform: TargetPlatform.android
              // settings.useIOSStyle
              //    ? TargetPlatform.iOS
                //  : TargetPlatform.android,
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
            //themeMode: settings.theme,
          ),
          child: ConditionalOnboardingPage(),
        ),
      ),
    );
  }
}
