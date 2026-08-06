import 'dart:math' as math;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/project_image_resolver.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/gen/assets.gen.dart';

class PortfolioBody extends StatefulWidget {
  const PortfolioBody({super.key});

  @override
  State<PortfolioBody> createState() => _PortfolioBodyState();
}

class _PortfolioBodyState extends State<PortfolioBody> {
  int _featuredIndex = 0;

  /// Portfolio carousel only includes projects with preview mockups.
  List<ProjectEntity> _featuredProjectsOf(BuildContext context) => context
      .read<PortfolioContentCubit>()
      .data
      .projects
      .where((project) => project.hasPreviewImages)
      .toList(growable: false);

  void _showPrevious() {
    final projects = _featuredProjectsOf(context);
    if (projects.length <= 1) return;
    setState(() {
      _featuredIndex =
          (_featuredIndex - 1 + projects.length) % projects.length;
    });
  }

  void _showNext() {
    final projects = _featuredProjectsOf(context);
    if (projects.length <= 1) return;
    setState(() {
      _featuredIndex = (_featuredIndex + 1) % projects.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final projects = context
        .watch<PortfolioContentCubit>()
        .data
        .projects
        .where((project) => project.hasPreviewImages)
        .toList(growable: false);
    if (projects.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: context.sectionTopPadding),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'No projects available yet.',
            style: AppTextStyle.style16Regular.copyWith(
              color: theme.bodyText.withValues(alpha: 0.85),
            ),
          ),
        ),
      );
    }

    final safeIndex = _featuredIndex.clamp(0, projects.length - 1);
    if (safeIndex != _featuredIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _featuredIndex = safeIndex);
      });
    }

    final featured = projects[safeIndex];
    final featuredTitle = featured.title.toUpperCase();
    final showArrows = projects.length > 1;

    return Padding(
      padding: EdgeInsets.only(top: context.sectionTopPadding),
      child: context.isMobile
          ? _buildMobile(
              context,
              theme,
              featuredTitle,
              featured,
              showArrows: showArrows,
            )
          : _buildDesktop(
              context,
              theme,
              featuredTitle,
              featured,
              showArrows: showArrows,
            ),
    );
  }

  Widget _buildMobile(
    BuildContext context,
    PortfolioThemeExtension theme,
    String featuredTitle,
    ProjectEntity featured, {
    required bool showArrows,
  }) {
    final outlineFontSize = context.responsiveSp(
      mobile: 56,
      tablet: 120,
      desktop: 230,
    );
    // Fixed slots so switching projects does not shift the layout vertically.
    final titleSlotHeight = 64.h;
    // Tall enough for the Figma dual-phone composition.
    final imageSlotHeight = 0.42.sh;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              width: double.infinity,
              height: titleSlotHeight,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.center,
                child: OutlineText(
                  text: featuredTitle,
                  fontSize: outlineFontSize,
                  height: 1,
                ),
              ),
            ),
          ),
          16.verticalSpace,
          // Full-bleed preview stage (Figma): phones centered, arrows overlaid.
          SizedBox(
            height: imageSlotHeight,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: _MobilePreviewStack(project: featured),
                  ),
                ),
                if (showArrows)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NavigationIconButton(
                        icon: Assets.images.svg.leftArrow.svg(),
                        onTap: _showPrevious,
                        compact: true,
                      ),
                      const Spacer(),
                      NavigationIconButton(
                        icon: Assets.images.svg.rightArrow.svg(),
                        onTap: _showNext,
                        compact: true,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          24.verticalSpace,
          _exploreButton(context, theme),
        ],
      ),
    );
  }

  Widget _buildDesktop(
    BuildContext context,
    PortfolioThemeExtension theme,
    String featuredTitle,
    ProjectEntity featured, {
    required bool showArrows,
  }) {
    final outlineFontSize = context.responsiveSp(
      mobile: 56,
      tablet: 100,
      desktop: 150,
    );
    final sideInset = showArrows ? 70.w + 75.dm : 24.w;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Decorative layers must not steal arrow taps.
              IgnorePointer(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    OutlineText(
                      text: featuredTitle,
                      fontSize: outlineFontSize,
                      isEnabled: false,
                      height: 0.7,
                    ),
                    Stack(
                      alignment: const Alignment(0, 0.7),
                      children: [
                        Container(
                          width: context.isTablet ? 220.w : 290.w,
                          height: 80.h,
                          alignment: Alignment.bottomCenter,
                          transform:
                              Matrix4.rotationZ(13.24 * math.pi / 180),
                          transformAlignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 78,
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: const Alignment(-2.5, 0),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.isTablet ? 0.12.sw : 0.175.sw,
                                bottom: 40,
                              ),
                              child: ProjectImageResolver.buildPreview(
                                featured,
                                index: 1,
                                height: context.isTablet ? 0.5.sh : 0.62.sh,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.isTablet ? 0.06.sw : 0.088.sw,
                                bottom: 0.13.sh,
                              ),
                              child: ProjectImageResolver.buildPreview(
                                featured,
                                index: 2,
                                height: context.isTablet ? 0.48.sh : 0.59.sh,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sideInset),
                      child: OutlineText(
                        text: featuredTitle,
                        fontSize: outlineFontSize,
                        height: 40 / outlineFontSize,
                      ),
                    ),
                  ],
                ),
              ),
              if (showArrows)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NavigationIconButton(
                      icon: Assets.images.svg.leftArrow.svg(),
                      onTap: _showPrevious,
                    ),
                    const Spacer(),
                    NavigationIconButton(
                      icon: Assets.images.svg.rightArrow.svg(),
                      onTap: _showNext,
                    ),
                  ],
                ),
            ],
          ),
        ),
        _exploreButton(context, theme),
      ],
    );
  }

  Widget _exploreButton(BuildContext context, PortfolioThemeExtension theme) {
    return GestureDetector(
      onTap: () => SectionNavigation.go(context, Routes.allProjectsScreen),
      child: Padding(
        padding: REdgeInsets.only(bottom: 32),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10.r),
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 16),
          color: theme.bodyText,
          strokeWidth: 1,
          dashPattern: const [10, 3, 10, 3],
          child: Text(
            'Explore All Projects',
            style: AppTextStyle.style24Medium.copyWith(
              color: theme.bodyText,
              height: 40 / 24.spMin,
              letterSpacing: -0.02 * 24.spMin,
            ),
          ),
        ),
      ),
    );
  }
}

