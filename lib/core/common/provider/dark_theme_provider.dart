import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkThemeProvider = StateNotifierProvider<DarkThemeProvider, bool>(
  (ref) => DarkThemeProvider(),
);

class DarkThemeProvider extends StateNotifier<bool> {
  DarkThemeProvider() : super(false);

  void toggleTheme() {
    state = !state;
  }

  void setDarkTheme(bool isDarkMode) {
    state = isDarkMode;
  }}
