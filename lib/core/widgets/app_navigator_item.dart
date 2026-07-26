import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';

import '../../features/shared/domain/entity/navigator_item_entity.dart'
    show NavigatorItemEntity;
import '../app_themes/colors/portfolio_theme_extension.dart';
import '../app_themes/text_style/app_text_style.dart' show AppTextStyle;
import 'active_line.dart' show ActiveLine;

class AppNavigatorItem extends StatelessWidget {
  const AppNavigatorItem({super.key, required this.item});

  final NavigatorItemEntity item;

  static bool isRouteActive(String location, String route) {
    if (route == Routes.homeScreen) {
      return location == Routes.homeScreen;
    }
    if (route == Routes.portfolioScreen) {
      return location == Routes.portfolioScreen ||
          location.startsWith('${Routes.portfolioScreen}/');
    }
    return location == route;
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return ListenableBuilder(
      listenable: router.routerDelegate,
      builder: (context, _) {
        final location = router.state.matchedLocation;
        final isActive = isRouteActive(location, item.route);

        return GestureDetector(
          onTap: () {
            if (!isActive) {
              SectionNavigation.go(context, item.route);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isActive) const ActiveLine(),
              Text(
                item.title,
                style: AppTextStyle.style24Regular.copyWith(
                  height: 26 / 24,
                  letterSpacing: 0,
                  color: context.portfolioTheme.navText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
