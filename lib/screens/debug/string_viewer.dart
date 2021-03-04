import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class StringViewerPage extends StatelessWidget {
  final String title;
  final String string;

  StringViewerPage({this.title, this.string});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title', style: GoogleFonts.fredokaOne()),
      ),
      body: SingleChildScrollView(
        child: Text('$string'),
      ),
    );
  }
}

class JsonViewerPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> json;

  JsonViewerPage({this.title, this.json});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title', style: GoogleFonts.fredokaOne()),
      ),
      body: SingleChildScrollView(
        child: JsonViewerWidget(json),
      ),
    );
  }
}

class AsyncStringViewerPage extends StatelessWidget {
  final String title;
  final Future<String> string;

  AsyncStringViewerPage({this.title, this.string});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: string,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return StringViewerPage(
            title: 'Error: $title',
            string: '${snapshot.error}',
          );
        } else if (snapshot.hasData) {
          return StringViewerPage(
            title: title,
            string: '${snapshot.data}',
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class AsyncJsonViewerPage extends StatelessWidget {
  final String title;
  final Future<Map<String, dynamic>> json;

  AsyncJsonViewerPage({this.title, this.json});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: json,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return StringViewerPage(
            title: 'Error: $title',
            string: '${snapshot.error}',
          );
        } else if (snapshot.hasData) {
          return JsonViewerPage(
            title: title,
            json: snapshot.data,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
