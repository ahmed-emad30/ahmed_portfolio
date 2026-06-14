import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';
import 'package:portfolio/core/widgets/portfolio_navigation_drawer.dart';
import 'package:portfolio/core/widgets/portfolio_scaffold_background.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart';
import 'package:portfolio/features/hero/presentation/hero_screen/ui/widgets/hero_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShellScaffold(
      body: PortfolioScaffoldBackground(
        child: context.useCompactNavigation
            ? Stack(
                children: [
                  const HeroBody(),
                  Positioned(
                    top: 8.h,
                    left: 4.w,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: context.portfolioTheme.primaryAccent,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: const ThemeToggleButton(compact: true),
                  ),
                ],
              )
            : const HeroBody(),
      ),
    );
  }
}
