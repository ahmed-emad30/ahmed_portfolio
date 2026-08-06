import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/gen/assets.gen.dart';

sealed class ProjectImageResolver {
  static AssetGenImage? localAsset(String imageKey) {
    switch (imageKey) {
      case 'taggz':
        return Assets.images.photos.taggz;
      case 'iconcierge':
        return Assets.images.photos.iconcierge;
      case 'wepick':
        return Assets.images.photos.wepick;
      case 'alltraders':
      case 'all-traders':
        return Assets.images.photos.alltraders;
      case 'portfolio1':
        return Assets.images.photos.portfolio1;
      case 'portfolio2':
        return Assets.images.photos.portfolio2;
      default:
        return null;
    }
  }

  static Widget build(
    ProjectEntity project, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    return buildFrom(
      url: project.imageUrl,
      key: project.imageKey,
      fit: fit,
      width: width,
      height: height,
    );
  }

  /// Portfolio hero mockups — separate from [ProjectEntity.imageUrl] cover.
  ///
  /// Resolution order:
  /// 1) preview url/key for this slot
  /// 2) project cover [imageUrl] / [imageKey]
  /// 3) shared portfolio mockups (last resort only)
  static Widget buildPreview(
    ProjectEntity project, {
    required int index,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
  }) {
    final useFirst = index == 1;
    final previewUrl =
        useFirst ? project.previewImage1Url : project.previewImage2Url;
    final previewKey =
        useFirst ? project.previewImage1Key : project.previewImage2Key;

    final hasPreviewUrl = ProjectEntity.hasValue(previewUrl);
    final hasPreviewKey = ProjectEntity.hasValue(previewKey);
    final hasCoverUrl = ProjectEntity.hasValue(project.imageUrl);
    final hasCoverKey = ProjectEntity.hasValue(project.imageKey);

    final resolvedUrl = hasPreviewUrl
        ? previewUrl
        : hasCoverUrl
            ? project.imageUrl
            : '';

    final resolvedKey = hasPreviewKey
        ? previewKey
        : hasCoverKey
            ? project.imageKey
            : (useFirst ? 'portfolio1' : 'portfolio2');

    return buildFrom(
      url: resolvedUrl,
      key: resolvedKey,
      fit: fit,
      width: width,
      height: height,
    );
  }

  static Widget buildFrom({
    required String url,
    required String key,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    if (ProjectEntity.hasValue(url)) {
      return CachedNetworkImage(
        imageUrl: url.trim(),
        fit: fit,
        width: width,
        height: height,
        fadeInDuration: const Duration(milliseconds: 220),
        fadeOutDuration: const Duration(milliseconds: 120),
        placeholder: (_, __) => _ImageLoadingPlaceholder(
          width: width,
          height: height,
        ),
        errorWidget: (_, __, ___) =>
            _localOrEmpty(key, fit, width, height),
      );
    }
    return _localOrEmpty(key, fit, width, height);
  }

  static Widget _localOrEmpty(
    String imageKey,
    BoxFit fit,
    double? width,
    double? height,
  ) {
    final asset = localAsset(imageKey);
    if (asset != null) {
      return asset.image(fit: fit, width: width, height: height);
    }
    return SizedBox(width: width, height: height);
  }
}

/// Soft fixed-size placeholder — avoids a spinning indicator jumping layout.
class _ImageLoadingPlaceholder extends StatefulWidget {
  const _ImageLoadingPlaceholder({
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<_ImageLoadingPlaceholder> createState() =>
      _ImageLoadingPlaceholderState();
}

class _ImageLoadingPlaceholderState extends State<_ImageLoadingPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.35, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.bodyText.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.bodyText.withValues(alpha: 0.06),
          ),
        ),
      ),
    );
  }
}
