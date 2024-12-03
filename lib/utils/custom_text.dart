import 'package:dfcp/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomText {
  kText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign) {
    return Text(
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: "Poppins"),
      textAlign: textAlign,
    );
  }

  kRichText({
    String? textLeft,
    String? textRight,
    Color? colorLeft,
    Color? colorRight,
  }) {
    return RichText(
      text: TextSpan(
        text: '',
        // style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '$textLeft  :-  ',
            style: TextStyle(
                color: colorLeft,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins"),
          ),
          TextSpan(
            text: '$textRight',
            style: TextStyle(
                color: colorRight,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }

  kRichTextWithoutSpace({
    String? textLeft,
    String? textRight,
    Color? colorLeft,
    Color? colorRight,
  }) {
    return RichText(
      text: TextSpan(
        text: '',
        // style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '$textLeft ',
            style: TextStyle(
                color: colorLeft,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins"),
          ),
          TextSpan(
            text: '$textRight',
            style: TextStyle(
                color: colorRight,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }

  kEllipseText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign, TextOverflow overflow, int lines) {
    return Text(
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: "Poppins"),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: lines,
    );
  }

  kTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Poppins");
  }

  kHeadingText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign) {
    return Text(
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: "Race Guard"),
      textAlign: textAlign,
    );
  }
}
