import 'package:flutter/material.dart' show BorderRadius, BoxDecoration, BuildContext, Container, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_themes/colors/app_colors.dart' show AppColors;

class ActiveLine extends StatelessWidget {
  const ActiveLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      height: 5.r,
      margin: REdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }
}
