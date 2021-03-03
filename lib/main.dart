import 'package:flutter/material.dart';
import 'package:lenguas/screens/conditional_onboarding.dart';
import 'package:lenguas/screens/settings.dart';
import 'models/settings.dart';
import 'screens/home.dart';
import 'screens/onboarding.dart';
import 'screens/developer_menu.dart';
import 'screens/debug/google_service_check.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'models/constants.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
      ],
      child: ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: Consumer<Settings>(
          builder: (context, settings, child) => MaterialApp(
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
