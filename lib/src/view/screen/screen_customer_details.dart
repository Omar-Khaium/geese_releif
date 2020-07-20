import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';
import 'package:geesereleif/src/view/widget/bottom_sheet_check_in.dart';
import 'package:geesereleif/src/view/widget/bottom_sheet_comments.dart';
import 'package:geesereleif/src/view/widget/bottom_sheet_media.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final String routeName = "/customer_details";

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 48),
        child: FloatingActionButton(
          elevation: 4,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              builder: (context) => CupertinoActionSheet(
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: Text(
                      "Camera",
                      style: getClickableTextStyle(context, forMenu: true),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await picker.getImage(source: ImageSource.camera);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text("Gallery",
                        style: getClickableTextStyle(context, forMenu: true)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await picker.getImage(source: ImageSource.gallery);
                      },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text(
                    "Close",
                    style: getDeleteTextStyle(context),
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          backgroundColor: accentColor,
          child: Icon(
            FontAwesomeIcons.plus,
            size: 24,
            color: Colors.white,
          ),
          mini: false,
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          "John Doe".toUpperCase(),
          style: getAppBarTextStyle(context),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              height: 22,
              width: 54,
              decoration: BoxDecoration(
                  color: Colors.orange, borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: Text(
                "Lead",
                style: getBadgeTextStyle(context),
              )),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 54,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidUser,
                      color: textColor,
                      size: 18,
                    ),
                    title: Text(
                      "Jhon Doe",
                      style: getDefaultTextStyle(context),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      launch("tel:(302) 254 2154");
                    },
                    leading: Icon(
                      FontAwesomeIcons.phoneAlt,
                      color: textColor,
                      size: 18,
                    ),
                    title: Text(
                      "(302) 254 2154",
                      style: getDefaultTextStyle(context),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      MapsLauncher.launchQuery("Street\nCity, ST *****");
                    },
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
                      FontAwesomeIcons.solidCalendarAlt,
                      color: textColor,
                      size: 18,
                    ),
                    title: Text(
                      "29 Sep, 2019 8:05 AM",
                      style: getDefaultTextStyle(context),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.crow,
                      color: textColor,
                      size: 18,
                    ),
                    title: Text(
                      "3",
                      style: getDefaultTextStyle(context),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCommentAlt,
                      color: textColor,
                      size: 18,
                    ),
                    title: Text(
                      "The next generation of our icon library + toolkit is coming with more icons, more styles, more services, and more awesome. Pre-order today and get a special price and early access!",
                      style: getDefaultTextStyle(context),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    dense: true,
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context)=>PhotoPreview());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.4,
                          height: MediaQuery.of(context).size.width*.3,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,0),
                                color: Colors.grey.shade200,
                                spreadRadius: 4,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(FontAwesomeIcons.solidImages, size: 20, color: accentColor,),
                                SizedBox(height: 4,),
                                Text("13", style: getClickableTextStyle(context, forCount: true),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24,),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context)=>CommentsPreview());
                          },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.4,
                          height: MediaQuery.of(context).size.width*.3,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,0),
                                color: Colors.grey.shade200,
                                spreadRadius: 4,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(FontAwesomeIcons.solidComments, size: 20, color: accentColor,),
                                SizedBox(height: 4,),
                                Text("24", style: getClickableTextStyle(context, forCount: true),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 54,
              decoration: BoxDecoration(color: accentColor, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.grey.shade100,
                    spreadRadius: 8,
                    blurRadius: 8)
              ]),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CheckIn(),
                  );
                },
                splashColor: Colors.black,
                highlightColor: Colors.white,
                child: Center(
                  child: Text(
                    "Check In",
                    style: getButtonTextStyle(context, isOutline: false),
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
