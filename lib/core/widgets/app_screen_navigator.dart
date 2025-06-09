import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, Scaffold, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/widgets/custom_app_bar.dart';

import '../../gen/assets.gen.dart' show $AssetsImagesPhotosGen;
import '../app_themes/colors/app_colors.dart' show AppColors;

class AppScreenNavigator extends StatelessWidget {
  const AppScreenNavigator({super.key,  required this.path, required this.child});
final String? path;
final Widget child;
  @override
  Widget build(BuildContext context) {
// log('path: $path');
    return  Scaffold(


      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: $AssetsImagesPhotosGen().texture.image(
              // width: 1.sw,
              // height: 1.sh,
              fit: BoxFit.cover,
              color: AppColors.secondary.withValues(alpha: 255*0.4),
            ),
          ),
          // $AssetsImagesSvgGen().texture.svg(color: Colors.red),
          child,
          CustomAppBar()
        ],
      ),


    );
  }
}
