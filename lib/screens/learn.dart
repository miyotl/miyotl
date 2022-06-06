// @dart=2.9

import 'package:flutter/material.dart';
import 'package:miyotl/widgets/empty_state.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return EmptyState(
      'La función para aprender el idioma se agregará en una actualización futura',
      'img/axolotl-gears.gif',
    );
  }
}
