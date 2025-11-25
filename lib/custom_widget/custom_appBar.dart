import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';


class CustomBar {

  final customText = CustomText();

  appBar(context) {
    return AppBar(
      leading: GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              color: ColorConstants.kPrimary, shape: BoxShape.circle),
          child: Center(
            child: SizedBox(
              height: 25,
              child: Image.asset('assets/images/send_image1.png'),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: customText.kHeadingText(TextConstants.appTitle, 45,
          FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      centerTitle: true,
    );
  }

}
