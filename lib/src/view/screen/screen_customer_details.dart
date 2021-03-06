import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/note.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/provider/provider_keyboard.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_upload_file.dart';
import 'package:geesereleif/src/view/widget/bottom_sheet_check_in.dart';
import 'package:geesereleif/src/view/widget/bottom_sheet_media.dart';
import 'package:geesereleif/src/view/widget/bottom_sheet_notes.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String routeName = "/customer_details";

  @override
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  File _image;
  final picker = ImagePicker();

  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String ?? "";
    final customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: true);
    final Customer customer = customerProvider.findCustomerByID(id);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Visibility(
        visible: keyboardProvider.isKeyboardHidden,
        child: Container(
          margin: EdgeInsets.only(bottom: 48),
          child: FloatingActionButton(
            elevation: 4,
            mini: false,
            onPressed: () {
              keyboardProvider.hideKeyboard(context);
              if (_noteController.text.isNotEmpty) {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: Text(
                            "Discard note?",
                            style: getAppBarTextStyle(context),
                          ),
                          content: Text("You haven't shared your note yet. Are you sure that you want to leave without posting?"),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: getActionPositive(context),
                              ),
                              isDefaultAction: true,
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _noteController.text = "";
                                });
                                Navigator.of(context).pop();
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
                                          getImage(ImageSource.camera, customer.guid);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text("Gallery", style: getClickableTextStyle(context, forMenu: true)),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          getImage(ImageSource.gallery, customer.guid);
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
                              child: Text(
                                "Discard",
                                style: getActionNegative(context),
                              ),
                              isDestructiveAction: true,
                            ),
                          ],
                        ),
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4));
              } else {
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
                          getImage(ImageSource.camera, customer.guid);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text("Gallery", style: getClickableTextStyle(context, forMenu: true)),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          getImage(ImageSource.gallery, customer.guid);
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
              }
            },
            backgroundColor: accentColor,
            child: Icon(
              Icons.add_a_photo,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          customer.name.toUpperCase(),
          style: getAppBarTextStyle(context),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Visibility(
            visible: keyboardProvider.isKeyboardVisible,
            child: IconButton(
              onPressed: () {
                keyboardProvider.hideKeyboard(context);
              },
              icon: Icon(
                Icons.keyboard_hide,
                color: accentColor,
              ),
            ),
          ),
          ActionChip(
            onPressed: () {
              historyProvider.reset();
              Navigator.of(context).pushNamed(HistoryScreen().routeName, arguments: customer.guid);
            },
            label: Visibility(
              child: Text(
                "History",
                style: getDefaultTextStyle(context),
              ),
            ),
            labelPadding: const EdgeInsets.only(right: 4),
            avatar: Icon(
              FontAwesomeIcons.history,
              size: 14,
              color: Colors.grey.shade700,
            ),
            backgroundColor: Colors.grey.shade200,
            elevation: 0,
          ),
          SizedBox(width: 12,),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: keyboardProvider.isKeyboardVisible ? 0 : 54,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Visibility(
                    visible: customerProvider.user.role=="Admin" && customer.phone.isNotEmpty,
                    child: ListTile(
                      onTap: () {
                        if (customer.phone.isNotEmpty) launch("tel:${customer.phone}");
                      },
                      leading: Icon(
                        FontAwesomeIcons.phoneAlt,
                        color: textColor,
                        size: 18,
                      ),
                      title: Text(
                        customer.phone.isEmpty ? "no number" : customer.phone ?? "-",
                        style: customer.phone.isEmpty ? getHintTextStyle(context) : getDefaultTextStyle(context),
                      ),
                      dense: true,
                    ),
                  ),
                  Visibility(
                    visible: constructAddress(customer.street, customer.city, customer.state, customer.zip).isNotEmpty,
                    child: ListTile(
                        onTap: () {
                          if (constructAddress(customer.street, customer.city, customer.state, customer.zip).isNotEmpty) {
                            MapsLauncher.launchQuery(
                              constructAddress(customer.street, customer.city, customer.state, customer.zip),
                            );
                          }
                        },
                        leading: Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: textColor,
                          size: 18,
                        ),
                        title: Text(
                          constructAddress(customer.street, customer.city, customer.state, customer.zip).isEmpty
                              ? "no address"
                              : constructAddress(customer.street, customer.city, customer.state, customer.zip),
                          style: constructAddress(customer.street, customer.city, customer.state, customer.zip).isEmpty
                              ? getHintTextStyle(context)
                              : getDefaultTextStyle(context),
                        )),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidCalendarAlt,
                      color: textColor,
                      size: 18,
                    ),
                    title: Text(
                      customer.lastCheckIn.startsWith("20")
                          ? "${dateTimeToStringDate(stringToDateTime(customer.lastCheckIn), "dd MMM, yyyy")} ${dateTimeToStringTime(stringToDateTime(customer.lastCheckIn), "hh:mm a")}"
                          : "no check-in date",
                      style: customer.lastCheckIn.isEmpty || !customer.lastCheckIn.startsWith("20")
                          ? getHintTextStyle(context)
                          : getDefaultTextStyle(context),
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
                      "${customer.geeseCount}",
                      style: getDefaultTextStyle(context),
                    ),
                    dense: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: TextField(
                      controller: _noteController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: textColor,
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 4,
                      onChanged: (text) {
                        setState(() {});
                      },
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
                        hintText: "Write a note...",
                        hintStyle: getHintTextStyle(context),
                        isDense: true,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _noteController.text.isNotEmpty,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        onPressed: () async {
                          keyboardProvider.hideKeyboard(context);
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => WillPopScope(
                                    onWillPop: () async => false,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                      child: AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        content: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ));
                          bool response = await customerProvider.sendNote(context, id, customer.guid, _noteController.text);
                          if (response) {
                            customerProvider.newNote(
                              customer.guid,
                              Note(
                                _noteController.text,
                                refineLocal(DateTime.now().toIso8601String()),
                                customerProvider.user.name,
                              ),
                            );
                            setState(() {
                              _noteController.text = "";
                            });
                          }
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        color: Colors.blue,
                        child: Text(
                          "POST",
                          style: getButtonTextStyle(context, isOutline: false),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => PhotoPreview(customer.mediaList),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
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
                                  Icon(
                                    FontAwesomeIcons.solidImages,
                                    size: 20,
                                    color: accentColor,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    customer.mediaList.length.toString(),
                                    style: getClickableTextStyle(context, forCount: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(context: context, builder: (context) => NotesPreview(customer.noteList));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
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
                                  Icon(
                                    FontAwesomeIcons.solidComments,
                                    size: 20,
                                    color: accentColor,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    customer.noteList.length.toString(),
                                    style: getClickableTextStyle(context, forCount: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: keyboardProvider.isKeyboardHidden,
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                    color: customer.isCheckedIn ? Colors.red.shade300 : accentColor,
                    boxShadow: [BoxShadow(offset: Offset(0, 1), color: Colors.grey.shade100, spreadRadius: 8, blurRadius: 8)]),
                child: InkWell(
                  onTap: keyboardProvider.isKeyboardVisible
                      ? null
                      : () async {
                          if (!customer.isCheckedIn) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: CheckIn(
                                  customer,
                                  customerProvider,
                                  onSave: (count) {
                                    customerProvider.newCheckIn(customer.guid, count);
                                    customerProvider.changeLastCheckInOutTime(refineLocal(DateTime.now().toIso8601String()), customer.guid);
                                    historyProvider.newCheckIn(customer, count);
                                  },
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => WillPopScope(
                                      onWillPop: () async => false,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                        child: AlertDialog(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          content: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ));
                            bool result = await customerProvider.checkOut(context, customer.guid);
                            if (result) {
                              customerProvider.newCheckOut(customer.guid);
                              historyProvider.newCheckOut(customer);
                            }
                          }
                        },
                  splashColor: Colors.black,
                  highlightColor: Colors.white,
                  child: Center(
                    child: Text(
                      "Check ${customer.isCheckedIn ? "out" : "in"}",
                      style: getButtonTextStyle(context, isOutline: false),
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

  Future getImage(source, customerId) async {
    final pickedFile = await picker.getImage(source: source,imageQuality: source== ImageSource.camera ? 50 : 60);

    setState(() {
      _image = File(pickedFile.path);
    });
    _image = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Adjust Image',
          toolbarColor: Colors.blue,
          activeControlsWidgetColor: Colors.blue,
          cropFrameColor: Colors.blue,
          backgroundColor: Colors.black,
          statusBarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          showCropGrid: true,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Adjust Image',
        showCancelConfirmationDialog: true,
      ),
    );

    Navigator.of(context).pushNamed(UploadFileScreen().routeName, arguments: {
      "image": _image,
      "customerId": customerId,
    });
  }
}
