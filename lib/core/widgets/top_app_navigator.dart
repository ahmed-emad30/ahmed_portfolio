import 'package:flutter/material.dart' show BuildContext, CrossAxisAlignment, EdgeInsets, MainAxisSize, Padding, Row, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_constants.dart' show AppConstants;
import 'app_navigator_item.dart' show AppNavigatorItem;

class TopAppNavigator extends StatelessWidget {
  const TopAppNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding:  EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 35.w,
        crossAxisAlignment: CrossAxisAlignment.end,

        children:List.generate(AppConstants.items.length, (index) {
          // log('current route: ${GoRouter.of(context).state.fullPath}');
          // final isActive = GoRouter.of(context).state.name == AppConstants.items[index].route;
          return AppNavigatorItem(item: AppConstants.items[index],);
        },),
      ),
    );
  }
}
