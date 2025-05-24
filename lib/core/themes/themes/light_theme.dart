import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rama_poke_app/core/themes/color_theme.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    surfaceTintColor: Colors.white, 
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: Colors.black87,
    displayColor: Colors.black,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  cardColor: Colors.white,
  cardTheme: CardTheme(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: ColorTheme.bottomNavbarTextActiveColorLight,
    unselectedItemColor: Colors.grey,
  ),
  hintColor: ColorTheme.placeholderSearchBarLight,
  dividerColor: ColorTheme.dividerLight,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ColorTheme.borderSearchBarLight),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorTheme.borderSearchBarLight),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorTheme.borderSearchBarLight),
      borderRadius: BorderRadius.circular(8.0),
    ),
    hintStyle: TextStyle(color: ColorTheme.placeholderSearchBarLight),
  ),
  indicatorColor: ColorTheme.buttonColorLight,
);
