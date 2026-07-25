import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/gen/assets.gen.dart';

class ServicesBody extends StatelessWidget {
  const ServicesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = context
        .watch<PortfolioContentCubit>()
        .data
        .services
        .map((s) => (s.title, s.description))
        .toList();

    if (cards.length < 4) {
      return const Center(child: CircularProgressIndicator());
    }

    if (context.isMobile) {
      return _ServicesMobile(cards: cards);
    }
    if (context.isTablet) {
      return _ServicesTablet(cards: cards);
    }
    return _ServicesDesktop(cards: cards);
  }
}

class _ServicesMobile extends StatelessWidget {
  const _ServicesMobile({required this.cards});

  final List<(String, String)> cards;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: context.sectionTopPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Services',
              style: AppTextStyle.style128ExtraBold.merge(
                TextStyle(
                  fontSize: context.responsiveSp(
                    mobile: 56,
                    tablet: 80,
                    desktop: 128,
                  ),
                  foreground: AppMethods.textStroke(
                    color: theme.primaryAccent,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
          24.verticalSpace,
          Assets.images.photos.anglePhone.image(height: 260.h),
          24.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FeatureCard(
                  title: cards[0].$1,
                  description: cards[0].$2,
                  compact: true,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: FeatureCard(
                  title: cards[2].$1,
                  description: cards[2].$2,
                  compact: true,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FeatureCard(
                  title: cards[1].$1,
                  description: cards[1].$2,
                  compact: true,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: FeatureCard(
                  title: cards[3].$1,
                  description: cards[3].$2,
                  compact: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServicesTablet extends StatelessWidget {
  const _ServicesTablet({required this.cards});

  final List<(String, String)> cards;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: context.sectionTopPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FeatureCard(
                      title: cards[0].$1,
                      description: cards[0].$2,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: FeatureCard(
                      title: cards[1].$1,
                      description: cards[1].$2,
                    ),
                  ),
                ],
              ),
              32.verticalSpace,
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(vertical: 48),
                    child: Text(
                      'Services',
                      style: AppTextStyle.style128ExtraBold.copyWith(
                        fontSize: context.responsiveSp(
                          mobile: 56,
                          tablet: 80,
                          desktop: 128,
                        ),
                        color: theme.primaryAccent,
                      ),
                    ),
                  ),
                  Assets.images.photos.anglePhone.image(height: 320.h),
                  Text(
                    'Services',
                    style: AppTextStyle.style128ExtraBold.merge(
                      TextStyle(
                        fontSize: context.responsiveSp(
                          mobile: 56,
                          tablet: 80,
                          desktop: 128,
                        ),
                        foreground: AppMethods.textStroke(
                          color: theme.primaryAccent,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              32.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FeatureCard(
                      title: cards[2].$1,
                      description: cards[2].$2,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: FeatureCard(
                      title: cards[3].$1,
                      description: cards[3].$2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServicesDesktop extends StatelessWidget {
  const _ServicesDesktop({required this.cards});

  final List<(String, String)> cards;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(title: cards[0].$1, description: cards[0].$2),
                  FeatureCard(title: cards[1].$1, description: cards[1].$2),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Column(
                      children: [
                        _Branching(icon: Assets.images.svg.topLeft),
                        _Branching(icon: Assets.images.svg.bottomLeft),
                      ],
                    ),
                    Text(
                      'Services',
                      style: AppTextStyle.style128ExtraBold.copyWith(
                        color: theme.primaryAccent,
                      ),
                    ),
                    Column(
                      children: [
                        _Branching(icon: Assets.images.svg.topRight),
                        _Branching(icon: Assets.images.svg.bottomRight),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(title: cards[2].$1, description: cards[2].$2),
                  FeatureCard(title: cards[3].$1, description: cards[3].$2),
                ],
              ),
            ],
          ),
        ),
        if (context.isDesktop)
          Padding(
            padding: REdgeInsetsDirectional.only(start: 40),
            child: Assets.images.photos.anglePhone.image(),
          ),
        Text(
          'Services',
          style: AppTextStyle.style128ExtraBold.merge(
            TextStyle(
              foreground: AppMethods.textStroke(
                color: theme.primaryAccent,
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    this.compact = false,
  });

  final String title;
  final String description;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Container(
      width: compact ? null : (context.isMobile ? double.infinity : 0.27.sw),
      padding: REdgeInsets.symmetric(
        horizontal: compact ? 16 : 24,
        vertical: compact ? 24 : 38,
      ),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.3 * 255),
            offset: const Offset(0, 2),
            blurRadius: 22,
          ),
        ],
      ),
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.style16ExtraBold.copyWith(
              color: theme.primaryAccent,
              height: 1,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.justify,
            maxLines: 4,
            style: AppTextStyle.style16Medium.copyWith(
              color: theme.bodyText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _Branching extends StatelessWidget {
  const _Branching({required this.icon});

  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: icon.svg());
  }
}
