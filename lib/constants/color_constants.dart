import 'package:flutter/material.dart';

class ColorConstants {
  static const kTextGrey = Color(0xff62676C);
  static const kPrimary = Color(0xff01720F);
  static const kSecondary = Color(0xffFDC200);
  static const kGrey = Color(0xffE8E8E8);
  static const kChatMessageColor = Color(0xff009c12);
  static const productNameColor = Color(0xffCA3D26);
  static const lightGreyColor = Color(0xff667085);
}

// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
//
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }
