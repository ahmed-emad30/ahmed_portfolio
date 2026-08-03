import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';

const Duration _sectionDuration = Duration(milliseconds: 550);

/// Vertical slide used for every screen transition.
class VerticalScrollTransitionPage<T> extends CustomTransitionPage<T> {
  VerticalScrollTransitionPage({
    required super.child,
    super.key,
  }) : super(
          transitionDuration: _sectionDuration,
          reverseTransitionDuration: _sectionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final down = SectionNavigation.goingDown;
            final enterTween = Tween<Offset>(
              begin: Offset(0, down ? 1 : -1),
              end: Offset.zero,
            );
            final exitTween = Tween<Offset>(
              begin: Offset.zero,
              end: Offset(0, down ? -1 : 1),
            );

            final curvedIn = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
              reverseCurve: Curves.easeInOutCubic,
            );
            final curvedOut = CurvedAnimation(
              parent: secondaryAnimation,
              curve: Curves.easeInOutCubic,
            );

            return SlideTransition(
              position: exitTween.animate(curvedOut),
              child: SlideTransition(
                position: enterTween.animate(curvedIn),
                child: child,
              ),
            );
          },
        );
}

Page<void> buildSectionPage({
  required LocalKey key,
  required Widget child,
}) {
  return VerticalScrollTransitionPage(
    key: key,
    child: child,
  );
}

class AppTransitionPage<T> extends VerticalScrollTransitionPage<T> {
  AppTransitionPage({
    required super.child,
    super.key,
  });
}

GoRoute buildTransitionRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => VerticalScrollTransitionPage(
      key: state.pageKey,
      child: builder(context, state),
    ),
    routes: routes,
  );
}
