import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/util/constraints.dart';

// ignore: must_be_immutable
class CheckIn extends StatelessWidget {
  final Function(int) onSave;
  final Customer customer;
  final CustomerProvider customerProvider;
  CheckIn(this.customer, this.customerProvider, {@required this.onSave});

  TextEditingController countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 54,
              child: FlatButton(
                onPressed: () async {
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
                                content: Container(
                                  width: 144,
                                  height: 144,
                                  child: Image.asset(
                                    "images/loading.gif",
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
                          ));
                  bool result = await customerProvider.checkIn(user.token,
                      user.guid, customer.guid, countController.text);
                  Navigator.of(context).pop();
                  if (result) {
                    onSave(int.parse(countController.text));
                    Navigator.of(context).pop();
                  }
                },
                color: accentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Check in",
                    style: getButtonTextStyle(context, isOutline: false),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 54,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "images/logo.png",
                      height: 24,
                    ),
                    SizedBox(height: 24),
                    TextField(
                      controller: countController,
                      keyboardType: TextInputType.number,
                      cursorColor: textColor,
                      style: getCheckInTextFieldStyle(context),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:
                                BorderSide(color: accentColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:
                                BorderSide(color: accentColor, width: 3),
                          ),
                          hintText: "How many geese do you see?",
                          hintStyle: getHintTextStyle(context),
                          isDense: true),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
