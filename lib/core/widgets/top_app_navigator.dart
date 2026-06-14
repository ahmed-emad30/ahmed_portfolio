import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/core/utils/app_constants.dart';
import 'package:portfolio/core/utils/responsive_values.dart';
import 'package:portfolio/core/widgets/app_navigator_item.dart';

class TopAppNavigator extends StatelessWidget {
  const TopAppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const SizedBox.shrink();
    }

    final navItems = List.generate(
      AppConstants.items.length,
      (index) => AppNavigatorItem(item: AppConstants.items[index]),
    );

    if (context.isTablet) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 20.w,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: navItems,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 35.w,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: navItems,
      ),
    );
  }
}
