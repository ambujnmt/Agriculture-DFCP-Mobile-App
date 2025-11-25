import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  String? buttonText;
  Function()? onpress;
  bool loader;
  CustomButton({super.key, this.buttonText, this.onpress, this.loader = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final customText = CustomText();



  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        height: height * 0.060,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.kSecondary,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: const [
            BoxShadow(
                offset: Offset(2, 4), color: Colors.black45, blurRadius: 9.9)
          ],
        ),
        child: Center(
          child: widget.loader
            ? const CircularProgressIndicator(color: ColorConstants.kPrimary,)
            :Text(
                widget.buttonText.toString(),
                style: customText.kTextStyle(
                    22, FontWeight.w700, ColorConstants.kPrimary),
              ),
        ),
      ),
    );
  }
}
