import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_constants.dart';
import 'package:portfolio/gen/fonts.gen.dart';

sealed class AppDarkThemes {
  static ThemeData call() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
      fontFamily: FontFamily.poppins,
      fontFamilyFallback: const ['Cairo'],
      extensions: const [PortfolioThemeExtension.dark],
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBackgroundColor,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 16,
        shape: const Border(
          bottom: BorderSide(color: AppColors.appbarDivider, width: 1.5),
        ),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        surfaceTintColor: Colors.transparent,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.zn200,
        labelStyle: AppTextStyle.style16Medium,
        unselectedLabelColor: AppColors.zn300,
        unselectedLabelStyle: AppTextStyle.style16Medium,
        dividerColor: AppColors.zn700,
        indicatorColor: AppColors.zn200,
        overlayColor: const WidgetStatePropertyAll<Color>(AppColors.zn700),
        splashFactory: InkRipple.splashFactory,
      ),
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        surface: AppColors.darkScaffoldBackgroundColor,
        onSurface: AppColors.darkTextColor,
      ),
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? const Icon(Icons.check, color: AppColors.primary, size: 20)
              : const Icon(Icons.close, size: 20),
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : AppColors.white,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.white
              : AppColors.primary,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? null : AppColors.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            side: const BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
      badgeTheme: const BadgeThemeData(backgroundColor: AppColors.red),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(AppColors.primary),
        fillColor: WidgetStateProperty.resolveWith((states) => AppColors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 74,
        overlayColor: const WidgetStatePropertyAll<Color>(AppColors.zn700),
        backgroundColor: AppColors.secondary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.secondary,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.zn300,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
