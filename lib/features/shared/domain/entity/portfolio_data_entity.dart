import 'package:portfolio/features/experience/domain/entity/experience_entity.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/shared/domain/entity/profile_entity.dart';
import 'package:portfolio/features/shared/domain/entity/service_entity.dart';
import 'package:portfolio/features/shared/domain/entity/social_link_entity.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';

class PortfolioDataEntity {
  const PortfolioDataEntity({
    required this.profile,
    required this.socialLinks,
    required this.services,
    required this.skillCategories,
    required this.experiences,
    required this.projects,
  });

  static const empty = PortfolioDataEntity(
    profile: ProfileEntity(
      displayName: '',
      title: '',
      about: '',
      aeStudioLabel: '',
      aeStudioUrl: '',
      resumeUrl: '',
      skillsSubtitle: '',
    ),
    socialLinks: [],
    services: [],
    skillCategories: [],
    experiences: [],
    projects: [],
  );

  final ProfileEntity profile;
  final List<SocialLinkEntity> socialLinks;
  final List<ServiceEntity> services;
  final List<SkillCategoryEntity> skillCategories;
  final List<ExperienceEntity> experiences;
  final List<ProjectEntity> projects;

  SocialLinkEntity? socialByKey(String key) {
    for (final link in socialLinks) {
      if (link.key == key && link.isEnabled) return link;
    }
    return null;
  }

  ProjectEntity? projectById(String id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }

  String resolveLinkUrl(String key) {
    final link = socialByKey(key);
    if (link == null) return '';
    if (key == 'cv' && link.url.isEmpty) {
      return profile.resumeUrl;
    }
    return link.url;
  }
}
