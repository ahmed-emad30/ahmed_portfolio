import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart' show SvgGenImage;

class ContactIcon extends StatelessWidget {
  const ContactIcon({
    super.key,
    required this.onTap,
    required this.child,
    required this.label,
  });

  final VoidCallback onTap;
  final SvgGenImage child;

  /// Screen reader label and hover tooltip, e.g. "GitHub".
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 7.0),
      child: Tooltip(
        message: label,
        child: Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(onTap: onTap, child: child.svg()),
          ),
        ),
      ),
    );
  }
}
