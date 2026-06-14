class ExperienceEntity {
  const ExperienceEntity({
    required this.role,
    required this.period,
    required this.context,
    required this.bullets,
  });

  final String role;
  final String period;
  final String context;
  final List<String> bullets;
}
