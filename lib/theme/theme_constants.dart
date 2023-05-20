import 'package:flutter/material.dart';

const MaterialColor pallete1 = MaterialColor(_pallete1PrimaryValue, <int, Color>{
  50: Color(0xFFE0E3E9),
  100: Color(0xFFB3B9C7),
  200: Color(0xFF808AA2),
  300: Color(0xFF4D5B7D),
  400: Color(0xFF263761),
  500: Color(_pallete1PrimaryValue),
  600: Color(0xFF00123E),
  700: Color(0xFF000E36),
  800: Color(0xFF000B2E),
  900: Color(0xFF00061F),
});

const int _pallete1PrimaryValue = 0xFF001445;

const MaterialColor pallete1Accent = MaterialColor(_pallete1AccentValue, <int, Color>{
  100: Color(0xFF5C66FF),
  200: Color(_pallete1AccentValue),
  400: Color(0xFF0010F5),
  700: Color(0xFF000EDB),
});

const int _pallete1AccentValue = 0xFF2937FF;

ThemeData defaultTheme = ThemeData(
  brightness: Brightness.dark, 
  primaryColor: pallete1, 
  primarySwatch: pallete1, 
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: pallete1.shade900, 
    unselectedItemColor: Colors.grey.shade600, 
    selectedItemColor: Colors.white
  )
); 

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark
); 

BoxDecoration backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      defaultTheme.primaryColor, 
      defaultTheme.primaryColorDark
    ]
  )
);