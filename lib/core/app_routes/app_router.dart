import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart' show Routes;
import 'package:portfolio/features/contact/presentation/contact_screen/ui/widgets/contact_body.dart';
import 'package:portfolio/features/experience/presentation/experience_screen/ui/widgets/experience_body.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/portfolio_body.dart';
import 'package:portfolio/features/services/presentation/services_screen/ui/widgets/services_body.dart';
import 'package:portfolio/features/skills/presentation/skills_screen/ui/widgets/skills_body.dart';

import '../../features/about/presentation/about_screen/ui/widgets/about_body.dart' show AboutBody;

class AppRouter {
  static List<GoRoute> get generateRoute {
    return [

      GoRoute(path: Routes.aboutScreen, builder: (context, state) => const AboutBody()),
      GoRoute(path: Routes.contactScreen, builder: (context, state) => const ContactBody()),
      GoRoute(path: Routes.experienceScreen, builder: (context, state) => const ExperienceBody()),
      GoRoute(path: Routes.portfolioScreen, builder: (context, state) => const PortfolioBody(),),
      GoRoute(path: Routes.servicesScreen, builder: (context, state) => const ServicesBody()),
      GoRoute(path: Routes.skillsScreen, builder: (context, state) => const SkillsBody()),
    ];
  }
}
