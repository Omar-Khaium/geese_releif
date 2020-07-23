import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/screen/screen_profile.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';
import 'package:geesereleif/src/view/widget/list_item/item_history.dart';

class HistoryScreen extends StatelessWidget {
  final String routeName = "/history";

  List<History> list = parseHistory([
    History(
      dateTime: "2020-07-22T10:28:00.000",
      logType: LogType.Active,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-22T09:28:00.000",
      logType: LogType.CheckedOut,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-21T11:28:00.000",
      logType: LogType.CheckedIn,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-21T0:28:00.000",
      logType: LogType.CheckedOut,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-21T06:00:00.000",
      logType: LogType.CheckedIn,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-21T05:30:00.000",
      logType: LogType.CheckedOut,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-20T20:28:00.000",
      logType: LogType.CheckedIn,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-07-20T16:30:00.000",
      logType: LogType.CheckedOut,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-06-30T16:28:00.000",
      logType: LogType.CheckedIn,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
    History(
      dateTime: "2020-05-22T16:28:00.000",
      logType: LogType.CheckedIn,
      customer: Customer(
        guid: "",
        name: "Omar Khaium Chowdhury",
        phone: "+1 555 010 9990",
        street: "22/B Old Baker Street",
        city: "South London",
        state: "SC",
        zip: "12025",
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "History",
          style: getAppBarTextStyle(context),
        ),
        bottom: PreferredSize(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 36,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(32)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.filter,
                  size: 12,
                  color: hintColor,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Last 24 Hours",
                  style: getDefaultTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(36),
        ),
        actions: [
          ChoiceChip(
            label: Text(
              user.name.length>11 ? "${user.name.substring(0,11)}..." : user.name,
              style: getDefaultTextStyle(context),
            ),
            onSelected: (flag) => Navigator.of(context)
                .pushReplacementNamed(ProfileScreen().routeName),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            avatar: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: user.profilePicture.contains("File") ? Image.network(
                user.profilePicture,
                fit: BoxFit.cover,
                width: 32,
                height: 32,
                filterQuality: FilterQuality.low,
              ) : Icon(Icons.person,color: textColor,),
            ),
            selected: false,
            elevation: 0,
            backgroundColor: Colors.grey.shade200,
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(LoginScreen().routeName),
            icon: Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => HistoryItem(list[index]),
        itemCount: list.length,
      ),
    );
  }
}
