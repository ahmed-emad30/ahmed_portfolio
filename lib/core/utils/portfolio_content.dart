import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/features/experience/domain/entity/experience_entity.dart';
import 'package:portfolio/features/portfolio/domain/entity/project_entity.dart';
import 'package:portfolio/features/shared/domain/entity/portfolio_data_entity.dart';
import 'package:portfolio/features/shared/domain/entity/profile_entity.dart';
import 'package:portfolio/features/shared/domain/entity/service_entity.dart';
import 'package:portfolio/features/shared/domain/entity/social_link_entity.dart';
import 'package:portfolio/features/skills/domain/entity/skill_entity.dart';

/// Local fallback content used when Supabase is unreachable.
sealed class PortfolioContent {
  static const int projectsPerPage = 8;

  static PortfolioDataEntity get fallback => PortfolioDataEntity(
        profile: const ProfileEntity(
          displayName: 'Ahmed Emad.',
          title: 'Flutter Developer',
          about:
              '''Flutter Developer with 2+ years of experience building and publishing 15+ cross-platform mobile apps on the App Store, Google Play, and Huawei AppGallery. Skilled in Dart, Flutter, REST APIs, Firebase, and state management using Cubit. Proven ability to design responsive UIs, implement real-time features, and support localization (Arabic/English). Passionate about clean code, performance optimization, and delivering user-focused mobile experiences''',
          aeStudioLabel: 'AE Studio',
          aeStudioUrl: 'https://www.abdelrhman-elnhas.com',
          resumeUrl: '',
          skillsSubtitle:
              'Technologies I work with daily to build polished mobile experiences.',
        ),
        socialLinks: const [
          SocialLinkEntity(
            key: 'github',
            url: 'https://github.com/ahmed-emad30',
            sortOrder: 1,
            isEnabled: true,
          ),
          SocialLinkEntity(
            key: 'linkedin',
            url: 'https://www.linkedin.com/in/ahmed-emad-lotfy/',
            sortOrder: 2,
            isEnabled: true,
          ),
          SocialLinkEntity(
            key: 'email',
            url: 'mailto:ahmedemad0173@gmail.com',
            sortOrder: 3,
            isEnabled: true,
          ),
          SocialLinkEntity(
            key: 'whatsapp',
            url: 'https://wa.me/+201007344288',
            sortOrder: 4,
            isEnabled: true,
          ),
          SocialLinkEntity(
            key: 'cv',
            url: '',
            sortOrder: 5,
            isEnabled: true,
          ),
          SocialLinkEntity(
            key: 'x',
            url: 'https://x.com/Ahmed_Emad30',
            sortOrder: 6,
            isEnabled: true,
          ),
        ],
        services: const [
          ServiceEntity(
            title: 'Mobile App Development',
            description:
                'Cross-platform Flutter apps tailored to product goals and user needs.',
            sortOrder: 1,
          ),
          ServiceEntity(
            title: 'Mobile App Deployment',
            description:
                'Store-ready builds for App Store, Google Play, and Huawei AppGallery.',
            sortOrder: 2,
          ),
          ServiceEntity(
            title: 'Refactor & Optimisation',
            description:
                'Performance tuning, clean architecture, and maintainable codebases.',
            sortOrder: 3,
          ),
          ServiceEntity(
            title: 'Reskin & Redesign',
            description:
                'UI refreshes that preserve brand identity while improving usability.',
            sortOrder: 4,
          ),
        ],
        skillCategories: skillCategories,
        experiences: experiences,
        projects: projects,
      );

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
          period: '5+ Years',
          context:
              'Cross-platform mobile apps · App Store · Google Play · Huawei AppGallery',
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
        const ProjectEntity(
          id: 'taggz',
          title: 'Taggz',
          shortDescription:
              'An iOS and Android social tagging app with real-time discovery, profile flows, and polished cross-platform UI.',
          fullDescription:
              'Taggz is a cross-platform mobile application focused on social tagging and discovery. I built responsive screens, integrated REST APIs, and implemented real-time interactions with a clean Cubit-based architecture. The app supports smooth onboarding, profile management, and store-ready deployment.',
          imageUrl: '',
          imageKey: 'taggz',
          techStack: ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: [
            'Cross-platform iOS and Android experience',
            'Real-time social tagging and discovery flows',
            'Responsive UI with performance-focused architecture',
          ],
          role: 'Flutter Developer',
        ),
        const ProjectEntity(
          id: 'iconcierge',
          title: 'iConcierge',
          shortDescription:
              'An iOS and Android concierge platform with service booking, notifications, and localized user journeys.',
          fullDescription:
              'iConcierge connects users with concierge services through a streamlined mobile experience. I implemented booking flows, Firebase-backed notifications, and bilingual support while keeping the interface intuitive and brand-consistent across devices.',
          imageUrl: '',
          imageKey: 'iconcierge',
          techStack: ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: [
            'Service booking and request management',
            'Push notifications and backend integration',
            'Arabic and English localization support',
          ],
          role: 'Flutter Developer',
        ),
        const ProjectEntity(
          id: 'wepick',
          title: 'Wepick',
          shortDescription:
              'An iOS and Android selection platform with curated content, dynamic lists, and engaging mobile interactions.',
          fullDescription:
              'Wepick helps users browse and select curated content through a fast, responsive mobile interface. I focused on list performance, API-driven content rendering, and reusable UI components that scale across product iterations.',
          imageUrl: '',
          imageKey: 'wepick',
          techStack: ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: [
            'Curated content browsing and selection',
            'Optimized list rendering and API integration',
            'Modular UI components for rapid iteration',
          ],
          role: 'Flutter Developer',
        ),
        const ProjectEntity(
          id: 'all-traders',
          title: 'All Traders',
          shortDescription:
              'An iOS and Android trading companion app with market views, account flows, and secure data handling.',
          fullDescription:
              'All Traders delivers market insights and account management in a mobile-first experience. I implemented secure API communication, responsive dashboards, and performance tuning for data-heavy screens used throughout the trading journey.',
          imageUrl: '',
          imageKey: 'alltraders',
          techStack: ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Cubit'],
          features: [
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
}
