import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/models/app_state.dart';
import 'package:provider/provider.dart';

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
          ElevatedButton(
            child: Text('Consultar disponibilidad de servicios de Google'),
            onPressed: () {
              Navigator.of(context).pushNamed('/debug/google');
            },
          ),
          ElevatedButton(
            child: Text('Abrir pantalla inicial'),
            onPressed: () {
              Navigator.of(context).pushNamed('/onboarding');
            },
          ),
          ElevatedButton(
            child: Text('Abrir pantalla inicial después del próximo reinicio'),
            onPressed: () {
              AppState state = Provider.of<AppState>(context, listen: false);
              state.setOnboardingStatus(false);
            },
          ),
        ],
      ),
    );
  }
}
