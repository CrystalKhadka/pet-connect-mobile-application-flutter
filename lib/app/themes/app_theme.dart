import 'package:final_assignment/app/constants/theme_constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getApplicationTheme(bool isDark) {
    return ThemeData(
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: ThemeConstant.darkPrimaryColor,
              secondary: ThemeConstant.darkSecondaryColor,
              background: ThemeConstant.darkBackgroundColor,
              surface: ThemeConstant.darkSurfaceColor,
            )
          : const ColorScheme.light(
              primary: ThemeConstant.lightPrimaryColor,
              secondary: ThemeConstant.lightSecondaryColor,
              background: ThemeConstant.lightBackgroundColor,
              surface: ThemeConstant.lightSurfaceColor,
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'OpenSans',
      useMaterial3: true,

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: isDark
            ? ThemeConstant.darkAppBarColor
            : ThemeConstant.lightAppBarColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: isDark ? Colors.white : Colors.black,
          backgroundColor: isDark
              ? ThemeConstant.darkPrimaryColor
              : ThemeConstant.lightPrimaryColor,
          textStyle: const TextStyle(fontSize: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? Colors.white : Colors.black,
          textStyle: const TextStyle(fontSize: 15, fontFamily: 'OpenSans'),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDark
            ? ThemeConstant.darkPrimaryColor
            : ThemeConstant.lightPrimaryColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(
            fontSize: 20, color: isDark ? Colors.white70 : Colors.black54),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isDark ? Colors.redAccent : Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: isDark ? Colors.greenAccent : Colors.green),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDark
            ? ThemeConstant.darkPrimaryColor
            : ThemeConstant.lightPrimaryColor,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? ThemeConstant.darkPrimaryColor
            : ThemeConstant.lightPrimaryColor,
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: isDark ? Colors.white70 : Colors.black54,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // ListTile theme
      listTileTheme: ListTileThemeData(
        tileColor: isDark
            ? ThemeConstant.darkSurfaceColor
            : ThemeConstant.lightSurfaceColor,
        textColor: isDark ? Colors.white : Colors.black,
        iconColor: isDark ? Colors.white70 : Colors.black54,
      ),

      // IconButton theme
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(isDark ? Colors.white : Colors.black),
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: isDark
            ? ThemeConstant.darkSurfaceColor
            : ThemeConstant.lightSurfaceColor,
        shadowColor: isDark ? Colors.white24 : Colors.black26,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // AwesomeDialog theme (custom extension)
      extensions: [
        AwesomeDialogTheme(
          isDark: isDark,
          buttonColor: isDark
              ? ThemeConstant.darkPrimaryColor
              : ThemeConstant.lightPrimaryColor,
          buttonTextColor: isDark ? Colors.white : Colors.black,
          dialogBackgroundColor: isDark
              ? ThemeConstant.darkSurfaceColor
              : ThemeConstant.lightSurfaceColor,
          titleTextColor: isDark ? Colors.white : Colors.black,
          descTextColor: isDark ? Colors.white70 : Colors.black87,
        ),
      ],
    );
  }
}

// Custom extension for AwesomeDialog theme
class AwesomeDialogTheme extends ThemeExtension<AwesomeDialogTheme> {
  final bool isDark;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color dialogBackgroundColor;
  final Color titleTextColor;
  final Color descTextColor;

  AwesomeDialogTheme({
    required this.isDark,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.dialogBackgroundColor,
    required this.titleTextColor,
    required this.descTextColor,
  });

  @override
  ThemeExtension<AwesomeDialogTheme> copyWith({
    bool? isDark,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? dialogBackgroundColor,
    Color? titleTextColor,
    Color? descTextColor,
  }) {
    return AwesomeDialogTheme(
      isDark: isDark ?? this.isDark,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      dialogBackgroundColor:
          dialogBackgroundColor ?? this.dialogBackgroundColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      descTextColor: descTextColor ?? this.descTextColor,
    );
  }

  @override
  ThemeExtension<AwesomeDialogTheme> lerp(
      ThemeExtension<AwesomeDialogTheme>? other, double t) {
    if (other is! AwesomeDialogTheme) {
      return this;
    }
    return AwesomeDialogTheme(
      isDark: t < 0.5 ? isDark : other.isDark,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t)!,
      dialogBackgroundColor:
          Color.lerp(dialogBackgroundColor, other.dialogBackgroundColor, t)!,
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t)!,
      descTextColor: Color.lerp(descTextColor, other.descTextColor, t)!,
    );
  }
}
