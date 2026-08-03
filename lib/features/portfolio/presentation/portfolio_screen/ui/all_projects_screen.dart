import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_constants.dart';
import 'package:portfolio/core/utils/project_image_resolver.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/utils/url_launcher_helper.dart';
import 'package:portfolio/core/widgets/app_screen_navigator.dart';
import 'package:portfolio/core/widgets/hover_interaction.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/portfolio_body.dart'
    show OutlineText;
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/project_links_row.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:portfolio/gen/assets.gen.dart';

class AllProjectsScreen extends StatefulWidget {
  const AllProjectsScreen({super.key});

  @override
  State<AllProjectsScreen> createState() => _AllProjectsScreenState();
}

class _AllProjectsScreenState extends State<AllProjectsScreen> {
  int _currentPage = 0;

  List<ProjectEntity> get _projects =>
      context.watch<PortfolioContentCubit>().data.projects;

  int get _totalPages {
    if (_projects.isEmpty) return 0;
    return (_projects.length / AppConstants.projectsPerPage).ceil();
  }

  List<ProjectEntity> get _visibleProjects {
    if (_projects.isEmpty) return const [];
    final start = _currentPage * AppConstants.projectsPerPage;
    final end = (start + AppConstants.projectsPerPage).clamp(
      0,
      _projects.length,
    );
    return _projects.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    final projects = _projects;
    final visible = _visibleProjects;
    final theme = context.portfolioTheme;

    return AppScreenNavigator(
      hasList: true,
      path: Routes.allProjectsScreen,
      sliver: SliverList.builder(
        itemCount: projects.isEmpty ? 2 : visible.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const ExploreNow();
          }

          if (projects.isEmpty) {
            return Padding(
              padding: REdgeInsets.only(bottom: 48.h, top: 24.h),
              child: Text(
                'No projects available yet.',
                style: AppTextStyle.style16Regular.copyWith(
                  color: theme.bodyText.withValues(alpha: 0.85),
                ),
              ),
            );
          }

          if (index == visible.length + 1) {
            if (_totalPages <= 1) {
              return SizedBox(height: 48.h);
            }
            return Padding(
              padding: REdgeInsets.only(bottom: 48.h),
              child: _ProjectsPagination(
                currentPage: _currentPage,
                totalPages: _totalPages,
                onPageSelected: (page) => setState(() => _currentPage = page),
              ),
            );
          }

          final project = visible[index - 1];
          final globalIndex =
              (_currentPage * AppConstants.projectsPerPage) + index;

          return ProjectsItem(
            index: globalIndex,
            project: project,
          );
        },
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final profile = context.watch<PortfolioContentCubit>().data.profile;

    return Container(
      width: 1.sw,
      height: 30.h,
      alignment: Alignment.center,
      color: theme.footerBackground,
      child: RichText(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: 'Ahmed Emad © 2025. Designed by ',
          style: AppTextStyle.style10Medium.copyWith(
            color: AppColors.whiteText,
            fontFamily: 'inter',
            height: 1.0,
            letterSpacing: 0,
          ),
          children: [
            TextSpan(
              text: profile.aeStudioLabel,
              style: AppTextStyle.style10Medium.copyWith(
                color: theme.primaryAccent,
                fontFamily: 'inter',
                height: 1.0,
                letterSpacing: 0,
                decoration: profile.aeStudioUrl.isNotEmpty
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
              recognizer: profile.aeStudioUrl.isNotEmpty
                  ? (TapGestureRecognizer()
                    ..onTap = () {
                      UrlLauncherHelper.open(profile.aeStudioUrl);
                    })
                  : null,
            ),
            TextSpan(
              text: '. All Rights Reserved',
              style: AppTextStyle.style10Medium.copyWith(
                color: AppColors.whiteText,
                fontFamily: 'inter',
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsPagination extends StatelessWidget {
  const _ProjectsPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5.w,
        children: [
          PageItem(
            title: 'Prev',
            onTap: currentPage > 0 ? () => onPageSelected(currentPage - 1) : null,
          ),
          ...List.generate(totalPages, (index) {
            return PageItem(
              title: '${index + 1}',
              isActive: index == currentPage,
              onTap: () => onPageSelected(index),
            );
          }),
          PageItem(
            title: 'Next',
            onTap: currentPage < totalPages - 1
                ? () => onPageSelected(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  const PageItem({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return HoverInteraction(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          minWidth: 32.dm,
          minHeight: 32.dm,
        ),
        decoration: BoxDecoration(
          color: isActive ? theme.primaryAccent : theme.paginationInactive,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          title,
          style: AppTextStyle.style13Regular.copyWith(
            color: onTap == null
                ? AppColors.pageText
                : isActive
                    ? AppColors.white
                    : theme.primaryAccent,
          ),
        ),
      ),
    );
  }
}

class ProjectsItem extends StatelessWidget {
  const ProjectsItem({super.key, required this.index, required this.project});

  final int index;
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final isOdd = index % 2 == 1;
    final has2Digits = index > 9;

    if (context.isMobile) {
      return Container(
        width: 1.sw,
        margin: REdgeInsets.only(bottom: 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectCover(project: project, compact: true),
            24.verticalSpace,
            Text(
              has2Digits ? '$index' : '0$index',
              style: AppTextStyle.style48ExtraBold.copyWith(
                height: 56 / 48.spMin,
                letterSpacing: -0.02 * 48.spMin,
                color: theme.primaryAccent,
                fontSize: context.responsiveSp(
                  mobile: 36,
                  tablet: 48,
                  desktop: 48,
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              '${project.title} Application',
              style: AppTextStyle.style32Bold.copyWith(
                height: 40 / 32.spMin,
                letterSpacing: -0.02 * 32.spMin,
                color: theme.primaryAccent,
                fontSize: context.responsiveSp(
                  mobile: 24,
                  tablet: 28,
                  desktop: 32,
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              project.shortDescription,
              style: AppTextStyle.style16Regular.copyWith(
                height: 24 / 16.spMin,
                letterSpacing: -0.02 * 16.spMin,
                color: theme.bodyText.withValues(alpha: 0.85),
              ),
            ),
            if (project.hasAnyLink) ...[
              16.verticalSpace,
              ProjectLinksRow(project: project, compact: true),
            ],
            20.verticalSpace,
            DetailsButton(projectId: project.id),
          ],
        ),
      );
    }

    return Container(
      width: 1.sw,
      constraints: BoxConstraints(
        minHeight: context.isTablet ? 0 : 343.4.h,
      ),
      margin: REdgeInsets.only(bottom: context.isTablet ? 56.h : 80.h),
      child: Row(
        textDirection: isOdd ? TextDirection.ltr : TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectCover(
            project: project,
            compact: context.isTablet,
          ),
          SizedBox(width: context.isTablet ? 24.w : 60.w),
          Expanded(
            child: Padding(
              padding: REdgeInsetsDirectional.only(top: 16, end: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    has2Digits ? '$index' : '0$index',
                    style: AppTextStyle.style48ExtraBold.copyWith(
                      height: 56 / 48.spMin,
                      letterSpacing: -0.02 * 48.spMin,
                      color: theme.primaryAccent,
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(vertical: 28),
                    child: Text(
                      '${project.title} Application',
                      style: AppTextStyle.style32Bold.copyWith(
                        height: 40 / 32.spMin,
                        letterSpacing: -0.02 * 32.spMin,
                        color: theme.primaryAccent,
                      ),
                    ),
                  ),
                  Text(
                    project.shortDescription,
                    maxLines: context.isTablet ? 6 : 4,
                    style: AppTextStyle.style16Regular.copyWith(
                      height: 24 / 16.spMin,
                      letterSpacing: -0.02 * 16.spMin,
                      color: theme.bodyText.withValues(alpha: 0.85),
                    ),
                  ),
                  if (project.hasAnyLink) ...[
                    16.verticalSpace,
                    ProjectLinksRow(project: project, compact: true),
                  ],
                  20.verticalSpace,
                  DetailsButton(projectId: project.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return HoverInteraction(
      onTap: () => context.push(Routes.projectDetailsPath(projectId)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'View full project details',
            style: AppTextStyle.style15Medium.copyWith(
              color: theme.primaryAccent,
              height: 56 / 15.spMin,
              letterSpacing: -0.02 * 15.spMin,
            ),
          ),
          8.horizontalSpace,
          Assets.images.svg.export.svg(),
        ],
      ),
    );
  }
}

class ProjectCover extends StatelessWidget {
  const ProjectCover({
    super.key,
    required this.project,
    this.compact = false,
  });

  final ProjectEntity project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = compact ? 1.sw : 400.w;
    final height = compact ? 220.h : 0.75 * 400.w;

    return Container(
      width: width,
      height: height,
      margin: REdgeInsetsDirectional.only(
        start: compact ? 0 : 10,
        top: compact ? 0 : 10,
        bottom: compact ? 0 : 10,
        end: compact ? 0 : 16,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x00000040),
            blurRadius: 12.r,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: ProjectImageResolver.build(
        project,
        fit: BoxFit.contain,
        width: width,
        height: height,
      ),
    );
  }
}

class ExploreNow extends StatelessWidget {
  const ExploreNow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Padding(
      padding: EdgeInsets.only(
        top: context.sectionTopPadding,
        bottom: context.isMobile ? 40.h : 80.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Explore Now!',
            style: AppTextStyle.style40ExtraBold.copyWith(
              color: theme.bodyText,
              height: 0.8,
              letterSpacing: 0,
              fontSize: context.responsiveSp(
                mobile: 28,
                tablet: 32,
                desktop: 40,
              ),
            ),
          ),
          OutlineText(
            text: 'Projects',
            strokeWidth: 2,
            fontSize: context.responsiveSp(
              mobile: 56,
              tablet: 72,
              desktop: 96,
            ),
          ),
        ],
      ),
    );
  }
}
