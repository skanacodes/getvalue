import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Ubuntu',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  // OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  //   // borderRadius: BorderRadius.circular(10),
  //   // borderSide: BorderSide(color: kTextColor),
  //   gapPadding: 10,
  // );
  return const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
    // enabledBorder: outlineInputBorder,
    // focusedBorder: outlineInputBorder,
    // border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle:
        TextStyle(color: Color(0XFF8B8B8B), fontSize: 18, fontFamily: 'Ubuntu'),
    toolbarTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}
