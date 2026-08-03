import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/utils/app_constants.dart';

/// Tracks navigation direction for vertical scroll transitions and edge-scroll.
class SectionNavigation {
  SectionNavigation._();

  static String fromRoute = Routes.homeScreen;
  static String toRoute = Routes.homeScreen;
  static bool goingDown = true;

  /// Main sections that participate in edge-scroll (Home excluded).
  static List<String> get scrollableRoutes => AppConstants.items
      .map((item) => item.route)
      .where((route) => route != Routes.homeScreen)
      .toList(growable: false);

  static bool isScrollableSection(String route) {
    return scrollableRoutes.contains(route);
  }

  static void prepare(String from, String to) {
    fromRoute = from;
    toRoute = to;

    final fromIndex = AppConstants.items.indexWhere((i) => i.route == from);
    final toIndex = AppConstants.items.indexWhere((i) => i.route == to);
    if (fromIndex >= 0 && toIndex >= 0) {
      goingDown = toIndex > fromIndex;
    } else {
      goingDown = true;
    }
  }

  static void go(BuildContext context, String route) {
    final from = GoRouter.of(context).state.matchedLocation;
    if (from == route) return;
    prepare(from, route);
    context.go(route);
  }

  /// Edge-scroll target: next/previous scrollable section, never Home.
  static String? neighbor(String currentRoute, int direction) {
    final routes = scrollableRoutes;
    final index = routes.indexOf(currentRoute);
    if (index < 0) return null;
    final next = index + direction;
    if (next < 0 || next >= routes.length) return null;
    return routes[next];
  }
}
