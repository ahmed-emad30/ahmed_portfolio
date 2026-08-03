import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/portfolio_theme_extension.dart';
import 'package:portfolio/gen/assets.gen.dart';

class PortfolioScaffoldBackground extends StatelessWidget {
  const PortfolioScaffoldBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.portfolioTheme;

    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            theme.scaffoldGradientStart,
            theme.scaffoldGradientEnd,
          ],
        ),
        image: DecorationImage(
          image: Assets.images.photos.texture.provider(),
          fit: BoxFit.cover,
         /* colorFilter: ColorFilter.mode(
            AppColorsTextureFilter.color(context),
            BlendMode.srcIn,
          ),*/
        ),
      ),
      child: child,
    );
  }
}

class AppColorsTextureFilter {
  static Color color(BuildContext context) {
    final theme = context.portfolioTheme;
    return Color.fromRGBO(99, 99, 99, theme.textureOpacity);
  }
}
