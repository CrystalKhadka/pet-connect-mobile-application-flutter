class ThemeState {
  final bool isDarkMode;
  final bool isAutoMode;

  ThemeState({required this.isDarkMode, required this.isAutoMode});

  factory ThemeState.initial() {
    return ThemeState(
      isDarkMode: false,
      isAutoMode: false,
    );
  }

  ThemeState copyWith({bool? isDarkMode, bool? isAutoMode}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isAutoMode: isAutoMode ?? this.isAutoMode,
    );
  }
}
