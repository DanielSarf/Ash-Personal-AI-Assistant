import 'package:ash_personal_assistant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double height;
  final double width;
  final double fontSize;
  final double cornerRadius;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final Color focusBorderColor;
  final double focusBorderWidth;
  final Color backgroundColor;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.cornerRadius,
    required this.textColor,
    required this.borderColor,
    required this.borderWidth,
    required this.focusBorderColor,
    required this.focusBorderWidth,
    required this.backgroundColor,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: textColor,
        cursorWidth: borderWidth,
        cursorOpacityAnimates: true,
        cursorErrorColor: const ColorPalette().tomato,
        style: GoogleFonts.ibmPlexSans(
          textStyle: TextStyle(
            color: textColor,
            fontSize: fontSize,
            decorationThickness: 0,
          ),
        ),
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: true,
          hintStyle: GoogleFonts.ibmPlexSans(
            textStyle: TextStyle(
              fontSize: fontSize,
              color: Color.fromARGB(
                  190, textColor.red, textColor.green, textColor.blue),
              fontWeight: FontWeight.w400,
            ),
          ),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide(
              color: focusBorderColor,
              width: focusBorderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: BorderSide(
              color: const ColorPalette().tomato,
              width: focusBorderWidth,
            ),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
