import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';
import 'package:portfolio/core/widgets/portfolio_scaffold_background.dart';
import 'package:portfolio/core/widgets/section_scroll_navigator.dart';

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

    final scaffold = ShellScaffold(
      bottomNavigationBar: _showFooter ? const Footer() : null,
      body: path == Routes.aboutScreen
          ? Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                _buildBody(context, horizontalPadding),
                if (context.isDesktop)
                  IgnorePointer(
                    child: Assets.images.photos.sideProfile.image(
                      fit: BoxFit.cover,
                      height: 1.sh,
                    ),
                  ),
              ],
            )
          : _buildBody(context, horizontalPadding),
    );

    return SectionScrollNavigator(
      currentRoute: path ?? '',
      child: scaffold,
    );
  }

  Widget _buildBody(BuildContext context, double horizontalPadding) {
    return PortfolioScaffoldBackground(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const PortfolioTopBar(),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                hasList
                    ? SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        sliver: sliver,
                      )
                    : SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        sliver: SliverFillRemaining(
                          hasScrollBody: true,
                          child: sliver,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
