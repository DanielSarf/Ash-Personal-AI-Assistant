import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle defaultFontStyle(
    [FontWeight fontWeight = FontWeight.w300,
    Color fontColor = const Color(
        0xFFEFFAF1), //Hardcoded instead of usin Mint Cream color from colors.dart as there was an issue accessing it
    double fontSize = 13]) {
  return GoogleFonts.ibmPlexSans(
    textStyle: TextStyle(
      fontWeight: fontWeight,
      color: fontColor,
      fontSize: fontSize,
    ),
  );
}

String defaultFontLicense() {
  return 'google_fonts/OFL.txt';
}
