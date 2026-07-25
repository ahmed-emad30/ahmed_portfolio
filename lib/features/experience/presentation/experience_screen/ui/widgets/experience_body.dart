import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/package_widgets/app_list_animate.dart';
import 'package:portfolio/features/experience/domain/entity/experience_entity.dart';
import 'package:portfolio/features/experience/presentation/experience_screen/ui/widgets/experience_entry.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';
import 'package:portfolio/features/skills/presentation/skills_screen/ui/widgets/skills_body.dart';

class ExperienceBody extends StatelessWidget {
  const ExperienceBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final data = context.watch<PortfolioContentCubit>().data;
    final skillCategories = data.skillCategories;

    return Padding(
      padding: EdgeInsets.only(
        top: context.sectionTopPadding,
        bottom: 40.h,
      ),
      child: SingleChildScrollView(
        child: AppListAnimate(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ExperienceHeader(theme: theme),
            48.verticalSpace,
            if (context.isMobile)
              _ExperienceTimeline(experiences: data.experiences)
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ExperienceTimeline(experiences: data.experiences),
                  ),
                  48.horizontalSpace,
                  Expanded(
                    child: _ExperienceSkillsPanel(
                      category: skillCategories.isNotEmpty
                          ? skillCategories.last
                          : const SkillCategoryEntity(
                              title: '',
                              skills: [],
                            ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceHeader extends StatelessWidget {
  const _ExperienceHeader({required this.theme});

  final PortfolioThemeExtension theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!context.isMobile) ...[
          Text(
            'Explore Now!',
            style: AppTextStyle.style40ExtraBold.copyWith(
              color: theme.bodyText,
              height: 0.8,
              fontSize: context.responsiveSp(
                mobile: 28,
                tablet: 32,
                desktop: 40,
              ),
            ),
          ),
          8.verticalSpace,
        ],
        Stack(
          children: [
            Text(
              'Experience',
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
              'Experience',
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
      ],
    );
  }
}

class _ExperienceTimeline extends StatelessWidget {
  const _ExperienceTimeline({required this.experiences});

  final List<ExperienceEntity> experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences
          .map(
            (entry) => Padding(
              padding: REdgeInsets.only(bottom: 32),
              child: ExperienceEntry(entry: entry),
            ),
          )
          .toList(),
    );
  }
}

class _ExperienceSkillsPanel extends StatelessWidget {
  const _ExperienceSkillsPanel({required this.category});

  final SkillCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 48),
      child: SkillCategoryCard(category: category),
    );
  }
}
