import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/gen/fonts.gen.dart';

import '../colors/app_colors.dart';

sealed class AppLightThemes {
  static ThemeData call() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      fontFamily: FontFamily.poppins,
      fontFamilyFallback: const ['Cairo'],
      extensions: const [PortfolioThemeExtension.light],
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        surface: AppColors.scaffoldBackground,
        onSurface: AppColors.secondary,
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: const FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
        },
      ),
      switchTheme: SwitchThemeData(
        thumbIcon: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? const Icon(Icons.check, color: AppColors.white, size: 20)
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
      badgeTheme: const BadgeThemeData(backgroundColor: AppColors.red),
      sliderTheme: SliderThemeData(
        trackHeight: 7,
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.secondary,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.3),
        valueIndicatorColor: AppColors.primary,
        showValueIndicator: ShowValueIndicator.onlyForContinuous,
        valueIndicatorStrokeColor: AppColors.primary,
      ),
    );
  }
}
