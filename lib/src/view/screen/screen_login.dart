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
                    child: Image.asset(
                      "images/logo.png",
                      width: 144,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: 320,
                    height: 320,
                    margin: const EdgeInsets.only(top: 36),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration:
                        BoxDecoration(color: backgroundColor, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.black12,
                          spreadRadius: 12,
                          blurRadius: 12)
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
          )
        ],
      ),
    );
  }
}
