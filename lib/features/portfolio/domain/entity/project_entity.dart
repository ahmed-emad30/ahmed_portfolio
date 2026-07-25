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

  bool get hasAnyLink =>
      googlePlayUrl.trim().isNotEmpty ||
      appStoreUrl.trim().isNotEmpty ||
      videoUrl.trim().isNotEmpty ||
      githubUrl.trim().isNotEmpty ||
      apkUrl.trim().isNotEmpty ||
      webUrl.trim().isNotEmpty ||
      supportsWindows;
}
