import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GoogleDocPreview extends StatefulWidget {
  final String url;
  final String title;

  GoogleDocPreview({this.url, this.title});

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
    /*webView.evaluateJavascript(
      source: '''
        document.getElementById("docs-ml-header-id").remove();
        document.getElementsByClassName("doc")[0].style.paddingTop = 0;
        document.getElementsByClassName("app-container")[0].style.marginTop = 0;
        document.getElementsByClassName("docs-ml-promotion")[0].remove();
        ''',
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: InAppWebView(
                    initialUrl: widget.url,
                    initialHeaders: {},
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                      //webView.clearCache();
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                      cleanUp();
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });
                      cleanUp();
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
