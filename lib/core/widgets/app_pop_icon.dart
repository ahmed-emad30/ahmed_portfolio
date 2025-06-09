import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/app_assets.dart';
import 'package:portfolio/core/utils/extensions.dart';
import 'package:portfolio/core/widgets/package_widgets/app_svg_image.dart';

class AppPopIcon extends StatelessWidget {
  const AppPopIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: Transform.rotate(
        angle: /*context.isArabic*/false ? 3.14 : 0,
        child: const AppSvgImage(path: AppAsset.arrowBackIcon),
      ),
    );
  }
}
