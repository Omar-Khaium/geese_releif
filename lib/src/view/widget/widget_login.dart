import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/view/screen/screen_routes.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/network_helper.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController(text: "eashan.piistech@gmail.com");
  TextEditingController _passwordController = TextEditingController(text: "123456");
  bool _isObscure = true;
  bool _isRemembered = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 0), (){
      routeProvider.clear();
    });
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              validator: (val) => val.isEmpty ? "Required" : null,
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
            child: TextFormField(
              validator: (val) => val.isEmpty ? "Required" : null,
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
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
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
                  borderRadius: BorderRadius.circular(0)),
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
                if (_formKey.currentState.validate()) {
                  showDialog(context: context, builder: (context) => Loading());
                  login();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  login() async {
    try{
    String username = _usernameController.text;
    String password = _passwordController.text;

    Map<String, String> headers = {};

    Map<String, String> body = {
      "username": username,
      "password": password,
      "grant_type": "password",
    };

    Response response = await NetworkHelper.apiPOST(
        api: apiToken, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      user.email = username;
      user.password = password;
      user.token = "${result["token_type"]} ${result["access_token"]} ";

      getProfileData();
    } else {
      Navigator.of(context).pop();
    }
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
    }
  }

  getProfileData() async {
    try {
      Map<String, String> headers = {
        "authorization": user.token,
        "username": user.email,
      };

      Response response =
          await NetworkHelper.apiGET(api: apiUserInfo, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        user = User.fromJson(result, user);

        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(RoutesScreen().routeName);
      } else {
        Navigator.of(context).pop();
      }
    } catch (error) {
      Navigator.of(context).pop();
    }
  }
}
