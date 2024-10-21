import 'package:flutter/material.dart';

class CustomText {

  kText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign) {
    return Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,
          fontFamily: "Poppins"),
      textAlign: textAlign,
    );
  }

  kEllipseText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign, TextOverflow overflow, int lines) {
    return Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,
          fontFamily: "Poppins"),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: lines,
    );
  }

  kTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color, fontFamily: "Poppins");
  }

  kHeadingText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign) {
    return Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,
          fontFamily: "Race Guard"),
      textAlign: textAlign,
    );
  }

}