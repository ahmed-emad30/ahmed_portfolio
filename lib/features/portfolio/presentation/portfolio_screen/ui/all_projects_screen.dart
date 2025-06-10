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
    return Padding(
      padding: REdgeInsets.only(top: 100),
      child: CustomScrollView(

        slivers: [
          SliverAppBar(
            floating: false,        // App bar won't reappear as soon as you scroll up
            pinned: false,           // App bar will remain visible at the top
            snap: false,
            centerTitle: false,
            toolbarHeight: 200.h,
            collapsedHeight: 200.h,
          expandedHeight: 300.h,
            backgroundColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            shadowColor: AppColors.transparent,
            // : AppColors.transparent,
            title: Column(
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

          ),

          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index)  => Container(
                  width: 1.sw,
                  height: 343.h,
                  margin: EdgeInsets.only(bottom: 50.h),
                  color: AppColors.red,
                  child: Text('index $index'),
                ),
              childCount: 10,
              ), itemExtent: 393.h,
            ),

        ],
      ),
    );
  }
}
