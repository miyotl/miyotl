import 'package:flutter/material.dart';
import 'onboarding.dart';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú del programador'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            child: Text('Abrir pantalla inicial'),
            onPressed: () {
              Navigator.of(context).pushNamed('/onboarding');
            },
          ),
          ElevatedButton(
            child: Text('Consultar disponibilidad de servicios de Google'),
            onPressed: () {
              Navigator.of(context).pushNamed('/debug/google');
            },
          ),
        ],
      ),
    );
  }
}
