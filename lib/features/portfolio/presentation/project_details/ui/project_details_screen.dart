import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/portfolio_content.dart';
import 'package:portfolio/core/widgets/app_screen_navigator.dart';
import 'package:portfolio/core/widgets/hover_interaction.dart';
import 'package:portfolio/core/widgets/package_widgets/app_list_animate.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/gen/assets.gen.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final project = PortfolioContent.projectById(projectId);

    if (project == null) {
      return AppScreenNavigator(
        path: Routes.projectDetailsPath(projectId),
        sliver: Center(
          child: Text(
            'Project not found',
            style: AppTextStyle.style24Regular.copyWith(
              color: context.portfolioTheme.bodyText,
            ),
          ),
        ),
      );
    }

    final index = PortfolioContent.projects.indexWhere((p) => p.id == projectId);

    return AppScreenNavigator(
      path: Routes.projectDetailsPath(projectId),
      hasList: true,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          ProjectDetailsBody(project: project, index: index + 1),
          SizedBox(height: 48.h),
        ]),
      ),
    );
  }
}

class ProjectDetailsBody extends StatelessWidget {
  const ProjectDetailsBody({
    super.key,
    required this.project,
    required this.index,
  });

  final ProjectEntity project;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final number = index < 10 ? '0$index' : '$index';

    return AppListAnimate(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HoverInteraction(
          onTap: () => context.go(Routes.allProjectsScreen),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.svg.leftArrow.svg(
                width: 20.r,
                height: 20.r,
                colorFilter: ColorFilter.mode(
                  theme.primaryAccent,
                  BlendMode.srcIn,
                ),
              ),
              8.horizontalSpace,
              Text(
                'Back to Projects',
                style: AppTextStyle.style15Medium.copyWith(
                  color: theme.primaryAccent,
                ),
              ),
            ],
          ),
        ),
        48.verticalSpace,
        Text(
          number,
          style: AppTextStyle.style48ExtraBold.copyWith(
            color: theme.primaryAccent,
          ),
        ),
        12.verticalSpace,
        Text(
          '${project.title} Application',
          style: AppTextStyle.style48ExtraBold.copyWith(
            color: theme.primaryAccent,
            height: 1.1,
          ),
        ),
        48.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 420.h,
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: project.image.image(fit: BoxFit.contain),
              ),
            ),
            48.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: AppTextStyle.style24Medium.copyWith(
                      color: theme.primaryAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  12.verticalSpace,
                  Text(
                    project.fullDescription,
                    style: AppTextStyle.style16Regular.copyWith(
                      color: theme.bodyText,
                      height: 1.6,
                    ),
                  ),
                  28.verticalSpace,
                  Text(
                    'Tech Stack',
                    style: AppTextStyle.style16ExtraBold.copyWith(
                      color: theme.primaryAccent,
                    ),
                  ),
                  12.verticalSpace,
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: project.techStack
                        .map(
                          (tech) => Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: theme.cardBackground,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              tech,
                              style: AppTextStyle.style15Medium.copyWith(
                                color: theme.bodyText,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  28.verticalSpace,
                  Text(
                    'Key Features',
                    style: AppTextStyle.style16ExtraBold.copyWith(
                      color: theme.primaryAccent,
                    ),
                  ),
                  12.verticalSpace,
                  ...project.features.map(
                    (feature) => Padding(
                      padding: REdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: AppTextStyle.style16Regular.copyWith(
                              color: theme.primaryAccent,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              feature,
                              style: AppTextStyle.style16Regular.copyWith(
                                color: theme.bodyText,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  28.verticalSpace,
                  Text(
                    'Role',
                    style: AppTextStyle.style16ExtraBold.copyWith(
                      color: theme.primaryAccent,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    project.role,
                    style: AppTextStyle.style16Medium.copyWith(
                      color: theme.bodyText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
