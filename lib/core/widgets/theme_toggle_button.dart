

import 'package:flutter/material.dart' show Align, AlignmentDirectional, BuildContext, EdgeInsetsDirectional, GestureDetector, StatelessWidget, Widget;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart' show $AssetsImagesSvgGen;

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 60.w),
      padding: EdgeInsetsDirectional.only(top: 20.h),
      height: 0.1.sh,
      alignment: AlignmentDirectional.topEnd,
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        // alignment: AlignmentDirectional.centerEnd,
        child: GestureDetector(
          onTap: () {},
          child: $AssetsImagesSvgGen().lightMode.svg(
            width: 35.r,
            height: 35.r,
          ),
        ),
      ),
    );
  }
}
