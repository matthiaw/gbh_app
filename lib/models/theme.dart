// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';

/// Defines default ThemeData for Application
final ThemeData AppThemeData = new ThemeData (
    brightness: Brightness.light,
    backgroundColor: AppColors.tertiary.shade900,
    primarySwatch: AppColors.primary,
    primaryColor: AppColors.primary.shade500,
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.secondary.shade500,
    accentColorBrightness: Brightness.light
);

// Helper Class for creating materialcolors orientated on design guide of gebetshaus
class AppColors {

  // this basically makes it so you can instantiate this class
  AppColors._();

  // primary color of design guide
  static MaterialColor primary = MaterialColor(
    0xFFb83a4b,
    <int, Color>{
      50: Color(hex("f6e7e9")),
      100: Color(hex("eac4c9")),
      200: Color(hex("dc9da5")),
      300: Color(hex("cd7581")),
      400: Color(hex("c35866")),
      500: Color(hex("b83a4b")),
      600: Color(hex("b13444")),
      700: Color(hex("a82c3b")),
      800: Color(hex("a02533")),
      900: Color(hex("911823")),
    },
  );

  // helper to convert html-colors to int hex color
  static int hex(String hexColor) {
    // trim color-tag and set to upper case
    hexColor = hexColor.toUpperCase().replaceAll("#", "");

    // if transparency not set, the add as prefix
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    // parse hex-code-string to hex-integer
    return int.parse(hexColor, radix: 16);
  }

  // secondary color of design guide
  static MaterialColor secondary = MaterialColor(
    0xFFcc8a00,
    <int, Color>{
      50: Color(hex("f9f1e0")),
      100: Color(hex("f0dcb3")),
      200: Color(hex("e6c580")),
      300: Color(hex("dbad4d")),
      400: Color(hex("d49c26")),
      500: Color(hex("cc8a00")),
      600: Color(hex("c78200")),
      700: Color(hex("c07700")),
      800: Color(hex("b96d00")),
      900: Color(hex("ad5a00")),
    },
  );

  // tertiary color of design guide
  static MaterialColor tertiary = MaterialColor(
    0xFF878889,
    <int, Color>{
      50: Color(hex("f1f1f1")),
      100: Color(hex("dbdbdc")),
      200: Color(hex("c3c4c4")),
      300: Color(hex("abacac")),
      400: Color(hex("999a9b")),
      500: Color(hex("878889")),
      600: Color(hex("7f8081")),
      700: Color(hex("747576")),
      800: Color(hex("6a6b6c")),
      900: Color(hex("54585A")),
    },
  );

  /*static const Map<int, Color> blue = const <int, Color> {
    50: const Color(0x114488),
    100: const Color(0x114488),
    200: const Color(0x114488),
    300: const Color(0x114488),
    400: const Color(0x114488),
    500: const Color(0x114488),
    600: const Color(0x114488),
    700: const Color(0x114488),
    800: const Color(0x114488),
    900: const Color(0x114488)
  };*/

}