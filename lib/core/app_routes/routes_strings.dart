sealed class Routes {

  static const String baseRoute = '/';
  static const String homeScreen = '${baseRoute}homeScreen';
  static const String aboutScreen = '${baseRoute}aboutScreen';
  static const String contactScreen = '${baseRoute}contactScreen';
  static const String experienceScreen = '${baseRoute}experienceScreen';
  static const String portfolioScreen = '${baseRoute}portfolioScreen';
  static const String servicesScreen = '${baseRoute}servicesScreen';
  static const String skillsScreen = '${baseRoute}skillsScreen';
  static const String allProjectsScreen = '$portfolioScreen/allProjectsScreen';
  static const String projectDetailsRoute =
      '$portfolioScreen/project/:projectId';

  static String projectDetailsPath(String projectId) =>
      '$portfolioScreen/project/$projectId';
}
