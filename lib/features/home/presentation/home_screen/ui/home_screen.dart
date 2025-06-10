import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/features/hero/presentation/hero_screen/ui/widgets/hero_body.dart';

import '../../../../../gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          $AssetsImagesPhotosGen().texture.image(
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
            color: AppColors.secondary.withValues(alpha: 255*0.4),
          ),
          // $AssetsImagesSvgGen().texture.svg(color: Colors.red),
          const HeroBody(),
        ],
      ),
    );
  }
}
