import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool isFinished= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
        elevation: 0,
        title: Text(
          "Privacy Policy".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
      ),
      body: Column(
        children: [
          Visibility(child: LinearProgressIndicator(),visible: !isFinished,),
          Expanded(
            child: WebView(
              initialUrl: 'https://www.geeserelief.com/about-us/privacy.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageStarted: (String url) {
                setState(() {
                  isFinished = false;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  isFinished = true;
                });
              },
              gestureNavigationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
