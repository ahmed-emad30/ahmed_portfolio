import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BoxFit,
        BoxShadow,
        BuildContext,
        Color,
        Column,
        Container,
        CrossAxisAlignment,
        DecorationImage,
        Expanded,
        MainAxisSize,
        Offset,
        Padding,
        Row,
        SliverList,
        StatelessWidget,
        Text,
        TextAlign,
        TextDirection,
        Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/portfolio_body.dart'
    show OutlineText;

import '../../../../../core/app_routes/routes_strings.dart' show Routes;
import '../../../../../core/app_themes/text_style/app_text_style.dart';
import '../../../../../core/widgets/app_screen_navigator.dart'
    show AppScreenNavigator;
import '../../../../../gen/assets.gen.dart'
    show $AssetsImagesPhotosGen, AssetGenImage, Assets;

class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectEntity(
        title: 'Taggz',
        description: '''An IOS and Android app for bla bla bla bla bla
bla bla bla bla bla bla bla blabla blabla bla bla bla bla bla bla bla
bla bla bla bla
bla bla bla bla ''',
        image: $AssetsImagesPhotosGen().taggz,
      ),
      ProjectEntity(
        title: 'iConcierge',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().iconcierge,
      ),
      ProjectEntity(
        title: 'Wepick',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().wepick,
      ),
      ProjectEntity(
        title: 'All Traders',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().alltraders,
      ),
      ProjectEntity(
        title: 'Taggz',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().taggz,
      ),
      ProjectEntity(
        title: 'iConcierge',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().iconcierge,
      ),
      ProjectEntity(
        title: 'Wepick',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().wepick,
      ),
      ProjectEntity(
        title: 'All Traders',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().alltraders,
      ),
      ProjectEntity(
        title: 'All Traders',
        description:
            '''An IOS and Android app for bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla''',
        image: $AssetsImagesPhotosGen().alltraders,
      ),
    ];
    return AppScreenNavigator(
      hasList: true,

      sliver: SliverList.builder(
        itemCount: projects.length > 8 ? 10 : projects.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ExploreNow();
          } else if (index == 9) {

            return Padding(
              padding: REdgeInsets.only(bottom: 48.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5.w,

                children: [
                  PageItem(title: 'Prev',),
                  PageItem(title: '1',onTap: (){},isActive: true,),
                  PageItem(title: '2',onTap: (){},),
                  PageItem(title: '3',onTap: (){},),
                  PageItem(title: '...',onTap: (){},),
                  PageItem(title: '10',onTap: (){},),
                  PageItem(title: 'Next',onTap: (){},),
                ],
              ),
            );
          }
          final project = projects[index - 1];

          return ProjectsItem(index: index, project: project);
        },
      ),
      path: Routes.allProjectsScreen,
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 60.h,
      // margin: REdgeInsets.only(top: 48.h),
      alignment: Alignment.center,
      color: AppColors.secondary,
      child: RichText(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text:
            'Ahmed Emad © 2025. Designed by ',
            style: AppTextStyle.style10Medium.copyWith(
              color: AppColors.whiteText,
              fontFamily: 'inter',
              height: 1.0, // 100% of fontSize
              letterSpacing: 0,
            ),
            children: [
              TextSpan(
                  text:
                  'AE Studio',
                  style: AppTextStyle.style10Medium.copyWith(
                    color: AppColors.primary,
                    fontFamily: 'inter',
                    height: 1.0, // 100% of fontSize
                    letterSpacing: 0,
                  ),
                  children: [
                    TextSpan(
                      text:
                      '. All Rights Reserved',
                      style: AppTextStyle.style10Medium.copyWith(
                        color: AppColors.whiteText,
                        fontFamily: 'inter',
                        height: 1.0, // 100% of fontSize
                        letterSpacing: 0,
                      ),

                    )
                  ]

              )
            ]

        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  const PageItem({
    super.key, required this.title,  this.isActive=false, this.onTap,
  });
final String title;
final bool isActive;
final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          minWidth: 32.dm,
          minHeight: 32.dm,
        ),
        decoration: BoxDecoration(
          color: isActive?AppColors.primary:AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
       child:  Text(title,style: AppTextStyle.style13Regular.copyWith(
         color: onTap==null?AppColors.pageText:isActive?AppColors.white:AppColors.primary
       ),)
      ),
    );
  }
}

class ProjectsItem extends StatelessWidget {
  const ProjectsItem({super.key, required this.index, required this.project});

  final int index;
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    final isOdd = index % 2 == 1;
    final has2Digits = index > 9;
    return Container(
      width: 1.sw,
      height: 343.4.h,
      margin: REdgeInsets.only(bottom: 80.h),
      // color: AppColors.primary,
      child: Row(
        textDirection: isOdd ? TextDirection.ltr : TextDirection.rtl,
        children: [
          ProjectCover(image: project.image),
          60.horizontalSpace,
          Expanded(
            child: Padding(
              padding: REdgeInsetsDirectional.only(top: 16, end: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${has2Digits ? index : '0$index'}',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.style48ExtraBold.copyWith(
                      height: 56 / 48.spMin,
                      // line-height ÷ font-size = 1.25
                      letterSpacing: -0.02 * 48.spMin,
                      // -2% of font size = -0.64
                      color: AppColors.primary,
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(vertical: 28),
                    child: Text(
                      '${project.title} Application',
                      textAlign: TextAlign.start,
                      style: AppTextStyle.style32Bold.copyWith(
                        height: 40 / 32.spMin,
                        // line-height ÷ font-size = 1.25
                        letterSpacing: -0.02 * 32.spMin,
                        // -2% of font size = -0.64
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      project.description,
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      style: AppTextStyle.style16Regular.copyWith(
                        height: 24 / 16.spMin,
                        // line-height ÷ font-size = 1.25
                        letterSpacing: -0.02 * 16.spMin,
                        // -2% of font size = -0.64
                        color: AppColors.zn400,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  DetailsButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'View full project details',
          style: AppTextStyle.style15Medium.copyWith(
            color: AppColors.primary,
            height: 56 / 15.spMin,
            // line-height ÷ font-size = 1.25
            letterSpacing: -0.02 * 15.spMin,
          ),
        ),
        8.horizontalSpace,
        Assets.images.svg.export.svg(),
      ],
    );
  }
}

class ProjectCover extends StatelessWidget {
  const ProjectCover({super.key, required this.image});

  final AssetGenImage image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 0.75 * 400.w,
      margin: REdgeInsetsDirectional.only(
        start: 10,
        top: 10,
        bottom: 10,
        end: 16,
      ),

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x00000040),
            blurRadius: 12.r,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(image: image.provider(), fit: BoxFit.contain),
      ),
    );
  }
}

class ExploreNow extends StatelessWidget {
  const ExploreNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 120.h, bottom: 80.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Explore Now!',
            style: AppTextStyle.style40ExtraBold.copyWith(
              color: AppColors.fillColor,
              height: 0.8,
              letterSpacing: 0,
            ),
          ),
          OutlineText(
            text: 'Projects',
            strokeWidth: 2,
            fontSize: 96.spMin,
            // height: 0.8,
            // letterSpacing: 0,
          ),
        ],
      ),
    );
  }
}

class ProjectEntity {
  final String title;
  final String description;
  final AssetGenImage image;

  ProjectEntity({
    required this.title,
    required this.description,
    required this.image,
  });
}
