import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/util/constraints.dart';

class ProfileScreen extends StatelessWidget {
  final String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(HistoryScreen().routeName),
            icon: Icon(FontAwesomeIcons.history),
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(LoginScreen().routeName),
            icon: Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * .34),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Image.network(
                  "https://uifaces.co/our-content/donated/8CEV1nXA.jpg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * .333,
                  height: MediaQuery.of(context).size.width * .333,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "John Doe",
            style: getAppBarTextStyle(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 2,
          ),
          ChoiceChip(
            label: Text(
              "Rising Star",
              style: getCaptionTextStyle(context),
            ),
            avatar: Icon(
              FontAwesomeIcons.trophy,
              size: 12,
            ),
            selected: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "125",
                    style: getClickableTextStyle(context, forMenu: true),
                  ),
                  Text(
                    "Check In",
                    style: getCaptionTextStyle(context),
                  ),
                ],
              ),
              Container(
                child: VerticalDivider(
                  color: hintColor,
                ),
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "1,024",
                    style: getClickableTextStyle(context, forMenu: true),
                  ),
                  Text(
                    "Geese",
                    style: getCaptionTextStyle(context),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 48,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(32),
                        topRight: const Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          spreadRadius: 4)
                    ],
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 9),
                  children: [
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.phoneAlt,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        "(555) 010 9990",
                        style: getDefaultTextStyle(context),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.at,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        "john.doe@mail.com",
                        style: getDefaultTextStyle(context),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        "22/B Old Baker Street",
                        style: getDefaultTextStyle(context),
                      ),
                      subtitle: Text(
                        "South London, SC 21015",
                        style: getDefaultTextStyle(context),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.mapPin,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        "29 Sep, 2019 8:05 AM",
                        style: getDefaultTextStyle(context),
                      ),
                      subtitle: Text(
                        "Last Checked In",
                        style: getCaptionTextStyle(context),
                      ),
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.solidCalendarAlt,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        "01 Jan, 2014",
                        style: getDefaultTextStyle(context),
                      ),
                      subtitle: Text(
                        "Employed Since",
                        style: getCaptionTextStyle(context),
                      ),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
