

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_themes/theme_logic/theme_cubit.dart';
import '../../gen/assets.gen.dart' show $AssetsImagesSvgGen;

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsetsDirectional.only(end: 60.w),
          padding: EdgeInsetsDirectional.only(top: 20.h),
          height: 0.1.sh,
          alignment: AlignmentDirectional.topEnd,
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: () => context.read<ThemeCubit>().toggleTheme(),
              child: state.isDark
                  ? $AssetsImagesSvgGen().darkMode.svg(
                      width: 35.r,
                      height: 35.r,
                    )
                  : $AssetsImagesSvgGen().lightMode.svg(
                      width: 35.r,
                      height: 35.r,
                    ),
            ),
          ),
        );
      },
    );
  }
}
