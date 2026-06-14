import 'package:portfolio/core/helpers/shared_preference/preference_helper.dart';
import 'package:portfolio/core/helpers/shared_preference/preference_keys.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeChangedState(isDark: false)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final isDark = PrefHelper.get(PrefKeys.currentTheme) ?? false;
      emit(ThemeChangedState(isDark: isDark));
    } catch (_) {
      emit(const ThemeChangedState(isDark: false));
    }
  }

  Future<void> changeTheme(bool isDark) async {
    emit(ThemeChangedState(isDark: isDark));
    try {
      await PrefHelper.save(PrefKeys.currentTheme, isDark);
    } catch (_) {}
  }

  Future<void> toggleTheme() async {
    await changeTheme(!state.isDark);
  }
}
