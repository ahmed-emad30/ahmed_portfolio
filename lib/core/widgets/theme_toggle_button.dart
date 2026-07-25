

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_themes/theme_logic/theme_cubit.dart';
import '../../gen/assets.gen.dart' show $AssetsImagesSvgGen;

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
    this.compact = false,
  });

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsetsDirectional.only(
            end: compact ? 8.w : 60.w,
          ),
          padding: EdgeInsetsDirectional.only(top: compact ? 0 : 20.h),
          alignment: AlignmentDirectional.topEnd,
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: () => context.read<ThemeCubit>().toggleTheme(),
              child: state.isDark
                  ? $AssetsImagesSvgGen().darkMode.svg(
                      width: compact ? 28.r : 35.r,
                      height: compact ? 28.r : 35.r,
                    )
                  : $AssetsImagesSvgGen().lightMode.svg(
                      width: compact ? 28.r : 35.r,
                      height: compact ? 28.r : 35.r,
                    ),
            ),
          ),
        );
      },
    );
  }
}
