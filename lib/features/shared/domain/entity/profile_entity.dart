class ProfileEntity {
  const ProfileEntity({
    required this.displayName,
    required this.title,
    required this.about,
    required this.aeStudioLabel,
    required this.aeStudioUrl,
    required this.resumeUrl,
    required this.skillsSubtitle,
  });

  final String displayName;
  final String title;
  final String about;
  final String aeStudioLabel;
  final String aeStudioUrl;
  final String resumeUrl;
  final String skillsSubtitle;

  String get displayNameWithBreak {
    final trimmed = displayName.trim();
    final space = trimmed.indexOf(' ');
    if (space <= 0) return trimmed;
    return '${trimmed.substring(0, space)}\n${trimmed.substring(space + 1)}';
  }
}
