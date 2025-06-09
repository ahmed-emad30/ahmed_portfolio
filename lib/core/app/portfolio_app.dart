import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/app_router.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/widgets/app_screen_navigator.dart';

import '../../features/home/presentation/home_screen/ui/home_screen.dart' show HomeScreen;
import '../app_themes/themes/app_light_theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 843),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: Routes.portfolioScreen,
            routes: [
              GoRoute(path: Routes.homeScreen, builder: (context, state) => const HomeScreen()),

              ShellRoute(
                builder: (context, state, child) {

                  return AppScreenNavigator(path: state.path, child: child,
                );
                },
                routes: AppRouter.generateRoute)],
          ),
          debugShowCheckedModeBanner: false,
          title: 'Ahmed Emad Portfolio',
          theme: AppLightThemes.call(),
          themeMode: ThemeMode.light,

          // initialRoute: Routes.auth,

          /*   locale: cubit.locale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate
          ],
          localeResolutionCallback: (locale, supportedLocales) => cubit
              .getLocaleResolutionCallback(locale, supportedLocales),*/
        );
      },
    );
  }
}
