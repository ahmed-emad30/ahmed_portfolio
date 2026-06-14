
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/app_router.dart';
import 'package:portfolio/core/app_routes/app_transition_page.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/app_themes/theme_logic/theme_cubit.dart';
import 'package:portfolio/core/app_themes/themes/app_dark_theme.dart';
import 'package:portfolio/core/app_themes/themes/app_light_theme.dart';
import 'package:portfolio/core/widgets/app_screen_navigator.dart';
import 'package:portfolio/features/home/presentation/home_screen/ui/home_screen.dart'
    show HomeScreen;
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/all_projects_screen.dart'
    show AllProjectsScreen;
import 'package:portfolio/features/portfolio/presentation/project_details/ui/project_details_screen.dart'
    show ProjectDetailsScreen;

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const _PortfolioAppView(),
    );
  }
}

class _PortfolioAppView extends StatefulWidget {
  const _PortfolioAppView();

  @override
  State<_PortfolioAppView> createState() => _PortfolioAppViewState();
}

class _PortfolioAppViewState extends State<_PortfolioAppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: Routes.homeScreen,
      routes: [
        GoRoute(
          path: Routes.homeScreen,
          pageBuilder: (context, state) => AppTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: Routes.allProjectsScreen,
          pageBuilder: (context, state) => AppTransitionPage(
            key: state.pageKey,
            child: const AllProjectsScreen(),
          ),
        ),
        GoRoute(
          path: Routes.projectDetailsRoute,
          pageBuilder: (context, state) => AppTransitionPage(
            key: state.pageKey,
            child: ProjectDetailsScreen(
              projectId: state.pathParameters['projectId']!,
            ),
          ),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return AppScreenNavigator(
              path: state.matchedLocation,
              sliver: child,
            );
          },
          routes: AppRouter.generateRoute,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 843),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: _router,
              debugShowCheckedModeBanner: false,
              title: 'Ahmed Emad Portfolio',
              theme: AppLightThemes.call(),
              darkTheme: AppDarkThemes.call(),
              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            );
          },
        );
      },
    );
  }
}
