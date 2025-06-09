import 'package:flutter/material.dart' show BuildContext, EdgeInsetsDirectional, GestureDetector, Padding, StatelessWidget, VoidCallback, Widget;

import '../../../../../../gen/assets.gen.dart' show SvgGenImage;

class ContactIcon extends StatelessWidget {
  const ContactIcon({super.key, required this.onTap, required this.child});

  final VoidCallback onTap;
  final SvgGenImage child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 7.0),
      child: GestureDetector(onTap: onTap, child: child.svg()),
    );
  }
}
