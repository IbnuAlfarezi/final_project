import 'package:final_project/style/color_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  static TextStyle splashScreenHeading = GoogleFonts.robotoMono(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.splashHeading,
  );
  static TextStyle splashScreenHeading2 = GoogleFonts.robotoMono(
    fontSize: 28,
    fontWeight: FontWeight.normal,
    color: AppColors.splashHeading2,
  );
  static TextStyle loginText = GoogleFonts.robotoMono(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: AppColors.splashHeading2,
  );
  static TextStyle home = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.mainText,
  );
  static TextStyle jobTittle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle jobText = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
  static TextStyle homeTittle = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.mainColor,
  );
}
