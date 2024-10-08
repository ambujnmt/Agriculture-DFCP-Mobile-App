import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomBox extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? boxColor;
  final Color? textColor;
  final String? text;
  final String? count;
  CustomBox({
    super.key,
    this.height,
    this.width,
    this.boxColor,
    this.textColor,
    this.text,
    this.count,
  });

  @override
  State<CustomBox> createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 15, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text.toString(),
              style: TextStyle(
                color: widget.textColor,
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.count.toString(),
              style: TextStyle(
                color: widget.textColor,
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
