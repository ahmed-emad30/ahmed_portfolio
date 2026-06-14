import 'package:portfolio/gen/assets.gen.dart';

class ProjectEntity {
  const ProjectEntity({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.image,
    required this.techStack,
    required this.features,
    required this.role,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final AssetGenImage image;
  final List<String> techStack;
  final List<String> features;
  final String role;
}
