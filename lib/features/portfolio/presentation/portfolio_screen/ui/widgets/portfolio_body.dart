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
      padding: EdgeInsets.only(top: 50.h),
      child: Column(
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
                      width: 290.w,
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
                            left: 0.175.sw,
                            bottom: 40,
                          ),
                          child: Assets.images.photos.portfolio1.image(
                            height: 0.62.sh,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0.088.sw,
                            bottom: 0.13.sh,
                          ),
                          child: Assets.images.photos.portfolio2.image(
                            height: 0.59.sh,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                OutlineText(
                  text: featuredTitle,
                  height: 40 / 230.spMin,
                ),
              ],
            ),
          ),
          GestureDetector(
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
          ),
        ],
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

    return Text(
      text,
      textAlign: TextAlign.center,
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
    );
  }
}

class NavigationIconButton extends StatelessWidget {
  const NavigationIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 75.dm,
          height: 75.dm,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
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
