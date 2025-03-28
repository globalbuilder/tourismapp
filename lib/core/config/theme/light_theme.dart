import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
  ).copyWith(
    secondary: Colors.amber,
  ),
  appBarTheme: const AppBarTheme(elevation: 2, color: Colors.teal),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.teal,
  ),
);
