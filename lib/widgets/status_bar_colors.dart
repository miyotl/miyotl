import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkStatusBar extends StatelessWidget {
  DarkStatusBar({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: child,
    );
  }
}

class LightStatusBar extends StatelessWidget {
  LightStatusBar({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: child,
    );
  }
}
