import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:flutter/material.dart';

class CustomText {

  kText(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign, [TextOverflow? textOverFlow, int? lines]) {
    return Text(
      hint,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: "Red Rose"),
      textAlign: textAlign,
      overflow: textOverFlow ?? TextOverflow.ellipsis,
      maxLines: lines ?? 2,
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
                fontFamily: "Red Rose"),
          ),
          TextSpan(
            text: '$textRight',
            style: TextStyle(
                color: colorRight,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "Red Rose"),
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
                fontFamily: "Red Rose"),
          ),
          TextSpan(
            text: '$textRight',
            style: TextStyle(
                color: colorRight,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "Red Rose"),
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
          fontFamily: "Red Rose"),
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
        fontFamily: "Red Rose");
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

  kAppTitle() {
    return const Text(
      TextConstants.appTitle,
      style: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: ColorConstants.kPrimary,
      fontFamily: "Race Guard"),
      textAlign:  TextAlign.center,
    );
  }

  kTextStrikeThrough(String hint, double fontSize, FontWeight fontWeight, Color color,
      TextAlign textAlign, [TextOverflow? textOverFlow, int? lines]) {
    return Text(
      hint,
      style: TextStyle(
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.red,
        decorationThickness: 2,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Red Rose"),
      textAlign: textAlign,
      overflow: textOverFlow ?? TextOverflow.ellipsis,
      maxLines: lines ?? 2,
    );
  }

}
