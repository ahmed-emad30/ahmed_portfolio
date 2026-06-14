import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/portfolio_content.dart';
import 'package:portfolio/core/widgets/package_widgets/app_list_animate.dart';
import 'package:portfolio/features/experience/presentation/experience_screen/ui/widgets/experience_entry.dart';

class ExperienceBody extends StatelessWidget {
  const ExperienceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100.h, bottom: 40.h),
      child: AppListAnimate(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExperienceHeader(),
          48.verticalSpace,
          ...PortfolioContent.experiences.map(
            (entry) => Padding(
              padding: REdgeInsets.only(bottom: 32),
              child: ExperienceEntry(entry: entry),
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceHeader extends StatelessWidget {
  const ExperienceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Stack(
      children: [
        Text(
          'Experience',
          style: AppTextStyle.style128ExtraBold.copyWith(
            foreground: AppMethods.textStroke(
              color: theme.primaryAccent,
              strokeWidth: 2,
            ),
          ),
        ),
        Text(
          'Experience',
          style: AppTextStyle.style128ExtraBold.copyWith(
            color: theme.primaryAccent,
          ),
        ),
      ],
    );
  }
}
