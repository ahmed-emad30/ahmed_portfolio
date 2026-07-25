import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/project_image_resolver.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/app_screen_navigator.dart';
import 'package:portfolio/core/widgets/package_widgets/app_list_animate.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/project_links_row.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<PortfolioContentCubit>().data;
    final project = data.projectById(projectId);

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

    final index = data.projects.indexWhere((p) => p.id == projectId);

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
            fontSize: context.responsiveSp(
              mobile: 28,
              tablet: 36,
              desktop: 48,
            ),
          ),
        ),
        48.verticalSpace,
        if (context.isMobile)
          _buildContentColumn(context, theme)
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildMockup(context, theme)),
              48.horizontalSpace,
              Expanded(child: _buildDetails(context, theme)),
            ],
          ),
      ],
    );
  }

  Widget _buildContentColumn(
    BuildContext context,
    PortfolioThemeExtension theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMockup(context, theme),
        32.verticalSpace,
        _buildDetails(context, theme),
      ],
    );
  }

  Widget _buildMockup(
    BuildContext context,
    PortfolioThemeExtension theme,
  ) {
    return Container(
      height: context.isMobile ? 260.h : 420.h,
      width: double.infinity,
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
      child: ProjectImageResolver.build(project, fit: BoxFit.contain),
    );
  }

  Widget _buildDetails(
    BuildContext context,
    PortfolioThemeExtension theme,
  ) {
    return Column(
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
        if (project.hasAnyLink) ...[
          28.verticalSpace,
          ProjectLinksRow(project: project),
        ],
      ],
    );
  }
}
