import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/app_routes/curtain_split.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';

const Duration _curtainDuration = Duration(milliseconds: 700);
const Duration _sectionDuration = Duration(milliseconds: 550);

/// Home route: opens like a curtain when leaving, closes when returning.
class CurtainHomeTransitionPage<T> extends CustomTransitionPage<T> {
  CurtainHomeTransitionPage({
    required super.child,
    super.key,
  }) : super(
          opaque: false,
          transitionDuration: _curtainDuration,
          reverseTransitionDuration: _curtainDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AnimatedBuilder(
              animation: Listenable.merge([animation, secondaryAnimation]),
              child: child,
              builder: (context, child) {
                final openProgress = math.max(
                  Curves.easeInOutCubic.transform(secondaryAnimation.value),
                  1.0 - Curves.easeInOutCubic.transform(animation.value),
                );

                return CurtainSplit(
                  progress: openProgress.clamp(0.0, 1.0),
                  child: child!,
                );
              },
            );
          },
        );
}

/// Content revealed through the curtain opening (used with Home).
class CurtainContentTransitionPage<T> extends CustomTransitionPage<T> {
  CurtainContentTransitionPage({
    required super.child,
    super.key,
  }) : super(
          transitionDuration: _curtainDuration,
          reverseTransitionDuration: _curtainDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
              reverseCurve: Curves.easeInOutCubic,
            );

            return AnimatedBuilder(
              animation: curved,
              child: child,
              builder: (context, child) {
                return ClipPath(
                  clipper: _CurtainRevealClipper(curved.value),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.85, end: 1).animate(curved),
                    child: child,
                  ),
                );
              },
            );
          },
        );
}

class _CurtainRevealClipper extends CustomClipper<Path> {
  _CurtainRevealClipper(this.progress);

  final double progress;

  @override
  Path getClip(Size size) {
    final t = progress.clamp(0.0, 1.0);
    final revealWidth = size.width * t;
    final left = (size.width - revealWidth) * 0.5;
    return Path()..addRect(Rect.fromLTWH(left, 0, revealWidth, size.height));
  }

  @override
  bool shouldReclip(covariant _CurtainRevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}

/// Vertical slide between non-home sections.
class VerticalScrollTransitionPage<T> extends CustomTransitionPage<T> {
  VerticalScrollTransitionPage({
    required super.child,
    super.key,
    this.goingDown = true,
  }) : super(
          transitionDuration: _sectionDuration,
          reverseTransitionDuration: _sectionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final down = goingDown;
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

  final bool goingDown;
}

/// Picks curtain (Home involved) or vertical scroll (section ↔ section).
Page<void> buildSectionPage({
  required LocalKey key,
  required Widget child,
}) {
  if (SectionNavigation.currentInvolvesHome) {
    return CurtainContentTransitionPage(key: key, child: child);
  }
  return VerticalScrollTransitionPage(
    key: key,
    goingDown: SectionNavigation.goingDown,
    child: child,
  );
}

class AppTransitionPage<T> extends CurtainContentTransitionPage<T> {
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
    pageBuilder: (context, state) => CurtainContentTransitionPage(
      key: state.pageKey,
      child: builder(context, state),
    ),
    routes: routes,
  );
}
