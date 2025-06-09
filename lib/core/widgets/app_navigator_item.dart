import 'dart:developer' show log;

import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        GestureDetector,
        MainAxisSize,
        StatelessWidget,
        Text,
        Widget;

import 'package:go_router/go_router.dart' show GoRouter, GoRouterHelper;
import '../../features/shared/domain/entity/navigator_item_entity.dart'
    show NavigatorItemEntity;
import '../app_themes/colors/app_colors.dart' show AppColors;
import '../app_themes/text_style/app_text_style.dart' show AppTextStyle;
import 'active_line.dart' show ActiveLine;

class AppNavigatorItem extends StatelessWidget {
  const AppNavigatorItem({super.key, required this.item});

  final NavigatorItemEntity item;

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouter.of(context).state.fullPath == item.route;
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          log('current route: ${GoRouter.of(context).state.fullPath}');
          context.go(item.route);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive) ActiveLine(),
          Text(
            item.title,
            style: AppTextStyle.style24Regular.copyWith(
              height: 26 / 24, // line-height ÷ font-size
              letterSpacing: 0,
              color: AppColors.labelTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
