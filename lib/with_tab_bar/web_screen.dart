import 'package:flutter/material.dart';
import 'package:quotex/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../quotex_colors.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            _controller?.goBack();
          },
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          WebView(
            initialUrl: userDefault!.getString('link'),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              setState(() {
                _controller = webViewController;
              });
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
                child: CircularProgressIndicator(
                    color: const Color(QuotexColors.quotexBackgroundCode)))
        ],
      )),
    );
  }
}
