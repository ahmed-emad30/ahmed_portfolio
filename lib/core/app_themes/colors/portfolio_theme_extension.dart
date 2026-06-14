import 'package:flutter/material.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';

@immutable
class PortfolioThemeExtension extends ThemeExtension<PortfolioThemeExtension> {
  const PortfolioThemeExtension({
    required this.primaryAccent,
    required this.bodyText,
    required this.headingText,
    required this.scaffoldGradientStart,
    required this.scaffoldGradientEnd,
    required this.cardBackground,
    required this.footerBackground,
    required this.navText,
    required this.navActiveText,
    required this.textureOpacity,
    required this.profileBlendMode,
    required this.paginationInactive,
    required this.inputBackground,
  });

  final Color primaryAccent;
  final Color bodyText;
  final Color headingText;
  final Color scaffoldGradientStart;
  final Color scaffoldGradientEnd;
  final Color cardBackground;
  final Color footerBackground;
  final Color navText;
  final Color navActiveText;
  final double textureOpacity;
  final BlendMode profileBlendMode;
  final Color paginationInactive;
  final Color inputBackground;

  static const light = PortfolioThemeExtension(
    primaryAccent: AppColors.primary,
    bodyText: AppColors.secondary,
    headingText: AppColors.primary,
    scaffoldGradientStart: AppColors.scaffoldBackground,
    scaffoldGradientEnd: AppColors.scaffoldSecondaryBackground,
    cardBackground: AppColors.offWhite,
    footerBackground: AppColors.secondary,
    navText: AppColors.secondary,
    navActiveText: AppColors.secondary,
    textureOpacity: 0.1,
    profileBlendMode: BlendMode.srcIn,
    paginationInactive: AppColors.white,
    inputBackground: AppColors.fillColor,
  );

  static const dark = PortfolioThemeExtension(
    primaryAccent: AppColors.darkPrimary,
    bodyText: AppColors.darkTextColor,
    headingText: AppColors.darkPrimary,
    scaffoldGradientStart: Color(0xff4A4A4A),
    scaffoldGradientEnd: AppColors.darkScaffoldBackgroundColor,
    cardBackground: AppColors.darkScaffoldSecondaryBackgroundColor,
    footerBackground: AppColors.secondary,
    navText: AppColors.darkTextColor,
    navActiveText: AppColors.darkTextColor,
    textureOpacity: 0.3,
    profileBlendMode: BlendMode.luminosity,
    paginationInactive: AppColors.darkScaffoldSecondaryBackgroundColor,
    inputBackground: AppColors.darkScaffoldSecondaryBackgroundColor,
  );

  @override
  PortfolioThemeExtension copyWith({
    Color? primaryAccent,
    Color? bodyText,
    Color? headingText,
    Color? scaffoldGradientStart,
    Color? scaffoldGradientEnd,
    Color? cardBackground,
    Color? footerBackground,
    Color? navText,
    Color? navActiveText,
    double? textureOpacity,
    BlendMode? profileBlendMode,
    Color? paginationInactive,
    Color? inputBackground,
  }) {
    return PortfolioThemeExtension(
      primaryAccent: primaryAccent ?? this.primaryAccent,
      bodyText: bodyText ?? this.bodyText,
      headingText: headingText ?? this.headingText,
      scaffoldGradientStart:
          scaffoldGradientStart ?? this.scaffoldGradientStart,
      scaffoldGradientEnd: scaffoldGradientEnd ?? this.scaffoldGradientEnd,
      cardBackground: cardBackground ?? this.cardBackground,
      footerBackground: footerBackground ?? this.footerBackground,
      navText: navText ?? this.navText,
      navActiveText: navActiveText ?? this.navActiveText,
      textureOpacity: textureOpacity ?? this.textureOpacity,
      profileBlendMode: profileBlendMode ?? this.profileBlendMode,
      paginationInactive: paginationInactive ?? this.paginationInactive,
      inputBackground: inputBackground ?? this.inputBackground,
    );
  }

  @override
  PortfolioThemeExtension lerp(
    covariant ThemeExtension<PortfolioThemeExtension>? other,
    double t,
  ) {
    if (other is! PortfolioThemeExtension) return this;
    return PortfolioThemeExtension(
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
      bodyText: Color.lerp(bodyText, other.bodyText, t)!,
      headingText: Color.lerp(headingText, other.headingText, t)!,
      scaffoldGradientStart:
          Color.lerp(scaffoldGradientStart, other.scaffoldGradientStart, t)!,
      scaffoldGradientEnd:
          Color.lerp(scaffoldGradientEnd, other.scaffoldGradientEnd, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      footerBackground: Color.lerp(footerBackground, other.footerBackground, t)!,
      navText: Color.lerp(navText, other.navText, t)!,
      navActiveText: Color.lerp(navActiveText, other.navActiveText, t)!,
      textureOpacity: textureOpacity + (other.textureOpacity - textureOpacity) * t,
      profileBlendMode: t < 0.5 ? profileBlendMode : other.profileBlendMode,
      paginationInactive:
          Color.lerp(paginationInactive, other.paginationInactive, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
    );
  }
}

extension PortfolioThemeContext on BuildContext {
  PortfolioThemeExtension get portfolioTheme =>
      Theme.of(this).extension<PortfolioThemeExtension>() ??
      PortfolioThemeExtension.light;
}
