import 'package:flutter/material.dart';
import 'package:lenguas/widgets/empty_state.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'img/axolotl-gears.gif',
            width: MediaQuery.of(context).size.width * 0.80,
          ),
          Text(
            'La función para aprender el idioma se agregará en una actualización futura',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
