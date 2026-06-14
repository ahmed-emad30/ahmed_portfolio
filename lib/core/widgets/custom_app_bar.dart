import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart';
import 'package:portfolio/core/widgets/top_app_navigator.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SliverAppBar(
      backgroundColor: theme.scaffoldGradientStart,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      floating: true,
      pinned: false,
      snap: true,
      flexibleSpace: Container(
        height: 1.sh,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              theme.scaffoldGradientStart,
              theme.scaffoldGradientEnd,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            TopAppNavigator(),
            ThemeToggleButton(),
          ],
        ),
      ),
    );
  }
}
