import 'package:flutter/material.dart';

class LocaleDirectionHandler extends StatelessWidget {
  const LocaleDirectionHandler({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: /*context.isArabic*/false ? (Matrix4.identity()..scale(-1.0, 1.0)) : Matrix4.identity(),
      child: child,
    );
  }
}
