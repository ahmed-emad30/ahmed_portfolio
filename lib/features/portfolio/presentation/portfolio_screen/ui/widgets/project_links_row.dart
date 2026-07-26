import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/url_launcher_helper.dart';
import 'package:portfolio/core/widgets/hover_interaction.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/gen/assets.gen.dart';

class ProjectLinksRow extends StatelessWidget {
  const ProjectLinksRow({
    super.key,
    required this.project,
    this.compact = false,
  });

  final ProjectEntity project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;
    final items = <_ProjectLinkItem>[
      if (ProjectEntity.hasValue(project.googlePlayUrl))
        _ProjectLinkItem(
          label: 'Google Play',
          url: project.googlePlayUrl,
          icon: Assets.images.svg.googlePlay,
        ),
      if (ProjectEntity.hasValue(project.appStoreUrl))
        _ProjectLinkItem(
          label: 'App Store',
          url: project.appStoreUrl,
          icon: Assets.images.svg.appStore,
        ),
      if (ProjectEntity.hasValue(project.videoUrl))
        _ProjectLinkItem(
          label: 'Video',
          url: project.videoUrl,
          icon: Assets.images.svg.video,
        ),
      if (ProjectEntity.hasValue(project.githubUrl))
        _ProjectLinkItem(
          label: 'GitHub',
          url: project.githubUrl,
          icon: Assets.images.svg.github,
        ),
      if (ProjectEntity.hasValue(project.apkUrl))
        _ProjectLinkItem(
          label: 'APK',
          url: project.apkUrl,
          icon: Assets.images.svg.apk,
        ),
      if (ProjectEntity.hasValue(project.webUrl))
        _ProjectLinkItem(
          label: 'Web',
          url: project.webUrl,
          icon: Assets.images.svg.web,
        ),
      if (project.supportsWindows)
        _ProjectLinkItem(
          label: 'Windows',
          url: null,
          icon: Assets.images.svg.windows,
        ),
    ];

    if (items.isEmpty) return const SizedBox.shrink();

    final size = compact ? 22.dm : 28.dm;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact) ...[
          Text(
            'Links & Platforms',
            style: AppTextStyle.style16ExtraBold.copyWith(
              color: theme.primaryAccent,
            ),
          ),
          12.verticalSpace,
        ],
        Wrap(
          spacing: compact ? 10.w : 14.w,
          runSpacing: compact ? 10.h : 12.h,
          children: items
              .map(
                (item) => _ProjectLinkIcon(
                  item: item,
                  size: size,
                  accent: theme.primaryAccent,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ProjectLinkItem {
  const _ProjectLinkItem({
    required this.label,
    required this.icon,
    this.url,
  });

  final String label;
  final SvgGenImage icon;
  final String? url;
}

class _ProjectLinkIcon extends StatelessWidget {
  const _ProjectLinkIcon({
    required this.item,
    required this.size,
    required this.accent,
  });

  final _ProjectLinkItem item;
  final double size;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final child = Tooltip(
      message: item.label,
      child: Container(
        width: size + 16.dm,
        height: size + 16.dm,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: item.icon.svg(
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
        ),
      ),
    );

    final url = item.url?.trim();
    if (!ProjectEntity.hasValue(url)) {
      return child;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HoverInteraction(
        onTap: () => UrlLauncherHelper.open(url!),
        child: child,
      ),
    );
  }
}
