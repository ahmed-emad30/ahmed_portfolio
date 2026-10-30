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
        final tooltip =
            state.isDark ? 'Switch to light theme' : 'Switch to dark theme';
        final icon = state.isDark
            ? $AssetsImagesSvgGen().darkMode.svg(
                width: compact ? 22.r : 28.r,
                height: compact ? 22.r : 28.r,
              )
            : $AssetsImagesSvgGen().lightMode.svg(
                width: compact ? 22.r : 28.r,
                height: compact ? 22.r : 28.r,
              );

        if (compact) {
          return IconButton(
            tooltip: tooltip,
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: icon,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
          );
        }

        return IconButton(
          tooltip: tooltip,
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          icon: icon,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
        );
      },
    );
  }
}
