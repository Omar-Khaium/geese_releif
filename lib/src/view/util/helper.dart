
import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
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
      .copyWith(color: textColor.withOpacity(.65), fontWeight: FontWeight.normal),
  );
}

TextStyle getClickableTextStyle(BuildContext context, {bool forMenu = false, bool forCount = false,}) {
  return forCount ? GoogleFonts.montserrat(
    textStyle: Theme.of(context)
        .textTheme
        .headline3
        .copyWith(color: accentColor, fontWeight: FontWeight.normal),
  ) : forMenu ? GoogleFonts.montserrat(
    textStyle: Theme.of(context)
        .textTheme
        .headline6
        .copyWith(color: accentColor, fontWeight: FontWeight.normal),
  ) : GoogleFonts.montserrat(
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

TextStyle getCheckInTextFieldStyle(BuildContext context) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .headline5
      .copyWith(color: textColor, fontWeight: FontWeight.w900),
  );
}

TextStyle getBadgeTextStyle(BuildContext context) {
  return GoogleFonts.montserrat(
  textStyle: Theme.of(context)
      .textTheme
      .caption
      .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
  );
}