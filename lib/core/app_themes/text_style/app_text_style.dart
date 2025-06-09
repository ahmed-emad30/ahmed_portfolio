import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/text_style/font_weight_helper.dart';

sealed class AppTextStyle {
  static TextStyle _textStyle(double size, FontWeight weight) {
    return TextStyle(
      fontSize: size.spMin,
      color: AppColors.white,
      fontWeight: weight,
    );
  }

  static TextStyle get style230ExtraBold => _textStyle(230, FontWeightHelper.extraBold);
  static TextStyle get style154ExtraBold => _textStyle(154, FontWeightHelper.extraBold);
  static TextStyle get style128ExtraBold => _textStyle(128, FontWeightHelper.extraBold);
  static TextStyle get style96ExtraBold => _textStyle(96, FontWeightHelper.extraBold);
  static TextStyle get style48ExtraBold => _textStyle(48, FontWeightHelper.extraBold);
  static TextStyle get style40ExtraBold => _textStyle(40, FontWeightHelper.extraBold);
  static TextStyle get style16ExtraBold => _textStyle(16, FontWeightHelper.extraBold);
  static TextStyle get style36Bold => _textStyle(36, FontWeightHelper.bold);
  static TextStyle get style32Bold => _textStyle(32, FontWeightHelper.bold);
  static TextStyle get style32Regular => _textStyle(32, FontWeightHelper.regular);
  static TextStyle get style24Regular => _textStyle(24, FontWeightHelper.regular);
  static TextStyle get style16Regular => _textStyle(16, FontWeightHelper.regular);
  static TextStyle get style13Regular => _textStyle(13, FontWeightHelper.regular);
  static TextStyle get style15Medium => _textStyle(15, FontWeightHelper.medium);
  static TextStyle get style16Medium => _textStyle(16, FontWeightHelper.medium);
  static TextStyle get style24Medium => _textStyle(24, FontWeightHelper.medium);

}
