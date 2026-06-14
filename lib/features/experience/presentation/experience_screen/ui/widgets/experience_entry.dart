import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/features/experience/domain/entity/experience_entity.dart';

class ExperienceEntry extends StatelessWidget {
  const ExperienceEntry({super.key, required this.entry});

  final ExperienceEntity entry;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 28.w,
            child: Column(
              children: [
                Container(
                  width: 14.r,
                  height: 14.r,
                  decoration: BoxDecoration(
                    color: theme.primaryAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.primaryAccent, width: 2),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: theme.primaryAccent,
                  ),
                ),
              ],
            ),
          ),
          24.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.cardBackground,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    entry.period,
                    style: AppTextStyle.style13Regular.copyWith(
                      color: theme.primaryAccent,
                    ),
                  ),
                ),
                12.verticalSpace,
                Text(
                  entry.role,
                  style: AppTextStyle.style32Bold.copyWith(
                    fontSize: context.responsiveSp(
                      mobile: 22,
                      tablet: 26,
                      desktop: 32,
                    ),
                    color: theme.primaryAccent,
                    height: 1.1,
                  ),
                ),
                8.verticalSpace,
                Text(
                  entry.context,
                  style: AppTextStyle.style16Medium.copyWith(
                    fontSize: context.responsiveSp(
                      mobile: 14,
                      tablet: 15,
                      desktop: 16,
                    ),
                    color: theme.bodyText,
                  ),
                ),
                16.verticalSpace,
                ...entry.bullets.map(
                  (bullet) => Padding(
                    padding: REdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: REdgeInsets.only(top: 8, right: 10),
                          child: Container(
                            width: 6.r,
                            height: 6.r,
                            decoration: BoxDecoration(
                              color: theme.primaryAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            bullet,
                            style: AppTextStyle.style16Regular.copyWith(
                              fontSize: context.responsiveSp(
                                mobile: 14,
                                tablet: 15,
                                desktop: 16,
                              ),
                              color: theme.bodyText,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
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
