import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/core/utils/app_methods.dart';

import '../../../../../../gen/assets.gen.dart' show Assets, SvgGenImage;

class ServicesBody extends StatelessWidget {
  const ServicesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding:  REdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(title: 'Mobile App Development', description: '''lorem ibsum lorem ibsum lorem ibsum lorem ibsum lorem ibsumlorem ibsum lorem ibsum lorem ibsum lorem ibsum''',),
                  FeatureCard(title: 'Mobile App Development', description: '''lorem ibsum lorem ibsum lorem ibsum lorem ibsum lorem ibsumlorem ibsum lorem ibsum lorem ibsum lorem ibsum''',),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _Branching(icon: Assets.images.svg.topLeft),
                        // 4.verticalSpace,
                        _Branching(icon: Assets.images.svg.bottomLeft)

                      ],
                    ),
                    Text('Services',style: AppTextStyle.style128ExtraBold.copyWith(color: AppColors.primary),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _Branching(icon: Assets.images.svg.topRight),

                        // 4.verticalSpace,
                        _Branching(icon:  Assets.images.svg.bottomRight),

                      ],
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(title: 'Mobile App Development', description: '''lorem ibsum lorem ibsum lorem ibsum lorem ibsum lorem ibsumlorem ibsum lorem ibsum lorem ibsum lorem ibsum''',),
                  FeatureCard(title: 'Mobile App Development', description: '''lorem ibsum lorem ibsum lorem ibsum lorem ibsum lorem ibsumlorem ibsum lorem ibsum lorem ibsum lorem ibsum''',),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding:  REdgeInsetsDirectional.only(start: 40),
          child: Assets.images.photos.anglePhone.image(
                 /*   height: 1.2.sh,
            fit: BoxFit.cover*/
          ),
        ),
        Text('Services',style: AppTextStyle.style128ExtraBold.copyWith(foreground: AppMethods.textStroke(color: AppColors.primary,strokeWidth: 2),),)

      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key, required this.title, required this.description,
  });
final String title ;
final String description ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.27.sw,
      padding: REdgeInsets.symmetric(
        horizontal: 24,
        vertical: 38,
      ),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.3*255),
            offset: const Offset(0, 2),
            blurRadius: 22,
            spreadRadius: 0,
          )
        ]
      ),
      child: Column(
        spacing: 8.h,

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: AppTextStyle.style16ExtraBold.copyWith(
            color: AppColors.primary,
            height: 1,
            letterSpacing: 0,
          ),),
          Text(description,textAlign: TextAlign.justify,
              maxLines: 3,style: AppTextStyle.style16Medium.copyWith(
            color: AppColors.secondary,
            height: 1,
            letterSpacing: 0,
          )),
        ],
      ),
    );
  }
}
class _Branching extends StatelessWidget {
  const _Branching({super.key, required this.icon});
final SvgGenImage icon ;
  @override
  Widget build(BuildContext context) {
    return  Expanded(child: icon.svg());
  }
}
