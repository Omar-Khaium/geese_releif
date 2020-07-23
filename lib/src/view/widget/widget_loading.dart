import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/util/constraints.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
        child: SimpleDialog(
          contentPadding: EdgeInsets.all(0),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          children: <Widget>[
            Center(
              child: Container(
                width: 144,
                height: 144,
                child: Image.asset(
                  "images/loading.gif",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
