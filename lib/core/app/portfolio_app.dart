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
import 'package:portfolio/core/utils/screen_size_utils.dart';
import 'package:portfolio/core/utils/service_locator.dart';
import 'package:portfolio/features/contact/presentation/contact_screen/logic/contact_cubit.dart';
import 'package:portfolio/features/home/presentation/home_screen/ui/home_screen.dart'
    show HomeScreen;
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/all_projects_screen.dart'
    show AllProjectsScreen;
import 'package:portfolio/features/portfolio/presentation/project_details/ui/project_details_screen.dart'
    show ProjectDetailsScreen;
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => sl<PortfolioContentCubit>()..load(),
        ),
        BlocProvider(create: (_) => sl<ContactCubit>()),
      ],
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
          pageBuilder: (context, state) => buildSectionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: Routes.allProjectsScreen,
          pageBuilder: (context, state) => buildSectionPage(
            key: state.pageKey,
            child: const AllProjectsScreen(),
          ),
        ),
        GoRoute(
          path: Routes.projectDetailsRoute,
          pageBuilder: (context, state) => buildSectionPage(
            key: state.pageKey,
            child: ProjectDetailsScreen(
              projectId: state.pathParameters['projectId']!,
            ),
          ),
        ),
        ...AppRouter.sectionRoutes,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final view = View.of(context);
        final fallbackWidth =
            view.physicalSize.width / view.devicePixelRatio;
        final width =
            constraints.maxWidth > 0 ? constraints.maxWidth : fallbackWidth;
        final designSize = ScreenSizeUtils.designSizeForWidth(width);
        final sizeType = ScreenSizeUtils.getScreenSizeTypeFromWidth(width);

        return ScreenUtilInit(
          key: ValueKey(sizeType),
          designSize: designSize,
          ensureScreenSize: true,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return BlocBuilder<PortfolioContentCubit, PortfolioContentState>(
                  builder: (context, contentState) {
                    if (contentState is PortfolioContentLoading) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: AppLightThemes.call(),
                        darkTheme: AppDarkThemes.call(),
                        themeMode:
                            state.isDark ? ThemeMode.dark : ThemeMode.light,
                        home: const Scaffold(
                          body: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }

                    return MaterialApp.router(
                      routerConfig: _router,
                      debugShowCheckedModeBanner: false,
                      title: 'Ahmed Emad Portfolio',
                      theme: AppLightThemes.call(),
                      darkTheme: AppDarkThemes.call(),
                      themeMode:
                          state.isDark ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
