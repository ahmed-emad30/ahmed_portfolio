class ProjectEntity {
  const ProjectEntity({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.imageUrl,
    required this.imageKey,
    required this.techStack,
    required this.features,
    required this.role,
    this.googlePlayUrl = '',
    this.appStoreUrl = '',
    this.videoUrl = '',
    this.githubUrl = '',
    this.apkUrl = '',
    this.webUrl = '',
    this.supportsWindows = false,
    this.previewImage1Url = '',
    this.previewImage1Key = '',
    this.previewImage2Url = '',
    this.previewImage2Key = '',
  });

  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final String imageUrl;
  final String imageKey;
  final List<String> techStack;
  final List<String> features;
  final String role;
  final String googlePlayUrl;
  final String appStoreUrl;
  final String videoUrl;
  final String githubUrl;
  final String apkUrl;
  final String webUrl;
  final bool supportsWindows;
  /// Portfolio screen left/right mockups (not the project cover).
  final String previewImage1Url;
  final String previewImage1Key;
  final String previewImage2Url;
  final String previewImage2Key;

  static bool hasValue(String? value) {
    if (value == null) return false;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    if (trimmed.toLowerCase() == 'null') return false;
    return true;
  }

  bool get hasAnyLink =>
      hasValue(googlePlayUrl) ||
      hasValue(appStoreUrl) ||
      hasValue(videoUrl) ||
      hasValue(githubUrl) ||
      hasValue(apkUrl) ||
      hasValue(webUrl) ||
      supportsWindows;
}
