// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miyotl/models/app_state.dart';
import 'package:provider/provider.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'debug/string_viewer.dart';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diagnósticos',
          style: GoogleFonts.fredokaOne(),
        ),
      ),
      body: ListView(
        children: [
          OutlinedButton(
            child: Text('Consultar disponibilidad de servicios de Google'),
            onPressed: () {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'google-availability'},
              );
              Navigator.of(context).pushNamed('/debug/google');
            },
          ),
          OutlinedButton(
            child: Text('Abrir pantalla inicial'),
            onPressed: () {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'open-onboarding'},
              );
              Navigator.of(context).pushNamed('/onboarding');
            },
          ),
          OutlinedButton(
            child: Text('Abrir pantalla inicial después del próximo reinicio'),
            onPressed: () {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'revert-onboarding'},
              );
              AppState state = Provider.of<AppState>(context, listen: false);
              state.setOnboardingStatus(false);
            },
          ),
          OutlinedButton(
            child: Text('Ver base de datos'),
            onPressed: () {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'view_data'},
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => JsonViewerPage(
                    title: 'Base de datos',
                    json: Provider.of<AppState>(context, listen: false).data,
                  ),
                ),
              );
            },
          ),
          OutlinedButton(
            child: Text('Ver archivo de base de datos'),
            onPressed: () {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'view_data_file'},
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AsyncStringViewerPage(
                    title: 'Base de datos (archivo)',
                    string: Provider.of<AppState>(context, listen: false)
                        .loadLanguageDataFromDisk(),
                  ),
                ),
              );
            },
          ),
          OutlinedButton(
            child: Text('Ver detalles de cuenta'),
            onPressed: () {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'view_account'},
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AsyncStringViewerPage(
                    title: 'Detalles de cuenta',
                    string: UserAccount.instance.getDebugAccountDetails(),
                  ),
                ),
              );
            },
          ),
          OutlinedButton(
            child: Text('Olvidarse de que la base de datos está actualizada'),
            onPressed: () async {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'forget_data'},
              );
              final prefs = await SharedPreferences.getInstance();
              prefs.setInt('last-update', 2001010101);
            },
          ),
          OutlinedButton(
            child: Text('Hacer un error falso'),
            onPressed: () async {
              analytics.logEvent(
                name: 'developer_option',
                parameters: {'option': 'test_exception'},
              );
              try {
                throw Exception('Test exception');
              } catch (exception, stackTrace) {
                // await Sentry.captureException(exception,
                //     stackTrace: stackTrace);
              }
            },
          ),
        ],
      ),
    );
  }
}
