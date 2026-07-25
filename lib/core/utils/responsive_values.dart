import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/utils/screen_size_utils.dart';

export 'package:portfolio/core/utils/screen_size_utils.dart';

/// Shared responsive tokens aligned with [ScreenSizeUtils] breakpoints.
///
/// Mobile values track the Figma 375×812 artboard. With adaptive
/// [ScreenSizeUtils.designSizeForWidth], `.w` / `.h` / `.spMin` stay
/// near 1:1 on a mobile-width web viewport.
extension ResponsiveValues on BuildContext {
  double get horizontalPadding {
    if (isMobile) return 16.w;
    if (isTablet) return 32.w;
    return 60.w;
  }

  double get sectionTopPadding {
    if (isMobile) return 24.h;
    if (isTablet) return 64.h;
    return 100.h;
  }

  double responsiveSp({
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    // On mobile, prefer logical px from the 375 artboard so type does not
    // shrink further via nested ScreenUtil font scaling.
    if (isMobile) return mobile;
    if (isTablet) return tablet.spMin;
    return desktop.spMin;
  }

  double get maxContentWidth {
    if (isMobile) return double.infinity;
    if (isTablet) return 720.w;
    return double.infinity;
  }

  int get gridColumns {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 3;
  }

  bool get useCompactNavigation => isMobileOrTablet;
}

double responsiveWidthFactor(BuildContext context, double desktopFactor) {
  if (context.isMobile) return 1;
  if (context.isTablet) return (desktopFactor + 1) / 2;
  return desktopFactor;
}
