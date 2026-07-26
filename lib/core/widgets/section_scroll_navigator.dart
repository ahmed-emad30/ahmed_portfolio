import 'package:flutter/material.dart';
import 'package:portfolio/core/navigation/section_navigation.dart';

/// When the user scrolls past the vertical edge of a section, navigate to the
/// next/previous section (never to/from Home — that uses the curtain via nav).
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

  bool get _enabled =>
      SectionNavigation.isScrollableSection(widget.currentRoute);

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

  bool _onScroll(ScrollNotification notification) {
    if (!_enabled) return false;
    if (notification.metrics.axis != Axis.vertical) return false;

    if (notification is ScrollUpdateNotification) {
      final metrics = notification.metrics;
      final delta = notification.scrollDelta ?? 0;
      final atBottom = metrics.pixels >= metrics.maxScrollExtent - _edgeEpsilon;
      final atTop = metrics.pixels <= metrics.minScrollExtent + _edgeEpsilon;

      if (delta > 0 && atBottom) {
        _edgeAccumulated += delta;
        if (_edgeAccumulated >= _overscrollThreshold) {
          _tryNavigate(1);
        }
      } else if (delta < 0 && atTop) {
        _edgeAccumulated += -delta;
        if (_edgeAccumulated >= _overscrollThreshold) {
          _tryNavigate(-1);
        }
      } else if (!atTop && !atBottom) {
        _edgeAccumulated = 0;
      }
    } else if (notification is OverscrollNotification) {
      if (notification.overscroll > 0) {
        _edgeAccumulated += notification.overscroll;
        if (_edgeAccumulated >= _overscrollThreshold) {
          _tryNavigate(1);
        }
      } else if (notification.overscroll < 0) {
        _edgeAccumulated += -notification.overscroll;
        if (_edgeAccumulated >= _overscrollThreshold) {
          _tryNavigate(-1);
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: widget.child,
    );
  }
}
