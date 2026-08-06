import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';
import 'package:portfolio/core/widgets/portfolio_scaffold_background.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart';
import 'package:portfolio/features/hero/presentation/hero_screen/ui/widgets/hero_body.dart';

import 'package:portfolio/core/widgets/section_scroll_navigator.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScrollNavigator(
      currentRoute: Routes.homeScreen,
      child: ShellScaffold(
        body: PortfolioScaffoldBackground(
          child: context.useCompactNavigation
              ? Stack(
                  children: [
                    const HeroBody(),
                    Positioned(
                      top: 8.h,
                      left: 4.w,
                      right: 4.w,
                      child: Builder(
                        builder: (context) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: context.portfolioTheme.primaryAccent,
                              ),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
                            ),
                            const Spacer(),
                            const ThemeToggleButton(compact: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: const HeroBody(),
                ),
        ),
      ),
    );
  }
}
