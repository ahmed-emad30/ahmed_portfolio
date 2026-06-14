import 'package:flutter/material.dart';

class HoverInteraction extends StatefulWidget {
  const HoverInteraction({
    super.key,
    required this.onTap,
    required this.child,
    this.hoverScale = 1.0,
  });

  final VoidCallback? onTap;
  final Widget child;
  final double hoverScale;

  @override
  State<HoverInteraction> createState() => _HoverInteractionState();
}

class _HoverInteractionState extends State<HoverInteraction> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? widget.hoverScale : 1,
          duration: const Duration(milliseconds: 200),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _hovering ? 0.85 : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
