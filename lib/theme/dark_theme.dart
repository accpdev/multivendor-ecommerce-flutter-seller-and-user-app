import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: const Color(0xFF1455AC),
  brightness: Brightness.dark,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
  highlightColor: const Color(0xFF252525),
  hintColor: const Color(0xFFc7c7c7),
  colorScheme : const ColorScheme.dark(primary: Color(0xFF1455AC),
      secondary: Color(0xFF78BDFC),
      tertiary: Color(0xFF865C0A),
      tertiaryContainer: Color(0xFF6C7A8E),
      onTertiaryContainer: Color(0xFF0F5835),
      primaryContainer: Color(0xFF208458),
      secondaryContainer: Color(0xFFF2F2F2),
      surface: Color(0xFF00FF58),
      surfaceTint: Color(0xFF0087FF),
      onPrimary: Color(0xFF1455AC),
      onSecondary: Color(0xFFFC9926)
  ),

  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
