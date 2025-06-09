import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/shared/domain/entity/navigator_item_entity.dart' show NavigatorItemEntity;
import '../app_routes/routes_strings.dart' show Routes;

/// Apply this on all project
sealed class AppConstants {
  /// App Border Radius
  static const double borderRadius = 24;
  static BorderRadius borderRadiusCircular = BorderRadius.circular(
    borderRadius,
  );
  static BorderRadius borderRadiusCircularButton = BorderRadius.circular(
    borderRadius,
  );
  static BorderRadius textFormBorderRadius = BorderRadius.circular(
    borderRadius,
  );

  /// App Horizontal Padding
  static const double horizontalPadding = 16;
  static const horizontalPaddingEdge = EdgeInsets.symmetric(
    horizontal: horizontalPadding,
  );

  static const double bottomNavBarHeight = 80;

  /// App Version
  static const String appVersion = '1.0.0';
  static final List<NavigatorItemEntity> items=[
    NavigatorItemEntity(title: 'Home', route:Routes.homeScreen),
    NavigatorItemEntity(title: 'About', route:Routes.aboutScreen),
    NavigatorItemEntity(title: 'Services', route:Routes.servicesScreen),
    NavigatorItemEntity(title: 'Portfolio', route:Routes.portfolioScreen),
    NavigatorItemEntity(title: 'Skills', route:Routes.skillsScreen),
    NavigatorItemEntity(title: 'Experience', route:Routes.experienceScreen),
    NavigatorItemEntity(title: 'Contact', route:Routes.contactScreen),
  ];
}
