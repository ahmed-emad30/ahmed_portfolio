import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/portfolio_content.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/package_widgets/app_list_animate.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';

class SkillsBody extends StatelessWidget {
  const SkillsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = PortfolioContent.skillCategories;
    final columns = context.gridColumns;

    final content = Padding(
      padding: EdgeInsets.only(
        top: context.sectionTopPadding,
        bottom: 40.h,
      ),
      child: AppListAnimate(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkillsHeader(subtitle: PortfolioContent.skillsSubtitle),
          40.verticalSpace,
          LayoutBuilder(
            builder: (context, constraints) {
              if (columns == 1) {
                return Column(
                  children: categories
                      .map(
                        (category) => Padding(
                          padding: REdgeInsets.only(bottom: 16),
                          child: SkillCategoryCard(category: category),
                        ),
                      )
                      .toList(),
                );
              }

              final itemWidth =
                  (constraints.maxWidth - (columns - 1) * 16.w) / columns;

              return Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                children: categories
                    .map(
                      (category) => SizedBox(
                        width: itemWidth,
                        child: SkillCategoryCard(category: category),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );

    if (context.isMobile) {
      return SingleChildScrollView(child: content);
    }
    return content;
  }
}

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
            Text(
              'Skills',
              style: AppTextStyle.style128ExtraBold.copyWith(
                fontSize: context.responsiveSp(
                  mobile: 56,
                  tablet: 80,
                  desktop: 128,
                ),
                color: theme.primaryAccent,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Text(
          subtitle,
          style: AppTextStyle.style24Regular.copyWith(
            fontSize: context.responsiveSp(
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
            color: theme.bodyText,
            height: 1.3,
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

    return Container(
      width: double.infinity,
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
