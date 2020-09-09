import 'package:flutter/material.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/provider/provider_keyboard.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/view/screen/screen_customer_details.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/screen/screen_onboard.dart';
import 'package:geesereleif/src/view/screen/screen_photo_preview.dart';
import 'package:geesereleif/src/view/screen/screen_routes.dart';
import 'package:geesereleif/src/view/screen/screen_upload_file.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => KeyboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RouteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          LoginScreen().routeName: (context) => LoginScreen(),
          OnBoardingScreen().routeName: (context) => OnBoardingScreen(),
          RoutesScreen().routeName: (context) => RoutesScreen(),
          CustomersScreen().routeName: (context) => CustomersScreen(),
          CustomerDetailsScreen().routeName: (context) =>
              CustomerDetailsScreen(),
          UploadFileScreen().routeName: (context) => UploadFileScreen(),
          ViewPhotoScreen().routeName: (context) => ViewPhotoScreen(),
          HistoryScreen().routeName: (context) => HistoryScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final keyboardProvider =
        Provider.of<KeyboardProvider>(context, listen: false);
    keyboardProvider.init();
    keyboardProvider.hideKeyboard(context);

    Future.delayed(Duration(milliseconds: 0), () {
      redirect(context);
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Image.asset(
          "images/logo.png",
          width: 144,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  redirect(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(LoginScreen().routeName);
  }
}
