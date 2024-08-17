import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme_state.dart';

final themeViewModelProvider =
    StateNotifierProvider<ThemeViewModel, ThemeState>(
  (ref) => ThemeViewModel(),
);

class ThemeViewModel extends StateNotifier<ThemeState> {
  ThemeViewModel() : super(ThemeState.initial());

  void toggleTheme(String theme) {
    if (theme == 'auto') {
      print('auto');
      state = state.copyWith(isAutoMode: true);
    } else {
      state = state.copyWith(isAutoMode: false, isDarkMode: theme == 'dark');
    }
  }

  void setDarkTheme(bool isDarkMode) {
    if (!state.isAutoMode) return;
    state = state.copyWith(isDarkMode: isDarkMode);
  }
}
