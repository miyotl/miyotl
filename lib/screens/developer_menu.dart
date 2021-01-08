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
          RaisedButton(
            child: Text('Abrir pantalla inicial'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OnboardingPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
