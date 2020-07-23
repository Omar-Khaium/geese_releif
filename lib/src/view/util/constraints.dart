
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:google_fonts/google_fonts.dart';

User user = User();

final String ultimateDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS";


//####################################THEME#####################################
final Color backgroundColor = Colors.white;
final Color accentColor = Colors.blue;
final Color textColor = Colors.grey.shade900;
final Color hintColor = Colors.black26;
//##############################################################################


//####################################-API-#####################################
final String apiBaseUrl = "https://api.gratecrm.com/";
final String apiToken = "token";
final String apiUserInfo = "GetUserByUserName";
final String apiRoutes = "GetOrganizationList";
final String apiSelectRoutes = "ChangeDefaultCompany";
final String apiCustomers = "GetAllCustomer";
//##############################################################################

enum LogType {
  CheckedIn,
  Active,
  CheckedOut,
}

TextStyle getAppBarTextStyle(BuildContext context) {
  return GoogleFonts.montserrat(
    textStyle: Theme.of(context)
        .textTheme
        .headline6
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
        .subtitle1
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