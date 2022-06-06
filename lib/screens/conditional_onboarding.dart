// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miyotl/models/app_state.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'onboarding.dart';
import '../widgets/empty_state.dart';
import 'loading.dart';

class ConditionalOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        return FutureBuilder(
          future: state.hasFinishedOnboarding,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bool hasFinishedOnboarding = snapshot.data;
              if (hasFinishedOnboarding) {
                return HomePage();
              } else {
                return OnboardingPage();
              }
            } else if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Ocurrió un error',
                    style: GoogleFonts.fredokaOne(),
                  ),
                ),
                body: EmptyState(
                    'Intenta liberar espacio en tu dispositivo. Si el error persiste, manda correo a miyotl@googlegroups.com. El error es ${snapshot.error}'),
              );
            } else {
              return LoadingPage();
            }
          },
        );
      },
    );
  }
}
