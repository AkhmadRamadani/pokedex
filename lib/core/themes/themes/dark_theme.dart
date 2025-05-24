import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rama_poke_app/core/themes/color_theme.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green[300],
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF121212),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    surfaceTintColor: Color(0xFF121212), 
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.white70,
    displayColor: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: const Color(0xFF1E1E1E),
  cardTheme: CardTheme(
    color: const Color(0xFF1E1E1E),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF121212),
    selectedItemColor: ColorTheme.bottomNavbarTextActiveColorDark,
    unselectedItemColor: Colors.grey,
  ),
  hintColor: ColorTheme.placeholderSearchBarDark,
  dividerColor: ColorTheme.dividerDark,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ColorTheme.borderSearchBarDark),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorTheme.borderSearchBarDark),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorTheme.borderSearchBarDark),
      borderRadius: BorderRadius.circular(8.0),
    ),
    hintStyle: TextStyle(color: ColorTheme.placeholderSearchBarDark),
  ),
  indicatorColor: ColorTheme.buttonColorDark
);
