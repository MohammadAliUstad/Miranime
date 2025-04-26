import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData monochromeDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: pureWhite,
    onPrimary: pureBlack,
    primaryContainer: mediumDarkGray,
    onPrimaryContainer: veryLightGray,
    secondary: lightGray,
    onSecondary: pureBlack,
    secondaryContainer: darkGray,
    onSecondaryContainer: veryLightGray,
    tertiary: gray,
    onTertiary: pureWhite,
    tertiaryContainer: mediumDarkGray,
    onTertiaryContainer: veryLightGray,
    surface: pureBlack,
    onSurface: pureWhite,
    error: veryLightGray,
    onError: pureBlack,
    errorContainer: gray,
    onErrorContainer: pureWhite,
    outline: lightGray,
    outlineVariant: gray,
    scrim: pureBlack,
    shadow: pureBlack,
    inverseSurface: veryLightGray,
    onInverseSurface: pureBlack,
    inversePrimary: darkGray,
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(color: pureWhite),
    bodyMedium: TextStyle(color: veryLightGray),
    bodySmall: TextStyle(color: gray),
    titleLarge: TextStyle(color: lightGray, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: gray),
    titleSmall: TextStyle(color: lightGray),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: mediumDarkGray,
    foregroundColor: pureWhite,
    centerTitle: true,
  ),

  cardTheme: CardTheme(
    color: darkGray,
    surfaceTintColor: Colors.transparent,
    elevation: 6,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);

final ThemeData monochromeLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: pureBlack,
    onPrimary: pureWhite,
    primaryContainer: lightGray,
    onPrimaryContainer: pureBlack,
    secondary: gray,
    onSecondary: pureWhite,
    secondaryContainer: veryLightGray,
    onSecondaryContainer: pureBlack,
    tertiary: mediumDarkGray,
    onTertiary: pureWhite,
    tertiaryContainer: lightGray,
    onTertiaryContainer: pureBlack,
    surface: pureWhite,
    onSurface: pureBlack,
    error: gray,
    onError: pureWhite,
    errorContainer: lightGray,
    onErrorContainer: pureBlack,
    outline: gray,
    outlineVariant: lightGray,
    scrim: pureBlack,
    shadow: pureBlack,
    inverseSurface: darkGray,
    onInverseSurface: pureWhite,
    inversePrimary: veryLightGray,
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(color: pureBlack),
    bodyMedium: TextStyle(color: darkGray),
    bodySmall: TextStyle(color: gray),
    titleLarge: TextStyle(color: mediumDarkGray, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: gray),
    titleSmall: TextStyle(color: darkGray),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: lightGray,
    foregroundColor: pureBlack,
    centerTitle: true,
  ),

  cardTheme: CardTheme(
    color: veryLightGray,
    surfaceTintColor: Colors.transparent,
    elevation: 6,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);