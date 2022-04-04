import 'package:a_8085_helper/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: GoogleFonts.abel().fontFamily,
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      titleTextStyle: GoogleFonts.abel(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),

      iconTheme: const IconThemeData(
        color: Colors.white
      )
    ),
    iconTheme: iconThemeData(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary
    )

  );
}

IconThemeData iconThemeData() {
  return const IconThemeData(
      color: Colors.white
  );
}

TextStyle bitDisplay() {
  return GoogleFonts.orbitron(color: const Color(0xffE10A00), fontSize: 30);
}
