import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';

class SkillsHeader extends StatelessWidget {
  const SkillsHeader({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Text(
              'Skills',
              style: AppTextStyle.style128ExtraBold.merge(
                TextStyle(
                  foreground: AppMethods.textStroke(
                    color: theme.primaryAccent,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
            Text(
              'Skills',
              style: AppTextStyle.style128ExtraBold.copyWith(
                color: theme.primaryAccent,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Text(
          subtitle,
          style: AppTextStyle.style24Regular.copyWith(
            color: theme.bodyText,
            height: 26 / 24.spMin,
          ),
        ),
      ],
    );
  }
}

class SkillCategoryCard extends StatelessWidget {
  const SkillCategoryCard({super.key, required this.category});

  final SkillCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Expanded(
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: theme.cardBackground,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: theme.bodyText.withValues(alpha: 0.15),
              offset: const Offset(0, 2),
              blurRadius: 22,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.title,
              style: AppTextStyle.style16ExtraBold.copyWith(
                color: theme.primaryAccent,
              ),
            ),
            16.verticalSpace,
            ...category.skills.map(
              (skill) => Padding(
                padding: REdgeInsets.only(bottom: 14),
                child: SkillProgressBar(skill: skill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillProgressBar extends StatelessWidget {
  const SkillProgressBar({super.key, required this.skill});

  final SkillEntity skill;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: AppTextStyle.style15Medium.copyWith(color: theme.bodyText),
            ),
            Text(
              '${skill.proficiency}%',
              style: AppTextStyle.style13Regular.copyWith(
                color: theme.primaryAccent,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: skill.proficiency / 100,
            minHeight: 8.h,
            backgroundColor: theme.bodyText.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(skill.color),
          ),
        ),
      ],
    );
  }
}
