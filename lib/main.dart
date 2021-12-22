import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/config/routes/app_routes.dart';
import 'src/core/injection/injection.dart';
import 'src/presentation/blocs/signin/sign_in_bloc.dart';
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
              child: SocialSignInScreen(),
            )));
  }
}
