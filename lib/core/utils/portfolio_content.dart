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
          title: 'State Management',
          skills: [
            SkillEntity(name: 'BLoC (Cubit)', proficiency: 95, color: AppColors.greenProgress),
            SkillEntity(name: 'Provider', proficiency: 90, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Riverpod', proficiency: 90, color: AppColors.yellowProgress),
            SkillEntity(name: 'GetX', proficiency: 85, color: AppColors.redProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Backend Integration',
          skills: [
            SkillEntity(name: 'RESTful APIs', proficiency: 95, color: AppColors.yellowProgress),
            SkillEntity(name: 'Dio', proficiency: 95, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'HTTP', proficiency: 90, color: AppColors.greenProgress),
            SkillEntity(name: 'JSON Serialization', proficiency: 90, color: AppColors.redProgress),
            SkillEntity(name: 'WebSockets', proficiency: 85, color: AppColors.yellowProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Firebase',
          skills: [
            SkillEntity(name: 'Authentication', proficiency: 95, color: AppColors.greenProgress),
            SkillEntity(name: 'Cloud Firestore', proficiency: 90, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Cloud Messaging (FCM)', proficiency: 90, color: AppColors.yellowProgress),
            SkillEntity(name: 'Crashlytics', proficiency: 85, color: AppColors.redProgress),
            SkillEntity(name: 'Analytics', proficiency: 85, color: AppColors.greenProgress),
            SkillEntity(name: 'Firebase hosting', proficiency: 85, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Firebase Database (real time database)', proficiency: 85, color: AppColors.yellowProgress),
            SkillEntity(name: 'Firebase Dynamics', proficiency: 80, color: AppColors.redProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Local Storage',
          skills: [
            SkillEntity(name: 'Hive', proficiency: 95, color: AppColors.greenProgress),
            SkillEntity(name: 'SharedPreferences', proficiency: 95, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Secure Storage', proficiency: 90, color: AppColors.yellowProgress),
            SkillEntity(name: 'SQLite', proficiency: 85, color: AppColors.redProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'CI/CD & DevOps',
          skills: [
            SkillEntity(name: 'GitHub Actions', proficiency: 90, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Codemagic', proficiency: 90, color: AppColors.greenProgress),
            SkillEntity(name: 'Shorebird', proficiency: 85, color: AppColors.yellowProgress),
            SkillEntity(name: 'Fastlane', proficiency: 85, color: AppColors.redProgress),
            SkillEntity(name: 'Flutter Flavors', proficiency: 90, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'App Distribution', proficiency: 85, color: AppColors.greenProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Publishing',
          skills: [
            SkillEntity(name: 'Google Play Console', proficiency: 95, color: AppColors.greenProgress),
            SkillEntity(name: 'Apple App Store Connect', proficiency: 90, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Huawei AppGallery', proficiency: 90, color: AppColors.yellowProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Testing & Debugging',
          skills: [
            SkillEntity(name: 'Unit Testing', proficiency: 85, color: AppColors.greenProgress),
            SkillEntity(name: 'Widget Testing', proficiency: 85, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Integration Testing', proficiency: 80, color: AppColors.yellowProgress),
            SkillEntity(name: 'E2E testing', proficiency: 80, color: AppColors.redProgress),
            SkillEntity(name: 'Performance Optimization', proficiency: 85, color: AppColors.greenProgress),
            SkillEntity(name: 'Memory Leak Analysis', proficiency: 80, color: AppColors.lightBlueProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Tools',
          skills: [
            SkillEntity(name: 'Git', proficiency: 95, color: AppColors.greenProgress),
            SkillEntity(name: 'Android Studio', proficiency: 95, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Xcode', proficiency: 90, color: AppColors.yellowProgress),
            SkillEntity(name: 'VS Code', proficiency: 95, color: AppColors.redProgress),
            SkillEntity(name: 'Postman', proficiency: 90, color: AppColors.greenProgress),
            SkillEntity(name: 'Figma', proficiency: 85, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Jira', proficiency: 85, color: AppColors.yellowProgress),
            SkillEntity(name: 'Firebase Console', proficiency: 90, color: AppColors.redProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Automation & Scripting',
          skills: [
            SkillEntity(name: 'Bash', proficiency: 85, color: AppColors.greenProgress),
            SkillEntity(name: 'Dart Scripts', proficiency: 90, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Build Automation', proficiency: 85, color: AppColors.yellowProgress),
            SkillEntity(name: 'Rebranding Automation', proficiency: 85, color: AppColors.redProgress),
            SkillEntity(name: 'Codemagic', proficiency: 90, color: AppColors.greenProgress),
            SkillEntity(name: 'Fastlane', proficiency: 85, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'CI/CD', proficiency: 90, color: AppColors.yellowProgress),
          ],
        ),
        SkillCategoryEntity(
          title: 'Development Practices',
          skills: [
            SkillEntity(name: 'Agile (Scrum)', proficiency: 95, color: AppColors.greenProgress),
            SkillEntity(name: 'Code Review', proficiency: 95, color: AppColors.lightBlueProgress),
            SkillEntity(name: 'Technical Documentation', proficiency: 90, color: AppColors.yellowProgress),
            SkillEntity(name: 'SDLC', proficiency: 90, color: AppColors.redProgress),
          ],
        ),
      ];

  static List<ExperienceEntity> get experiences => [
        const ExperienceEntity(
          role: 'Senior Flutter Developer',
          company: 'Codebase',
          period: 'Aug 2025 – Present',
          context: 'Onsite · Mansoura',
          bullets: [
            'Led the Flutter team through technical guidance, code reviews, and coding standards.',
            'Profiled and refactored workout, video playback, and WebView flows to improve performance and maintainability.',
            'Built a CI/CD pipeline with Flutter Flavors to automate builds, deployments, and release workflows, streamlining QA and releases.',
            'Delivered New Home, New Workout Experience, and real-time chat features.',
            'Managed Google Play and Apple App Store releases and production deployments.',
            'Used Hive for local storage and caching in key app flows.',
            'Integrated Google Maps API where location features were required.',
          ],
          techTags: [
            'Flutter',
            'CI/CD',
            'Flavors',
            'Hive',
            'Google Maps',
            'WebView',
          ],
        ),
        const ExperienceEntity(
          role: 'Flutter Engineer',
          company: 'Artzone',
          period: 'Feb 2025 – Apr 2025',
          context: 'Remote',
          bullets: [
            'Added two Taggz features, contributing to a 26% increase in downloads after release.',
            'Integrated the PayMob payment gateway in Taggz for secure in-app transactions.',
            'Implemented Google Maps API for location-based functionality in Taggz.',
            'Used Hive for local storage and offline data handling in Taggz.',
            'Refactored and optimized the app to improve stability and performance.',
          ],
          techTags: ['Flutter', 'PayMob', 'Google Maps', 'Hive'],
        ),
        const ExperienceEntity(
          role: 'Flutter Engineer',
          company: 'Ultra Progress',
          period: 'Jan 2024 – Jan 2025',
          context: 'Remote',
          bullets: [
            'Built, extended, and refactored 10+ Flutter apps for client requirements using GetX and Provider to deliver stable, scalable solutions.',
            'Implemented PayTabs payment flows for iConcierge and other client projects.',
            'Integrated Pusher in iConcierge to support real-time messaging and notifications.',
            'Integrated Google Maps API in select client apps to support location-based features.',
            'Used Notion to organize requirements, documentation, and release handoff across projects.',
            'Managed app releases on Google Play, App Store, and Huawei AppGallery.',
          ],
          techTags: [
            'Flutter',
            'GetX',
            'Provider',
            'PayTabs',
            'Pusher',
            'Google Maps',
          ],
        ),
        const ExperienceEntity(
          role: 'Flutter Engineer',
          company: 'Creen',
          period: 'Jul 2021 – Dec 2023',
          context: 'Remote',
          bullets: [
            'Developed AllTraders independently, covering UI, business logic, and API integration.',
            'Enhanced Creen with new features, UI fixes, and MyFatoorah payment integration.',
            'Integrated Agora in Creen for real-time communication features.',
            'Ramped up quickly on new requirements through self-learning and delivered features independently.',
            'Contributed to positioning Creen among the top 3 social and super apps in Saudi Arabia.',
          ],
          techTags: ['Flutter', 'MyFatoorah', 'Agora'],
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
