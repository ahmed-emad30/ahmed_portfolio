class SocialLinkEntity {
  const SocialLinkEntity({
    required this.key,
    required this.url,
    required this.sortOrder,
    required this.isEnabled,
  });

  final String key;
  final String url;
  final int sortOrder;
  final bool isEnabled;
}
