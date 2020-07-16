import 'package:flutter/material.dart';
import 'package:geese_releif/src/provider/provider_keyboard.dart';
import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:geese_releif/src/view/util/helper.dart';
import 'package:geese_releif/src/view/widget/widget_login.dart';
import 'package:geese_releif/src/view/widget/widget_terms_and_conditions.dart';
import 'package:provider/provider.dart';

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
                  Image.asset("images/logo.png", width: 144, fit: BoxFit.contain,),
                  Container(
                    width: 320,
                    height: 320,
                    margin: const EdgeInsets.only(top: 36),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(color: backgroundColor, boxShadow: [
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TermsAndConditions(),
                        fullscreenDialog: true));
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
