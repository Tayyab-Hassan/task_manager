import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishclr = Color(0xFF4e5ae8);
Color yellowclr = const Color(0xFFFFB746);
Color pinkclr = const Color(0xFFff4667);
Color white = Colors.white;
const primaryclr = bluishclr;
Color darkgreyclr = const Color(0xFF121212);
Color darkhHeaderclr = const Color(0x0ff42424);

class Themes {
  static final light = ThemeData(
    iconTheme: IconThemeData(color: Colors.blue.shade50),
    appBarTheme: const AppBarTheme(color: Colors.white),
    brightness: Brightness.light,
    primaryColor: primaryclr,
  );
  static final dark = ThemeData(
    iconTheme: IconThemeData(color: Colors.blue.shade50),
    appBarTheme: AppBarTheme(color: darkgreyclr),
    brightness: Brightness.dark,
    primaryColor: darkgreyclr,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[700] : Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.black : Colors.grey[200],
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}
