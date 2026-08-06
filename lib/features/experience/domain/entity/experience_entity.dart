class ExperienceEntity {
  const ExperienceEntity({
    required this.role,
    required this.company,
    required this.period,
    required this.context,
    required this.bullets,
    this.techTags = const [],
  });

  final String role;
  final String company;
  final String period;
  final String context;
  final List<String> bullets;
  final List<String> techTags;
}
