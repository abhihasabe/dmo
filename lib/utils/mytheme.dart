// Created by Vishwa on 14/11/22.
// Project Name diamond_bag_tracking.

import 'package:diamond_bag_tracking/utils/constants.dart';
import 'package:flutter/material.dart';


const kGreyColor = Color(0xFFAEAEAE);
const kDividerColor = Color(0xFFBFB7B7);
const kDarkGreyColor = Color(0xFF707070);
const kLightGreyColor = Color(0xFFF1F1F3);
const kLightestGreyColor = Color(0xFFD3D3D3);

const kPrimaryColor = Color(0xFF2A89CB);
const kPrimaryDarkColor = Color(0xFF005b9a);
const kPrimaryLightColor = Color(0xFF6ab8fe);
const kPrimaryLightestColor = Color(0xFFC9E9B3);
const kPrimaryVeryLightestColor = Color(0xFFB5CFCA);

const kLightBrownColor = Color(0xFFEFE1C9);
const kLightGreenColor = Color(0xFFE3ECCD);

const kLightPinkColor = Color(0xFFF8BAB6);
const kLightOrangeColor = Color(0xFFF5C58D);

const kTextColor = Color(0xFF231F20);
const kTitleTextColor = Color(0xFFB14826);
const kUnderLineColor = Color(0xFFE0E0E0);
const kDarkerGreyColor = Color(0xFF747474);

ThemeData themeData() {
  return ThemeData(
    fontFamily: fontOpenSans,
    textTheme: textTheme(),
    splashColor: kGreyColor,
    hintColor: kDarkGreyColor,
    buttonTheme: _buttonTheme(),
    primaryColor: kPrimaryColor,
    primaryColorDark: kPrimaryDarkColor,
    scaffoldBackgroundColor: Colors.white,
    primaryColorLight: kPrimaryLightColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimaryColor),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.iOS: const CupertinoPageTransitionsBuilder()},
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(top: 5, left: 10),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFE6E6E6),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFE6E6E6),
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFE6E6E6),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
      ),
      fillColor: const Color(0xFFFFFFFF),
      filled: true,
      hintStyle: kTextFieldHintTextStyle(),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontFamily: fontOpenSans,
        fontSize: 13,
      ),
    ),
  );
}

TextStyle kTextFieldHintTextStyle() {
  return TextStyle(
    color: const Color(0xFF808080),
    fontFamily: fontOpenSans,
    fontSize: 12,
  );
}

ButtonThemeData _buttonTheme() {
  return const ButtonThemeData(
    height: 40,
    buttonColor: kPrimaryColor,
    splashColor: Colors.black12,
    textTheme: ButtonTextTheme.primary,
    
  );
}

TextTheme textTheme() {
  return const TextTheme(
    subtitle1: TextStyle(
      color: Colors.black,
      fontFamily: fontOpenSans,
      fontSize: 13,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
      fontFamily: fontOpenSans,
      fontSize: 13,
    ),
    button: TextStyle(
        fontSize: 16,
        inherit: true,
        letterSpacing: 0.27,
        color: Colors.white,
        fontFamily: fontOpenSans,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    headline1: TextStyle(
        fontSize: 30,
        letterSpacing: 0.27,
        color: Colors.black,
        fontFamily: fontOpenSans,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        fontSize: 22,
        letterSpacing: 0.27,
        color: Colors.black,
        fontFamily: fontOpenSans,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        fontSize: 18,
        letterSpacing: 0.27,
        color: kPrimaryColor,
        fontFamily: fontOpenSans,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        fontSize: 18,
        letterSpacing: 0.27,
        color: Colors.black,
        fontFamily: fontOpenSans,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        fontSize: 16,
        fontFamily: fontOpenSans,
        letterSpacing: 0.27,
        color: Colors.black,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        fontSize: 14,
        fontFamily: fontOpenSans,
        letterSpacing: 0.10,
        color: Colors.black,
        decoration: TextDecoration.none),
    caption: TextStyle(
        fontSize: 16,
        fontFamily: fontOpenSans,
        letterSpacing: 0.27,
        color: kPrimaryColor,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        fontSize: 13,
        letterSpacing: 0.10,
        color: Colors.black,
        fontFamily: fontOpenSans,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        fontSize: 12,
        letterSpacing: 0.10,
        color: Colors.black,
        fontFamily: fontOpenSans,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none),
  );
}
