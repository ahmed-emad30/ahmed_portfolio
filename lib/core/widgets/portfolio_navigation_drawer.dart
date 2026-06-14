import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_constants.dart';
import 'package:portfolio/core/widgets/app_navigator_item.dart';
import 'package:portfolio/core/widgets/active_line.dart';

class PortfolioNavigationDrawer extends StatelessWidget {
  const PortfolioNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Drawer(
      backgroundColor: theme.scaffoldGradientEnd,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahmed Emad',
                style: AppTextStyle.style32Bold.copyWith(
                  color: theme.primaryAccent,
                ),
              ),
              8.verticalSpace,
              Text(
                'Flutter Developer',
                style: AppTextStyle.style16Medium.copyWith(
                  color: theme.bodyText,
                ),
              ),
              32.verticalSpace,
              Expanded(
                child: ListView.separated(
                  itemCount: AppConstants.items.length,
                  separatorBuilder: (_, __) => 8.verticalSpace,
                  itemBuilder: (context, index) {
                    final item = AppConstants.items[index];
                    final router = GoRouter.of(context);
                    final isActive = AppNavigatorItem.isRouteActive(
                      router.state.matchedLocation,
                      item.route,
                    );

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.go(item.route);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isActive) const ActiveLine(),
                          Text(
                            item.title,
                            style: AppTextStyle.style24Regular.copyWith(
                              color: theme.navText,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
