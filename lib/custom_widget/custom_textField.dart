import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller,
      textInputType,
      textInputAction,
      hint,
      isSuffixIcon,
      prefixIcon,
      suffixIcon,
      obsecureText;
  Function()? onSuffixTap;
  double horizontalPadding;

  CustomTextField({
    super.key,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.hint,
    this.isSuffixIcon = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obsecureText = false,
    this.horizontalPadding = 0,
  });

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.065,
      width: width * 0.95,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: horizontalPadding),
      decoration: BoxDecoration(
          color: ColorConstants.kTextFieldColor,
          borderRadius: BorderRadius.circular(width * 0.04)),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        style:
            customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: customText.kTextStyle(
                20, FontWeight.w400, ColorConstants.kYellow),
            prefixIcon: prefixIcon,
            suffixIcon: isSuffixIcon
                ? GestureDetector(
                    child: suffixIcon,
                    onTap: onSuffixTap,
                  )
                : const SizedBox()),
      ),
    );
  }
}
