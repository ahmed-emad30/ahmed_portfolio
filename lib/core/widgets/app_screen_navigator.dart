
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';
import 'package:portfolio/core/widgets/portfolio_scaffold_background.dart';

import '../../features/portfolio/presentation/portfolio_screen/ui/all_projects_screen.dart'
    show Footer;
import '../../gen/assets.gen.dart' show Assets;

class AppScreenNavigator extends StatelessWidget {
  const AppScreenNavigator({
    super.key,
    required this.path,
    required this.sliver,
    this.hasList = false,
  });

  final String? path;
  final Widget sliver;
  final bool hasList;

  bool get _showFooter {
    return path == Routes.allProjectsScreen ||
        path == Routes.contactScreen ||
        (path?.startsWith('${Routes.portfolioScreen}/project/') ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.portfolioTheme.scaffoldGradientEnd,
      bottomNavigationBar: _showFooter ? const Footer() : null,
      body: path == Routes.aboutScreen
          ? Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                _buildContainer(context),
                Assets.images.photos.sideProfile.image(
                  fit: BoxFit.cover,
                  height: 1.sh,
                ),
              ],
            )
          : _buildContainer(context),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return PortfolioScaffoldBackground(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            sliver: const CustomAppBar(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            sliver: hasList
                ? sliver
                : SliverFillRemaining(
                    child: sliver,
                  ),
          ),
        ],
      ),
    );
  }
}
