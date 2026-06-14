import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitionPage<T> extends CustomTransitionPage<T> {
  AppTransitionPage({
    required super.child,
    super.key,
    LocalKey? pageKey,
  }) : super(
          transitionDuration: const Duration(milliseconds: 375),
          reverseTransitionDuration: const Duration(milliseconds: 375),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
        );
}

GoRoute buildTransitionRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => AppTransitionPage(
      key: state.pageKey,
      child: builder(context, state),
    ),
    routes: routes,
  );
}
