import 'package:flutter/material.dart';

class ColorConstants {
  static const kYellow = Color(0xfffdc200);
  static const kTextGreen = Color(0xff01720F);
  static final buttonColor = HexColor("#FDC200");
  static final buttonTextColor = HexColor("#01720F");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
