
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
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
    final horizontalPadding = context.horizontalPadding;

    return ShellScaffold(
      bottomNavigationBar: _showFooter ? const Footer() : null,
      body: path == Routes.aboutScreen
          ? Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                _buildScrollContent(context, horizontalPadding),
                if (context.isDesktop)
                  IgnorePointer(
                    child: Assets.images.photos.sideProfile.image(
                      fit: BoxFit.cover,
                      height: 1.sh,
                    ),
                  ),
              ],
            )
          : _buildScrollContent(context, horizontalPadding),
    );
  }

  Widget _buildScrollContent(BuildContext context, double horizontalPadding) {
    return PortfolioScaffoldBackground(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: const CustomAppBar(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: hasList
                ? sliver
                : SliverFillRemaining(
                    // Allow nested scrollables (mobile ListView /
                    // SingleChildScrollView bodies) to take over.
                    hasScrollBody: true,
                    child: sliver,
                  ),
          ),
        ],
      ),
    );
  }
}
