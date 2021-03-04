import 'package:flutter/material.dart';

class StringViewerPage extends StatelessWidget {
  final String title;
  final String string;

  StringViewerPage({this.title, this.string});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: SingleChildScrollView(
        child: Text('$string'),
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
