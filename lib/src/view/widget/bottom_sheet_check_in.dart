import 'package:flutter/material.dart';
import 'package:geese_releif/src/provider/provider_keyboard.dart';
import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:geese_releif/src/view/util/helper.dart';
import 'package:provider/provider.dart';

class CheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    return Container(
      height: keyboardProvider.isKeyboardVisible ? 460 : 440,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: FlatButton(
                onPressed: (){},
                color: accentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child:  Text(
                    "Check In",
                    style: getButtonTextStyle(context, isOutline: false),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 32,
              right: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: keyboardProvider.isKeyboardVisible ? 0 : 112,),
                    Image.asset("images/logo.png",height: 42,),
                    SizedBox(height: 24),
                    TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: textColor,
                      style: getCheckInTextFieldStyle(context),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: accentColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: accentColor, width: 2),
                          ),
                          hintText: "How many geese do you see?",
                          hintStyle: getHintTextStyle(context),
                          isDense: true),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
