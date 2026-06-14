import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/widgets/portfolio_scaffold_background.dart';
import 'package:portfolio/features/hero/presentation/hero_screen/ui/widgets/hero_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.portfolioTheme.scaffoldGradientEnd,
      body: PortfolioScaffoldBackground(
        child: const HeroBody(),
      ),
    );
  }
}
