import 'dart:math' as math;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/portfolio_content.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/gen/assets.gen.dart';

class PortfolioBody extends StatefulWidget {
  const PortfolioBody({super.key});

  @override
  State<PortfolioBody> createState() => _PortfolioBodyState();
}

class _PortfolioBodyState extends State<PortfolioBody> {
  int _featuredIndex = 0;

  final _featuredTitles = PortfolioContent.projects.map((p) => p.title).toList();

  void _showPrevious() {
    setState(() {
      _featuredIndex =
          (_featuredIndex - 1 + _featuredTitles.length) % _featuredTitles.length;
    });
  }

  void _showNext() {
    setState(() {
      _featuredIndex = (_featuredIndex + 1) % _featuredTitles.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final featuredTitle = _featuredTitles[_featuredIndex].toUpperCase();
    return Padding(
      padding: EdgeInsets.only(top: context.sectionTopPadding),
      child: context.isMobile
          ? _buildMobile(context, theme, featuredTitle)
          : _buildDesktop(context, theme, featuredTitle),
    );
  }

  Widget _buildMobile(
    BuildContext context,
    PortfolioThemeExtension theme,
    String featuredTitle,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationIconButton(
                icon: Assets.images.svg.leftArrow.svg(),
                onTap: _showPrevious,
                compact: true,
              ),
              NavigationIconButton(
                icon: Assets.images.svg.rightArrow.svg(),
                onTap: _showNext,
                compact: true,
              ),
            ],
          ),
          16.verticalSpace,
          OutlineText(
            text: featuredTitle,
            fontSize: context.responsiveSp(
              mobile: 56,
              tablet: 120,
              desktop: 230,
            ),
          ),
          24.verticalSpace,
          Assets.images.photos.portfolio2.image(height: 280.h),
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
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationIconButton(
                    icon: Assets.images.svg.leftArrow.svg(),
                    onTap: _showPrevious,
                  ),
                  Expanded(
                    child: OutlineText(
                      text: featuredTitle,
                      isEnabled: false,
                      height: 0.7,
                    ),
                  ),
                  NavigationIconButton(
                    icon: Assets.images.svg.rightArrow.svg(),
                    onTap: _showNext,
                  ),
                ],
              ),
              Stack(
                alignment: const Alignment(0, 0.7),
                children: [
                  Container(
                    width: context.isTablet ? 220.w : 290.w,
                    height: 80.h,
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.rotationZ(13.24 * math.pi / 180),
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
                        child: Assets.images.photos.portfolio1.image(
                          height: context.isTablet ? 0.5.sh : 0.62.sh,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: context.isTablet ? 0.06.sw : 0.088.sw,
                          bottom: 0.13.sh,
                        ),
                        child: Assets.images.photos.portfolio2.image(
                          height: context.isTablet ? 0.48.sh : 0.59.sh,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w + 75.dm),
                child: OutlineText(
                  text: featuredTitle,
                  height: 40 / 230.spMin,
                ),
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
      onTap: () => context.go(Routes.allProjectsScreen),
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

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: AppTextStyle.style230ExtraBold.copyWith(
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
      padding: EdgeInsets.symmetric(horizontal: compact ? 8.w : 35.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12.w : 16.w,
            vertical: compact ? 14.h : 21.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.containerBackground,
          ),
          child: icon,
        ),
      ),
    );
  }
}
