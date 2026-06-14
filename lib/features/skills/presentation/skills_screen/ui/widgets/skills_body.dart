import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/utils/portfolio_content.dart';
import 'package:portfolio/core/widgets/package_widgets/app_list_animate.dart';
import 'package:portfolio/features/skills/presentation/skills_screen/ui/widgets/skills_header.dart'
    show SkillCategoryCard, SkillsHeader;

class SkillsBody extends StatelessWidget {
  const SkillsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = PortfolioContent.skillCategories;

    return Padding(
      padding: EdgeInsets.only(top: 100.h, bottom: 40.h),
      child: AppListAnimate(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkillsHeader(subtitle: PortfolioContent.skillsSubtitle),
          40.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories
                .map((category) => SkillCategoryCard(category: category))
                .toList(),
          ),
        ],
      ),
    );
  }
}
