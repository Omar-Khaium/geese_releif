import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/util/network_helper.dart';
import 'package:geesereleif/src/view/screen/screen_routes.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController(); //text: "administrator"
  TextEditingController _passwordController = TextEditingController(); //text: "@AadGjMpTw9!"
  bool _isObscure = true;
  bool _isRemembered = false;
  User user;
  Box<User> userBox;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userBox = Hive.box("users");
    user = userBox.length > 0 ? userBox.getAt(0) : User();
    _usernameController.text = user.isRemembered ?? false ? user.email ?? "" : "";
    _passwordController.text = user.isRemembered ?? false ? user.password ?? "" : "";
    _isRemembered = user.isRemembered ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context, listen: false);
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 0), () {
      routeProvider.clear();
      customerProvider.clear();
      historyProvider.clear();
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
                  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                  user.isRemembered = _isRemembered;
                  user.email = _usernameController.text;
                  user.password = _passwordController.text;
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDialog(context: context, builder: (context) => Loading(Colors.blue));
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
    try {
      Map<String, String> headers = {};
      Map<String, String> body = {
        "username": user.email,
        "password": user.password,
        "grant_type": "password",
      };

      Response response = await NetworkHelper.apiPOST(api: apiToken, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        user.isAuthenticated = true;
        user.token = "${result["token_type"]} ${result["access_token"]} ";
        Navigator.of(context).pop();
        showDialog(context: context, builder: (context) => Loading(Colors.green));
        getProfileData();
      } else if (response.statusCode == 500) {
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Username name is incorrect.");
      } else if (response.statusCode == 400) {
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Password name is incorrect.");
      } else {
        user.isAuthenticated = false;
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Something went wrong.");
      }
    } catch (error) {
      user.isAuthenticated = false;
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }

  getProfileData() async {
    try {
      Map<String, String> headers = {
        "authorization": user.token,
        "username": user.email,
      };

      Response response = await NetworkHelper.apiGET(api: apiUserInfo, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        user = User.fromJson(result, user);
        if (userBox.length == 0) {
          userBox.add(user);
        } else {
          userBox.putAt(0, user);
        }
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(RoutesScreen().routeName);
      } else {
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Can't fetch user's information.");
      }
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }
}
