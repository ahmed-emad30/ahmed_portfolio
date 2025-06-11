import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, SliverAppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/widgets/theme_toggle_button.dart' show ThemeToggleButton;
import 'package:portfolio/core/widgets/top_app_navigator.dart' show TopAppNavigator;

import '../../gen/assets.gen.dart' show $AssetsImagesPhotosGen;
import '../app_themes/colors/app_colors.dart' show AppColors;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: AppColors.scaffoldBackground,
      // backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      floating: true,
      pinned: false,
      snap: true,
      flexibleSpace: Container(
        height: 1.sh,
        alignment: Alignment.topCenter,

        decoration: BoxDecoration(
            image: DecorationImage(image: $AssetsImagesPhotosGen().texture.provider(),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.secondary.withValues(alpha: 255*0.4),
                  BlendMode.srcIn,
                )
            )
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopAppNavigator(),

            ThemeToggleButton(),

          ],
        ),
      ),
    );
  }
}



