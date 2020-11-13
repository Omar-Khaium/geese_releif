import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/user.dart';
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
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());
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
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.00),
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
          CustomerDetailsScreen().routeName: (context) => CustomerDetailsScreen(),
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
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
    final routeProvider = Provider.of<RouteProvider>(context, listen: false);
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    keyboardProvider.init();
    keyboardProvider.hideKeyboard(context);

    Future.delayed(Duration.zero, () {
      redirect(context, routeProvider, customerProvider, historyProvider);
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

  redirect(
      BuildContext context, RouteProvider routeProvider, CustomerProvider customerProvider, HistoryProvider historyProvider) async {
    try {
      Box<User> userBox = await Hive.openBox("users");
      User user;
      if (userBox.length > 0) {
        user = userBox.getAt(0);
      } else {
        routeProvider.init();
        customerProvider.init();
        historyProvider.init();
      }
      Navigator.of(context).pushReplacementNamed(user == null
          ? LoginScreen().routeName
          : user.isAuthenticated ?? false
              ? RoutesScreen().routeName
              : LoginScreen().routeName);
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text(
                    "Notice",
                    style: getDeleteTextStyle(context),
                  ),
                  content: Text(
                    "Your app's local database's structure has changed to implementing a new feature.\nIt is mandatory to 're-install' the app by 'uninstalling' first.\nSorry for the inconvenience.${Platform.isAndroid ? "\n\nP.S. after clicking on 'UNINSTALL', follow step below as mentioned.\n1. find 'Geese Relief' under 'Apps & notifications'\n2. click on 'Storage'\n3. click on 'CLEAR DATA'\n5. uninstall and re-install 'Geese Relief'\n\n enjoy your day :D" : ""}",
                    style: getDefaultTextStyle(context, isFocused: true),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          AppSettings.openAppSettings();
                        } else {
                          exit(0);
                        }
                      },
                      child: Text(
                        "UNINSTALL",
                        style: getButtonTextStyle(context, isOutline: false),
                      ),
                      color: Colors.red,
                    )
                  ],
                ),
              ),
          barrierDismissible: false);
    }
  }
}
