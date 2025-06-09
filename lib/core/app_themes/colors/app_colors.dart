import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color primary = Color(0xffDEAC16);
  static const Color secondary = Color(0xff636363);
  static const Color mainColor = white;

  /// Global App color
  static const Color blueGreyOpacity15 = Color(0x26607D8B);
  static const Color blueGreyOpacity2 = Color(0x33607D8B);
  static const Color blue = Color(0xFF007AFF);
  static const Color green = Color(0xFF38B000);
  static const Color red = Color(0xFFC1121F);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  /// Global Widget UI Colors
  static const Color scaffoldBackground = Color(0xffD4D4D4);
  static const Color scaffoldSecondaryBackground = Color(0xffEEEEEE);
  static const Color appbarBackground = secondary;
  static const Color sidebarBackground = secondary;
  static const Color divider = zn700;
  static const Color appbarDivider = zn700;
  static const Color greenProgress = Color(0xffB6FF85);
  static const Color lightBlueProgress = Color(0xff95F6FF);
  static const Color redProgress = Color(0xffFF8484);
  static const Color yellowProgress = Color(0xffFFEE6F);
  static const Color containerBackground = Color(0xffc2c2c2);
  static const Color textMediumColor = Color(0xff454545);

  /// Text Form Colors
  static const Color labelTextColor = secondary;
  static const Color hintColor = Color(0xFF8D9499);

  static const Color fillColor = Color(0xff636363);
  static const Color lightGreyColor = Color(0xffaeaeae);
  static const Color shadow = Color(0xff7e7e7e);
  static const Color whiteText = Color(0xffe1e1e1);

  static const Color bookedChairColor = Color(0xFFE8E8E8);
  static const Color textFieldBorder = zn300;

  /// Primary Colors
  static const Color zn25 = Color(0xFFfafafa);
  static const Color zn50 = Color(0xFFf4f4f5);
  static const Color zn100 = Color(0xFFe4e4e7);
  static const Color zn200 = Color(0xFFd4d4d8);
  static const Color zn300 = Color(0xFFa1a1aa);
  static const Color zn400 = Color(0xFF71717a);
  static const Color zn500 = Color(0xFF52525b);
  static const Color zn600 = Color(0xFF3f3f46);
  static const Color zn700 = Color(0xFF27272a);
  static const Color zn800 = Color(0xFF18181b);
  static const Color zn900 = Color(0xFF09090b);

  /// Error
  static const Color error = red;

  /// Success
  static const Color success = green;


  //Dark Theme
  static const Color darkPrimary = Color(0xffDEAC16);
  static const Color darkSecondary = Color(0xff636363);
  static const Color darkMainColor = white;
  static const Color darkTextColor = Color(0xffD9D9D9);
  static const Color darkScaffoldBackgroundColor = Color(0xff212121);
  static const Color darkScaffoldSecondaryBackgroundColor = Color(0xff4A4A4A);
}
