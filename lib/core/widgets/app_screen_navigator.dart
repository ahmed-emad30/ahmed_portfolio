import 'dart:developer' show log;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, Scaffold, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_routes/routes_strings.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';

import '../../gen/assets.gen.dart' show $AssetsImagesPhotosGen, Assets;
import '../app_themes/colors/app_colors.dart' show AppColors;

class AppScreenNavigator extends StatelessWidget {
  const AppScreenNavigator({super.key,  required this.path, required this.sliver});
final String? path;
final Widget sliver;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body: path == Routes.aboutScreen?Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          buildContainer(),
          Assets.images.photos.sideProfile.image(
            fit: BoxFit.cover,
            height: 1.sh,
          )
        ],
      ):buildContainer(),


    );
  }

  Container buildContainer() {
    return Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          decoration: BoxDecoration(
            image: DecorationImage(image: $AssetsImagesPhotosGen().texture.provider(),
            fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                AppColors.secondary.withValues(alpha: 255*0.4),
                BlendMode.srcIn,
              )
            )
          ),
          child: CustomScrollView(
            slivers: [
              CustomAppBar(),
              SliverFillRemaining(
                child: sliver,
              )
              // sliver
            ],
          ),
        );
  }
}