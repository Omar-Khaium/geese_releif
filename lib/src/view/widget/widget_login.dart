import 'package:flutter/material.dart';
import 'package:geese_releif/src/view/screen/screen_routes.dart';
import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:geese_releif/src/view/util/helper.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isRemembered = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: textColor,
            style: getDefaultTextStyle(context),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: accentColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: accentColor, width: 2),
                ),
                hintText: "Username",
                hintStyle: getHintTextStyle(context),
                isDense: true),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            cursorColor: textColor,
            style: getDefaultTextStyle(context),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: accentColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: accentColor, width: 2),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              ),
              hintText: "Password",
              hintStyle: getHintTextStyle(context),
              isDense: true,
            ),
            obscureText: _isObscure,
          ),
        ),
        CheckboxListTile(
          dense: true,
          title: Text(
            "Remember Me",
            style: getClickableTextStyle(context),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: (flag) {
            setState(() {
              _isRemembered = flag;
            });
          },
          value: _isRemembered,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OutlineButton(
            borderSide: BorderSide(color: accentColor, width: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
            ),
            splashColor: Colors.blue,
            highlightColor: Colors.white,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "LOGIN",
                style: getButtonTextStyle(context),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(RoutesScreen().routeName);
              },
          ),
        ),
      ],
    );
  }
}
