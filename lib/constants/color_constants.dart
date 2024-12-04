import 'package:flutter/material.dart';

class ColorConstants {
  static const kYellow = Color(0xfffdc200);
  static const kTextGreen = Color(0xff01720F);
  static final buttonColor = HexColor("#FDC200");
  static final buttonTextColor = HexColor("#01720F");
  static final kPrimary = HexColor("#01570B");
  static final kTextFieldColor = HexColor("#03600E");
  static final drawerTextColor = HexColor("#FDC200");
  static final searchBoxColor = HexColor("#E8E8E8");
  static final searchColor = HexColor("#898989");
  static final chatColor = HexColor("#707070");
  static final otpFieldColor = HexColor("#03420A");
  static final kDarkGreenColor = HexColor("#05600D");
  static final blueColor = HexColor("#0084B5");
  static final kChatInputColor = HexColor('#4e4e4e');
  static final kChatMessageColor = HexColor('#009c12');
  static final productNameColor = HexColor('#CA3D26');
  static final greyEight = HexColor('#888888');
  static final lightGreyColor = HexColor("#667085");
  static final purpleColor = HexColor("#7161EF");
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
