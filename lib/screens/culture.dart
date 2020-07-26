import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class CultureCard extends StatelessWidget {
  final CultureEntry cultureEntry;

  CultureCard({this.cultureEntry});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
          children: <Widget>[
            
          ],
        ),
      elevation: 8,
    );
  }
}

class CulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) => GridView.count(
        primary: true,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: <Widget>[
          for (CultureEntry entry in state.culture) 
              CultureCard(cultureEntry: entry,)
        ],
      ),
    );
  }
}