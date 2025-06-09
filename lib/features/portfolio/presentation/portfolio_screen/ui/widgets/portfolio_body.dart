import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:dotted_border/dotted_border.dart' show BorderType, DottedBorder;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';

import '../../../../../../core/app_themes/colors/app_colors.dart'
    show AppColors;
import '../../../../../../gen/assets.gen.dart' show Assets;

class PortfolioBody extends StatelessWidget {
  const PortfolioBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      padding: EdgeInsets.only(top: 50.h),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    NavigationIconButton(
                      icon: Assets.images.svg.leftArrow.svg(),
                      onTap: () {},
                    ),

                    Expanded(
                      child: Text(
                        'TAGGZ',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.style230ExtraBold.copyWith(
                          color: AppColors.primary,
                          height: 0.7,
                          // height: 40 / 230.spMin,
                          letterSpacing: -2,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                    NavigationIconButton(
                      icon: Assets.images.svg.rightArrow.svg(),
                      onTap: () {},
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      // optional overlay
                      width: 290.w,
                      height: 80.h,
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.rotationZ(13.24 * math.pi / 180),
                      transformAlignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.h),

                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 78
                            )
                          ]
                      ),


                    ),

                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          // padding:EdgeInsets.zero,
                          padding: EdgeInsets.only(left: 0.16.sw),
                          child: Assets.images.photos.portfolio1.image(
                            height: 0.65.sh,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50.h, left: 30.w),
                          child: Assets.images.photos.portfolio2.image(
                            height: 0.56.sh,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                Text(
                  'TAGGZ',
                  textAlign: TextAlign.center,

                  style: AppTextStyle.style230ExtraBold.copyWith(
                    // color: AppColors.secondary,
                    height: 40 / 230.spMin,
                    letterSpacing: -2,
                    textBaseline: TextBaseline.alphabetic,
                    foreground: AppMethods.textStroke(
                      color: AppColors.primary,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: REdgeInsets.only(bottom: 32),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(10.r),
              padding: REdgeInsets.symmetric(vertical: 20, horizontal: 16),
              color: AppColors.black,
              strokeWidth: 1,
              dashPattern: const [10, 3, 10, 3],

              child: Text(
                'Explore All Projects',
                style: AppTextStyle.style24Medium.copyWith(
                  color: AppColors.textMediumColor,
                  height: 40 / 24.spMin, // Line height: 40px ÷ 24px
                  letterSpacing: -0.02 * 24.spMin,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationIconButton extends StatelessWidget {
  const NavigationIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 75.dm,
          height: 75.dm,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.containerBackground,
          ),
          child: icon,
        ),
      ),
    );
  }
}
