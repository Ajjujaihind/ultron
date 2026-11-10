import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central ChatGPT-inspired theme configuration for Ultron using Noto Sans font
class AppTheme {
  AppTheme._();

  // ChatGPT Brand / Accent Colors
  static const Color chatgptGreen = Color(0xFF10A37F);
  static const Color chatgptGreenHover = Color(0xFF0E8C6D);

  // ChatGPT Dark Theme Colors
  static const Color darkBackground = Color(0xFF212121);
  static const Color darkSidebar = Color(0xFF171717);
  static const Color darkSurface = Color(0xFF2F2F2F);
  static const Color darkInputSurface = Color(0xFF2F2F2F);
  static const Color darkCardBorder = Color(0xFF383838);
  static const Color darkDivider = Color(0xFF383838);
  static const Color darkTextPrimary = Color(0xFFECECEC);
  static const Color darkTextSecondary = Color(0xFFB4B4B4);
  static const Color darkUserBubble = Color(0xFF2F2F2F);

  // ChatGPT Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSidebar = Color(0xFFF9F9F9);
  static const Color lightSurface = Color(0xFFF4F4F4);
  static const Color lightInputSurface = Color(0xFFF4F4F4);
  static const Color lightCardBorder = Color(0xFFE5E5E5);
  static const Color lightDivider = Color(0xFFE5E5E5);
  static const Color lightTextPrimary = Color(0xFF0D0D0D);
  static const Color lightTextSecondary = Color(0xFF737373);
  static const Color lightUserBubble = Color(0xFFF4F4F4);

  // Light Theme (ChatGPT style + Noto Sans)
  static ThemeData get lightTheme {
    const baseTextTheme = TextTheme(
      headlineMedium: TextStyle(
        color: lightTextPrimary,
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      titleLarge: TextStyle(
        color: lightTextPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: lightTextPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: lightTextPrimary,
        fontSize: 15,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: lightTextPrimary,
        fontSize: 14,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        color: lightTextSecondary,
        fontSize: 12,
        height: 1.4,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: chatgptGreen,
        onPrimary: Colors.white,
        secondary: Color(0xFF171717),
        onSecondary: Colors.white,
        error: Color(0xFFEF4444),
        onError: Colors.white,
        surface: lightSurface,
        onSurface: lightTextPrimary,
      ),
      scaffoldBackgroundColor: lightBackground,
      canvasColor: lightBackground,
      cardColor: lightSurface,
      cardTheme: CardThemeData(
        elevation: 0,
        color: lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: lightCardBorder),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: lightBackground,
        foregroundColor: lightTextPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.notoSans(
          color: lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: lightDivider,
        thickness: 1,
        space: 1,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: lightSidebar,
        indicatorColor: const Color(0xFFE5E5E5),
        selectedIconTheme: const IconThemeData(color: lightTextPrimary),
        unselectedIconTheme: const IconThemeData(color: lightTextSecondary),
        selectedLabelTextStyle: GoogleFonts.notoSans(
          color: lightTextPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: GoogleFonts.notoSans(
          color: lightTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightInputSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        hintStyle: GoogleFonts.notoSans(color: lightTextSecondary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: lightCardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: lightCardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFF999999), width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: lightTextPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightTextPrimary,
          side: const BorderSide(color: lightCardBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: lightBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: lightCardBorder),
        ),
      ),
      textTheme: GoogleFonts.notoSansTextTheme(baseTextTheme),
    );
  }

  // Dark Theme (ChatGPT style + Noto Sans)
  static ThemeData get darkTheme {
    const baseTextTheme = TextTheme(
      headlineMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      titleLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 15,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 14,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        color: darkTextSecondary,
        fontSize: 12,
        height: 1.4,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: chatgptGreen,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Color(0xFF171717),
        error: Color(0xFFEF4444),
        onError: Colors.white,
        surface: darkSurface,
        onSurface: darkTextPrimary,
      ),
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkBackground,
      cardColor: darkSurface,
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkCardBorder),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: darkBackground,
        foregroundColor: darkTextPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.notoSans(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: darkDivider,
        thickness: 1,
        space: 1,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: darkSidebar,
        indicatorColor: const Color(0xFF2E2E2E),
        selectedIconTheme: const IconThemeData(color: darkTextPrimary),
        unselectedIconTheme: const IconThemeData(color: darkTextSecondary),
        selectedLabelTextStyle: GoogleFonts.notoSans(
          color: darkTextPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: GoogleFonts.notoSans(
          color: darkTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkInputSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        hintStyle: GoogleFonts.notoSans(color: darkTextSecondary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: darkCardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: darkCardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFF666666), width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF171717),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkTextPrimary,
          side: const BorderSide(color: darkCardBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF282828),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: darkCardBorder),
        ),
      ),
      textTheme: GoogleFonts.notoSansTextTheme(baseTextTheme),
    );
  }
}
