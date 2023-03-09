import 'package:flutter/material.dart';

class AppTheme {
  // Colors for the dark theme
  // Colors for the dark theme
  static const Color _darkPrimaryColor = Color(0xFF9C27B0);
  static const Color _darkAccentColor = Color(0xFFFF4081);
  static const Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkButtonColor = Color(0xFFFFEA00);
  static const Color _darkTextColor = Color(0xFFFFFFFF);

// Colors for the light theme
  static const Color _lightPrimaryColor = Color(0xFFD1C4E9);
  static const Color _lightAccentColor = Color(0xFFFF80AB);
  static const Color _lightBackgroundColor = Color(0xFFf3f3f3);
  static const Color _lightButtonColor = Color(0xFFFFF59D);
  static const Color _lightTextColor = Color(0xFF000000);



  // Define the text themes for both light and dark themes
  static const TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 64.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
  );

  // Define the light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    backgroundColor: _lightBackgroundColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _lightAccentColor,
      selectionColor: _lightAccentColor.withOpacity(0.5),
      selectionHandleColor: _lightAccentColor,
    ),
    textTheme: _textTheme.apply(
      bodyColor: _lightTextColor,
      displayColor: _lightTextColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _lightButtonColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
  );

  // Define the dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    backgroundColor: _darkBackgroundColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _darkAccentColor,
      selectionColor: _darkAccentColor.withOpacity(0.5),
      selectionHandleColor: _darkAccentColor,
    ),
    textTheme: _textTheme.apply(
      bodyColor: _darkTextColor,
      displayColor: _darkTextColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _darkButtonColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
  );
}
