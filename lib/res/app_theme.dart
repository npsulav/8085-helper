import 'package:a_8085_helper/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(

    )
  );
}

IconThemeData iconThemeData() {
  return const IconThemeData(
      color: Colors.white
  );
}