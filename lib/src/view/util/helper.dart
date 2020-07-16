
import 'package:flutter/material.dart';
import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getAppBarTextStyle(BuildContext context) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .headline5
      .copyWith(color: textColor, fontWeight: FontWeight.bold),
  );
}

TextStyle getDefaultTextStyle(BuildContext context, {bool isFocused = false}) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .bodyText1
      .copyWith(color: textColor, fontWeight: isFocused ? FontWeight.bold : FontWeight.normal),
  );
}

TextStyle getDeleteTextStyle(BuildContext context, {bool isFocused = false}) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .headline6
      .copyWith(color: Colors.red, fontWeight: isFocused ? FontWeight.bold : FontWeight.normal),
  );
}

TextStyle getHintTextStyle(BuildContext context) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .bodyText1
      .copyWith(color: hintColor),
  );
}

TextStyle getCaptionTextStyle(BuildContext context) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .caption
      .copyWith(color: textColor.withOpacity(.75), fontWeight: FontWeight.normal),
  );
}

TextStyle getClickableTextStyle(BuildContext context) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .subtitle2
      .copyWith(color: accentColor, fontWeight: FontWeight.normal),
  );
}

TextStyle getButtonTextStyle(BuildContext context, {bool isOutline = true}) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .headline6
      .copyWith(color: isOutline ? accentColor : backgroundColor, fontWeight: FontWeight.bold),
  );
}