// @dart=2.9

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miyotl/models/app_state.dart';

import '../models/culture.dart';
import 'culture_details.dart';

void openDoc(BuildContext context, String url, CultureEntry entry) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => GoogleDocPreview(
        url: url.replaceAll('edit', 'mobilebasic'),
        title: 'Cargando...',
        entry: entry,
      ),
    ),
  );
}

class GoogleDocPreview extends StatefulWidget {
  final String url;
  final String title;
  final CultureEntry entry;

  GoogleDocPreview({this.url, this.title, this.entry});

  @override
  _GoogleDocPreviewState createState() => _GoogleDocPreviewState();
}

class _GoogleDocPreviewState extends State<GoogleDocPreview> {
  InAppWebViewController webView;
  String url = '';
  double progress = 0;
  String title = '';
  dynamic jsResult;

  @override
  void initState() {
    title = widget.title;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// cleans up using CSS
  void cleanUp() {
    webView.injectCSSCode(
      source: '''
        #docs-ml-header-id {
          display: none;
        }
        .docs-ml-promotion {
          display: none;
        }
        .app-container {
          margin: 0 0 0 0;
        }
        ''',
    );
  }

  Widget getWebView(String url) {
    return Expanded(
      child: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
            //webView.clearCache();
          },
          onLoadStart: (controller, url) {
            setState(() {
              this.url = url.toString();
              //urlController.text = this.url;
            });
            cleanUp();
          },
          onLoadStop: (controller, url) async {
            setState(() {
              this.url = url.toString();
            });
            cleanUp();
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {
              this.progress = progress / 100;
            });
            cleanUp();
          },
          onTitleChanged: (controller, title) {
            setState(() {
              print(title);
              this.title = title;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    analytics.logViewItem(
      items: [
        AnalyticsEventItem(
          itemId: url,
          itemName: title,
          itemCategory: 'document',
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.fredokaOne(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CultureDetails(entry: widget.entry),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            getWebView(widget.url),
          ],
        ),
      ),
    );
  }
}
