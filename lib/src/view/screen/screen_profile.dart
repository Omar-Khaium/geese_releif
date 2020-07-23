import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';

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
                child: user.profilePicture.contains("File") ? Image.network(
                  user.profilePicture,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * .34,
                  height: MediaQuery.of(context).size.width * .34,
                  filterQuality: FilterQuality.low,
                ) : Icon(Icons.person,color: textColor,size: MediaQuery.of(context).size.width * .34,),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            user.name,
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
                        user.phone,
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
                        user.email,
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
                        user.street,
                        style: getDefaultTextStyle(context),
                      ),
                      subtitle: Text(
                        "${user.city}, ${user.state} ${user.zip}",
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
                        "${dateTimeToStringDate(stringToDateTime(user.lastUpdatedDate, ultimateDateFormat), "dd MMM, yyyy")} ${dateTimeToStringTime(stringToDateTime(user.lastUpdatedDate, ultimateDateFormat), "hh:mm a")}",
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
                        FontAwesomeIcons.briefcase,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        user.companyName,
                        style: getDefaultTextStyle(context),
                      ),
                      subtitle: Text(
                        "${user.companyCity}, ${user.companyState} ${user.companyZip}",
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
