import 'dart:ui';

import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color color;

  Loading(this.color);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
        child: Container(
          child: Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          ),
          width: 64,
          height: 64,
        ),
      ),
    );
  }
}
