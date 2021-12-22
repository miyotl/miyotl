import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/config/routes/app_routes.dart';
import 'src/core/injection/injection.dart';
import 'src/presentation/blocs/signin/sign_in_bloc.dart';
import 'src/presentation/pages/home_page.dart';
import 'src/presentation/pages/sign_in.dart';
import 'src/presentation/utils/constants/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  var _prefs = await SharedPreferences.getInstance();
  var _isLoggedIn = _prefs.getBool(AppConstants.isUserLoggedInKey) ?? false;

  /// Run the app, sending exceptions and errors to Sentry
  SentryFlutter.init(
    (options) {
      options.dsn =
          'https://10b347756b75470d9de103b5fc93392b@o542451.ingest.sentry.io/5662242';
    },
    appRunner: () => runApp(MiyotlApp(isLoggedIn: _isLoggedIn)),
  );
}

class MiyotlApp extends StatelessWidget {
  const MiyotlApp({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            home: MultiBlocProvider(
              providers: [BlocProvider<SignInBloc>(create: (_) => getIt())],
              child: isLoggedIn ? HomePage() : SocialSignInScreen(),
            )));
  }
}
