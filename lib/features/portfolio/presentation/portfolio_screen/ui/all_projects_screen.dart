import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Container,
        CrossAxisAlignment,
        CustomScrollView,
        EdgeInsets,
        SliverAppBar,
        SliverPadding,
        StatelessWidget,
        Text,
        Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/app_themes/colors/app_colors.dart';
import 'package:portfolio/core/app_themes/text_style/app_text_style.dart';
import 'package:portfolio/features/portfolio/presentation/portfolio_screen/ui/widgets/portfolio_body.dart';

class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return  Padding(
            padding:  REdgeInsets.only(top: 120.h,bottom: 80.h),
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
        return Container(
          width: 1.sw,
          height: 343.h,
          margin: EdgeInsets.only(bottom: 50.h),
          color: AppColors.red,
          child: Text('index $index'),
        );
      },
    );
  }
}

