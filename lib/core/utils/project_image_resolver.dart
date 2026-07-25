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
    if (project.imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: project.imageUrl,
        fit: fit,
        width: width,
        height: height,
        placeholder: (_, __) => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (_, __, ___) => _localOrEmpty(project, fit, width, height),
      );
    }
    return _localOrEmpty(project, fit, width, height);
  }

  static Widget _localOrEmpty(
    ProjectEntity project,
    BoxFit fit,
    double? width,
    double? height,
  ) {
    final asset = localAsset(project.imageKey);
    if (asset != null) {
      return asset.image(fit: fit, width: width, height: height);
    }
    return SizedBox(width: width, height: height);
  }
}