/// Figma mobile Portfolio mockups: two phones side-by-side,
/// left slightly higher, right slightly lower, mild overlap.
class _MobilePreviewStack extends StatelessWidget {
  const _MobilePreviewStack({required this.project});

  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stageW = constraints.maxWidth;
        final stageH = constraints.maxHeight;
        // Each phone ~half the stage; overlap a bit like the Figma frame.
        final phoneW = stageW * 0.52;
        final phoneH = stageH * 0.98;
        final verticalOffset = stageH * 0.08;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Soft ground shadow (matches desktop depth cue).
            Positioned(
              left: stageW * 0.18,
              right: stageW * 0.18,
              bottom: stageH * 0.06,
              height: 36.h,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.h),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow.withValues(alpha: 0.45),
                        blurRadius: 40,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Left phone — higher (preview 2)
            Positioned(
              left: stageW * 0.02,
              top: 0,
              width: phoneW,
              height: phoneH - verticalOffset,
              child: ProjectImageResolver.buildPreview(
                project,
                index: 2,
                fit: BoxFit.contain,
                width: phoneW,
                height: phoneH - verticalOffset,
              ),
            ),
            // Right phone — lower (preview 1)
            Positioned(
              right: stageW * 0.02,
              bottom: 0,
              width: phoneW,
              height: phoneH - verticalOffset,
              child: ProjectImageResolver.buildPreview(
                project,
                index: 1,
                fit: BoxFit.contain,
                width: phoneW,
                height: phoneH - verticalOffset,
              ),
            ),
          ],
        );
      },
    );
  }
}

class OutlineText extends StatelessWidget {
  const OutlineText({
    super.key,
    required this.text,
    this.strokeWidth = 3,
    this.isEnabled = true,
    this.fontSize,
    this.letterSpacing = -2,
    this.height,
  });

  final String text;
  final double strokeWidth;
  final double letterSpacing;
  final double? height;
  final double? fontSize;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.visible,
      style: AppTextStyle.style230ExtraBold.merge(
        TextStyle(
          color: isEnabled ? null : theme.primaryAccent,
          fontSize: fontSize,
          height: height,
          letterSpacing: letterSpacing,
          textBaseline: TextBaseline.alphabetic,
          foreground: isEnabled
              ? AppMethods.textStroke(
                  color: theme.primaryAccent,
                  strokeWidth: strokeWidth,
                )
              : null,
        ),
      ),
    );
  }
}

class NavigationIconButton extends StatelessWidget {
  const NavigationIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.compact = false,
  });

  final Widget icon;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 52.dm : 75.dm;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: compact ? 4.w : 35.w),
      child: Material(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(
            width: size,
            height: size,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 12.w : 16.w,
                vertical: compact ? 14.h : 21.h,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
