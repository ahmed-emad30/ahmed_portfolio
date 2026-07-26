import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/app_transition_page.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart' show Routes;
import 'package:portfolio/core/widgets/app_screen_navigator.dart';
import 'package:portfolio/features/about/presentation/about_screen/ui/widgets/about_body.dart';
import 'package:portfolio/features/contact/presentation/contact_screen/ui/widgets/contact_body.dart';
import 'package:portfolio/features/experience/presentation/experience_screen/ui/widgets/experience_body.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/portfolio_body.dart';
import 'package:portfolio/features/services/presentation/services_screen/ui/widgets/services_body.dart';
import 'package:portfolio/features/skills/presentation/skills_screen/ui/widgets/skills_body.dart';

class AppRouter {
  static List<GoRoute> get sectionRoutes {
    return [
      _sectionRoute(Routes.aboutScreen, const AboutBody()),
      _sectionRoute(Routes.contactScreen, const ContactBody()),
      _sectionRoute(Routes.experienceScreen, const ExperienceBody()),
      _sectionRoute(Routes.portfolioScreen, const PortfolioBody()),
      _sectionRoute(Routes.servicesScreen, const ServicesBody()),
      _sectionRoute(Routes.skillsScreen, const SkillsBody()),
    ];
  }

  static GoRoute _sectionRoute(String path, Widget body) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => buildSectionPage(
        key: state.pageKey,
        child: AppScreenNavigator(
          path: path,
          sliver: body,
        ),
      ),
    );
  }
}
