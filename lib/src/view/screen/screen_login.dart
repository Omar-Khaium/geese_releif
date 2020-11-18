import 'package:flutter/material.dart';
import 'package:geesereleif/src/provider/provider_keyboard.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/widget/widget_login.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  final String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: keyboardProvider.isKeyboardHidden,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Image.asset(
                        "images/logo.png",
                        width: 144,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 24, left: 24),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration:
                        BoxDecoration(color: backgroundColor, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.grey.shade200,
                          spreadRadius: 3,
                          blurRadius: 3)
                    ]),
                    child: LoginForm(),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !keyboardProvider.isKeyboardVisible,
            child: Expanded(
              flex: 1,
              child: Center(
                child: InkWell(
                  onTap: () {
                    keyboardProvider.hideKeyboard(context);
                    launch("https://www.geeserelief.com/about-us/privacy.html",
                        forceSafariVC: true);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      "Privacy Policy",
                      style: getClickableTextStyle(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: keyboardProvider.isKeyboardVisible,
            child: Expanded(
              flex: 1,
              child: Center(
                child: InkWell(
                  onTap: () {
                    keyboardProvider.hideKeyboard(context);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      "Hide Keyboard",
                      style: getClickableTextStyle(context).copyWith(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
