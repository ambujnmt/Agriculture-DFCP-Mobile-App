import 'package:dfcp/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomButton extends StatefulWidget {
  String? buttonText;
  Function()? onpress;
  CustomButton({super.key, this.buttonText, this.onpress});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorConstants.buttonColor,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            widget.buttonText.toString(),
            style: TextStyle(
                color: ColorConstants.buttonTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "Red Rose"),
          ),
        ),
      ),
    );
  }
}
