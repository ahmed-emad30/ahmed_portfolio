import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/features/experience/domain/entity/experience_entity.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';
import 'package:portfolio/gen/assets.gen.dart';

sealed class PortfolioContent {
  static const String skillsSubtitle =
      'Technologies I work with daily to build polished mobile experiences.';

  static List<SkillCategoryEntity> get skillCategories => [
        SkillCategoryEntity(
          title: 'Languages & Frameworks',
          skills: [
            SkillEntity(
              name: 'Flutter',
              proficiency: 95,
              color: AppColors.greenProgress,
            ),
            SkillEntity(
              name: 'Dart',
              proficiency: 90,
              color: AppColors.lightBlueProgress,
            ),
          ],
        ),
        SkillCategoryEntity(
          title: 'Backend & Tools',
          skills: [
            SkillEntity(
              name: 'REST APIs',
              proficiency: 85,
              color: AppColors.yellowProgress,
            ),
            SkillEntity(
              name: 'Firebase',
              proficiency: 80,
              color: AppColors.redProgress,
            ),
          ],
        ),
        SkillCategoryEntity(
          title: 'Architecture & Practices',
          skills: [
            SkillEntity(
              name: 'Cubit / Bloc',
              proficiency: 88,
              color: AppColors.greenProgress,
            ),
            SkillEntity(
              name: 'Localization (AR/EN)',
              proficiency: 85,
              color: AppColors.lightBlueProgress,
            ),
            SkillEntity(
              name: 'Responsive UI',
              proficiency: 90,
              color: AppColors.yellowProgress,
            ),
            SkillEntity(
              name: 'Performance',
              proficiency: 82,
              color: AppColors.redProgress,
            ),
          ],
        ),
      ];

  static List<ExperienceEntity> get experiences => [
        const ExperienceEntity(
          role: 'Flutter Developer',
          period: '2+ Years',
          context: 'Cross-platform mobile apps · App Store · Google Play · Huawei AppGallery',
          bullets: [
            'Built and published 15+ cross-platform mobile applications.',
            'Delivered production apps across App Store, Google Play, and Huawei AppGallery.',
            'Implemented real-time features, responsive UI, and Arabic/English localization.',
          ],
        ),
        const ExperienceEntity(
          role: 'Mobile UI/UX Focus',
          period: 'Ongoing',
          context: 'User-centered interfaces and interactive mobile experiences',
          bullets: [
            'Designed responsive layouts aligned with product goals and brand identity.',
            'Built engaging flows with attention to accessibility and usability.',
            'Collaborated on feature delivery from concept to store release.',
          ],
        ),
        const ExperienceEntity(
          role: 'Performance & Clean Code',
          period: 'Ongoing',
          context: 'Maintainable architecture and optimized mobile performance',
          bullets: [
            'Applied Cubit-based state management for scalable feature modules.',
            'Optimized rendering, networking, and app startup performance.',
            'Maintained readable, testable codebases for long-term product growth.',
          ],
        ),
      ];

  static List<ProjectEntity> get projects => [
        ProjectEntity(
          id: 'taggz',
          title: 'Taggz',
          shortDescription:
              'An iOS and Android social tagging app with real-time discovery, profile flows, and polished cross-platform UI.',
          fullDescription:
              'Taggz is a cross-platform mobile application focused on social tagging and discovery. I built responsive screens, integrated REST APIs, and implemented real-time interactions with a clean Cubit-based architecture. The app supports smooth onboarding, profile management, and store-ready deployment.',
          image: Assets.images.photos.taggz,
          techStack: const ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: const [
            'Cross-platform iOS and Android experience',
            'Real-time social tagging and discovery flows',
            'Responsive UI with performance-focused architecture',
          ],
          role: 'Flutter Developer',
        ),
        ProjectEntity(
          id: 'iconcierge',
          title: 'iConcierge',
          shortDescription:
              'An iOS and Android concierge platform with service booking, notifications, and localized user journeys.',
          fullDescription:
              'iConcierge connects users with concierge services through a streamlined mobile experience. I implemented booking flows, Firebase-backed notifications, and bilingual support while keeping the interface intuitive and brand-consistent across devices.',
          image: Assets.images.photos.iconcierge,
          techStack: const ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: const [
            'Service booking and request management',
            'Push notifications and backend integration',
            'Arabic and English localization support',
          ],
          role: 'Flutter Developer',
        ),
        ProjectEntity(
          id: 'wepick',
          title: 'Wepick',
          shortDescription:
              'An iOS and Android selection platform with curated content, dynamic lists, and engaging mobile interactions.',
          fullDescription:
              'Wepick helps users browse and select curated content through a fast, responsive mobile interface. I focused on list performance, API-driven content rendering, and reusable UI components that scale across product iterations.',
          image: Assets.images.photos.wepick,
          techStack: const ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: const [
            'Curated content browsing and selection',
            'Optimized list rendering and API integration',
            'Modular UI components for rapid iteration',
          ],
          role: 'Flutter Developer',
        ),
        ProjectEntity(
          id: 'all-traders',
          title: 'All Traders',
          shortDescription:
              'An iOS and Android trading companion app with market views, account flows, and secure data handling.',
          fullDescription:
              'All Traders delivers market insights and account management in a mobile-first experience. I implemented secure API communication, responsive dashboards, and performance tuning for data-heavy screens used throughout the trading journey.',
          image: Assets.images.photos.alltraders,
          techStack: const ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: const [
            'Market dashboards and account management flows',
            'Secure REST API integration',
            'Performance tuning for data-heavy screens',
          ],
          role: 'Flutter Developer',
        ),
      ];

  static ProjectEntity? projectById(String id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }

  static const int projectsPerPage = 8;
}
