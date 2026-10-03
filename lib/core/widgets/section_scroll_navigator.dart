import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';

/// When the user scrolls past the vertical edge of a section, navigate to the
/// next/previous section with the vertical scroll transition.
class SectionScrollNavigator extends StatefulWidget {
  const SectionScrollNavigator({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  final Widget child;
  final String currentRoute;

  @override
  State<SectionScrollNavigator> createState() => _SectionScrollNavigatorState();
}

class _SectionScrollNavigatorState extends State<SectionScrollNavigator> {
  static const _cooldown = Duration(milliseconds: 900);
  static const _edgeEpsilon = 1.0;
  static const _overscrollThreshold = 48.0;

  DateTime? _lastNavigation;
  double _edgeAccumulated = 0;
  bool _scrolledSinceSignal = false;

  bool get _enabled =>
      SectionNavigation.isScrollableSection(widget.currentRoute);

  @override
  void didUpdateWidget(covariant SectionScrollNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentRoute != widget.currentRoute) {
      _edgeAccumulated = 0;
    }
  }

  void _tryNavigate(int direction) {
    if (!_enabled) return;
    if (_lastNavigation != null &&
        DateTime.now().difference(_lastNavigation!) < _cooldown) {
      return;
    }

    final target =
        SectionNavigation.neighbor(widget.currentRoute, direction);
    if (target == null) return;

    _lastNavigation = DateTime.now();
    _edgeAccumulated = 0;
    SectionNavigation.go(context, target);
  }

  void _accumulate(double amount, int direction) {
    if (amount <= 0) return;
    _edgeAccumulated += amount;
    if (_edgeAccumulated >= _overscrollThreshold) {
      _tryNavigate(direction);
    }
  }

  bool _onScroll(ScrollNotification notification) {
    if (!_enabled) return false;
    if (notification.metrics.axis != Axis.vertical) return false;

    final metrics = notification.metrics;
    final atTop = metrics.pixels <= metrics.minScrollExtent + _edgeEpsilon;
    final atBottom = metrics.pixels >= metrics.maxScrollExtent - _edgeEpsilon;

    if (notification is ScrollUpdateNotification) {
      _scrolledSinceSignal = true;
      final delta = notification.scrollDelta ?? 0;
      if (delta > 0 && atBottom) {
        _accumulate(delta, 1);
      } else if (delta < 0 && atTop) {
        _accumulate(-delta, -1);
      } else if (!atTop && !atBottom) {
        _edgeAccumulated = 0;
      }
    } else if (notification is OverscrollNotification) {
      if (notification.overscroll > 0) {
        _accumulate(notification.overscroll, 1);
      } else if (notification.overscroll < 0) {
        _accumulate(-notification.overscroll, -1);
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: Listener(
        onPointerSignal: (event) {
          if (!_enabled) return;
          if (event is! PointerScrollEvent) return;

          final dy = event.scrollDelta.dy;
          if (dy == 0) return;

          // The Scrollable handles this same wheel event synchronously. Only
          // chain sections if it could not move the content (already at that
          // edge, or nothing to scroll). Reading cached edge flags here made
          // the first wheel tick on a freshly opened section skip it.
          _scrolledSinceSignal = false;
          scheduleMicrotask(() {
            if (!mounted || _scrolledSinceSignal) return;
            _accumulate(dy.abs(), dy > 0 ? 1 : -1);
          });
        },
        child: widget.child,
      ),
    );
  }
}
