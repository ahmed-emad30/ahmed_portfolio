import 'package:flutter/material.dart';
import 'package:portfolio/features/hero/presentation/hero_screen/ui/widgets/hero_body.dart';

import '../../../../../core/widgets/main_widgets/app_scaffold.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Stack(
      alignment: Alignment.center,
      children: [
        // $AssetsImagesPhotosGen().texture.image(color: AppColors.primary),
        // $AssetsImagesSvgGen().texture.svg(colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),color: AppColors.primary),
        const HeroBody(),
      ],
    ));
  }
}