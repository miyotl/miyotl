import 'package:flutter/material.dart';
import 'package:lenguas/screens/conditional_onboarding.dart';
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
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        title: app_name,
        theme: new_light_theme,
        darkTheme: dark_theme,
        home: ConditionalOnboardingPage(),
        routes: {
          '/app': (context) => HomePage(),
          '/onboarding': (context) => OnboardingPage(),
          '/debug': (context) => DeveloperPage(),
          '/debug/google': (context) => GoogleApiAvailabilityPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
