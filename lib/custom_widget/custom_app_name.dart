import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppName extends StatelessWidget {
  CustomAppName({super.key});

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.width * 0.25,
          child: customText.kHeadingText(
              TextConstants.appTitle,
              75,
              FontWeight.w400,
              Colors.white,
              TextAlign.center),
        ),
        Positioned(
          top: -1,
          left: -1,
          child: SizedBox(
            height: size.width * 0.25,
            child: customText.kHeadingText(
                TextConstants.appTitle,
                75,
                FontWeight.w400,
                ColorConstants.kPrimary,
                TextAlign.center),
          ),
        ),
      ],
    );
  }
}
