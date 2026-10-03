import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';
import 'package:portfolio/core/widgets/portfolio_scaffold_background.dart';
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
                    // Same bar as the other sections so the icons don't
                    // jump when navigating away from Home.
                    Positioned(
                      top: 0,
                      left: context.horizontalPadding,
                      right: context.horizontalPadding,
                      child: const PortfolioTopBar(),
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
