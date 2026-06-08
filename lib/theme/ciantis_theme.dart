import 'package:flutter/material.dart';

class CiantisTheme {
  // CORE COLORS — luxury taupe / iOS-inspired
  static const Color appBackground = Color(0xFFF6F1EA);
  static const Color appBackgroundAlt = Color(0xFFF1EAE2);

  static const Color card = Color(0xFFFBF8F4);
  static const Color cardSoft = Color(0xFFF3ECE4);
  static const Color divider = Color(0xFFE1D6CA);

  static const Color textPrimary = Color(0xFF241D18);
  static const Color textSecondary = Color(0xFF6F6258);
  static const Color textMuted = Color(0xFF9A8D83);

  static const Color taupe = Color(0xFFB89A78);
  static const Color taupeDark = Color(0xFF8E6F55);
  static const Color bronze = Color(0xFFC6A06B);
  static const Color softBrown = Color(0xFF7A6251);

  static const Color white = Colors.white;
  static const Color black = Color(0xFF111111);

  // OLD COLOR NAMES KEPT SO CURRENT FILES DO NOT BREAK
  static const Color backgroundTop = appBackground;
  static const Color backgroundMiddle = appBackgroundAlt;
  static const Color backgroundBottom = cardSoft;

  static const Color creamPanel = card;
  static const Color warmBrown = taupeDark;
  static const Color deepBrown = textPrimary;
  static const Color profileBrown = softBrown;

  static const Color whiteSoft = Color(0xB3FFFFFF);
  static const Color textBrown = textPrimary;

  // EFFECTS
  static const double glassOpacity = 0.08;
  static const double glassBorderOpacity = 0.14;
  static const double overlayOpacity = 0.08;

  static const double blurLight = 12;
  static const double blurHeavy = 18;

  // RADIUS — more modern, less bubbly
  static const double radiusSmall = 10;
  static const double radiusMedium = 14;
  static const double radiusLarge = 18;
  static const double radiusXLarge = 22;
  static const double radiusSheet = 24;
  static const double radiusDrawer = 34;

  // SPACING
  static const double pagePadding = 20;
  static const double bottomBarHeight = 70;
  static const double bottomBarBottomPadding = 24;

  // FONT SIZES
  static const double titleSize = 30;
  static const double appTitleSize = 24;
  static const double bodySize = 15;
  static const double smallSize = 12;

  // BACKGROUND — subtle, not obvious gradient
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      appBackground,
      appBackgroundAlt,
    ],
  );

  static BoxDecoration pageBackground = const BoxDecoration(
    gradient: mainGradient,
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    color: card,
    borderRadius: BorderRadius.circular(radiusMedium),
    border: Border.all(
      color: divider,
      width: 0.7,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.035),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static BoxDecoration softCardDecoration = BoxDecoration(
    color: cardSoft,
    borderRadius: BorderRadius.circular(radiusMedium),
    border: Border.all(
      color: divider,
      width: 0.6,
    ),
  );

  // APP THEME
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: appBackground,
    fontFamily: 'SF Pro Display',

    colorScheme: const ColorScheme.light(
      primary: taupeDark,
      secondary: taupe,
      surface: card,
      background: appBackground,
      error: Color(0xFF9B3D30),
      onPrimary: white,
      onSecondary: textPrimary,
      onSurface: textPrimary,
      onBackground: textPrimary,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.8,
        color: textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.6,
        color: textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.4,
        color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.3,
        color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.2,
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.35,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.35,
        color: textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.3,
        color: textMuted,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: textSecondary,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: textPrimary,
      titleTextStyle: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.7,
        color: textPrimary,
      ),
      iconTheme: IconThemeData(
        color: textPrimary,
        size: 22,
      ),
    ),

    cardTheme: CardThemeData(
      color: card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        side: const BorderSide(
          color: divider,
          width: 0.7,
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: divider,
      thickness: 0.7,
      space: 1,
    ),

    iconTheme: const IconThemeData(
      color: textPrimary,
      size: 22,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1F1A16),
      selectedItemColor: bronze,
      unselectedItemColor: Color(0xFFE8DED3),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardSoft,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      hintStyle: const TextStyle(
        color: textMuted,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(
          color: divider,
          width: 0.7,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(
          color: divider,
          width: 0.7,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(
          color: taupeDark,
          width: 1,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: textPrimary,
        foregroundColor: white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textPrimary,
        minimumSize: const Size(double.infinity, 48),
        side: const BorderSide(
          color: divider,
          width: 0.8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: taupeDark,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}