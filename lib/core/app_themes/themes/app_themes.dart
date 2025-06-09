import 'package:flutter/material.dart';
import 'package:portfolio/core/app_themes/themes/app_dark_theme.dart';
import 'package:portfolio/core/app_themes/themes/app_light_theme.dart';

sealed class AppThemes {
  static ThemeData dark() {
    return AppDarkThemes.call();
  }

  static ThemeData light() {
    return AppLightThemes.call();
  }
}
