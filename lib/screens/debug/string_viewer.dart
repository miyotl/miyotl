import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'package:google_fonts/google_fonts.dart';

class StringViewerPage extends StatelessWidget {
  final String title;
  final String string;

  const StringViewerPage({super.key, required this.title, required this.string});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(
                      fontFamily: 'FredokaOne'
                    )
        ),
      ),
      body: SingleChildScrollView(
        child: Text(string),
      ),
    );
  }
}

class JsonViewerPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> json;

  const JsonViewerPage({super.key, required this.title, required this.json});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(
                      fontFamily: 'FredokaOne'
                    )
        ),
      ),
      body: SingleChildScrollView(
        child: JsonViewer(json),
      ),
    );
  }
}

class AsyncStringViewerPage extends StatelessWidget {
  final String title;
  final Future<String> string;

  const AsyncStringViewerPage({super.key, required this.title, required this.string});

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
          return const Scaffold(
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

  const AsyncJsonViewerPage({super.key, required this.title, required this.json});

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
            json: snapshot.data!,
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
