import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyState extends StatelessWidget {
  final String text;
  final String image;

  EmptyState(this.text, this.image);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'FredokaOne'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
