import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  static Widget buildPreview(
    ProjectEntity project, {
    required int index,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
  }) {
    final useFirst = index == 1;
    final url = useFirst ? project.previewImage1Url : project.previewImage2Url;
    final key = useFirst ? project.previewImage1Key : project.previewImage2Key;
    final fallbackKey = useFirst ? 'portfolio1' : 'portfolio2';

    return buildFrom(
      url: url,
      key: ProjectEntity.hasValue(key) ? key : fallbackKey,
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
        placeholder: (_, __) => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
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
