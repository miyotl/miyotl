import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  
  EmptyState(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}