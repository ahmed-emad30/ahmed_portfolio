import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/portfolio_navigation_drawer.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart';
import 'package:portfolio/core/widgets/top_app_navigator.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      // backgroundColor: theme.scaffoldGradientStart,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      collapsedHeight: 80.h,
      // automaticallyImplyActions: false,
      snap: true,
      flexibleSpace: Container(
        alignment: Alignment.topCenter,
       /* decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              theme.scaffoldGradientStart,
              theme.scaffoldGradientEnd,
            ],
          ),
        ),*/
        padding: EdgeInsets.only(top: 12.h),
        child: context.useCompactNavigation
            ? Builder(
                builder: (context) => Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: theme.primaryAccent),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    const Spacer(),
                    const ThemeToggleButton(compact: true),
                  ],
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopAppNavigator(),
                  ThemeToggleButton(),
                ],
              ),
      ),
    );
  }
}

/// Registers the navigation drawer on shell scaffolds.
class ShellScaffold extends StatelessWidget {
  const ShellScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
  });

  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldGradientStart,
      drawer: context.useCompactNavigation
          ? const PortfolioNavigationDrawer()
          : null,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}
