import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatefulWidget {
  final String? title;
  const CustomTitle({super.key, this.title});

  @override
  State<CustomTitle> createState() => _CustomTitleState();
}

class _CustomTitleState extends State<CustomTitle> {

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText.kText(
          widget.title!,
          25,
          FontWeight.w700,
          ColorConstants.kPrimary,
          TextAlign.center,
        ),

        const DividerWidget(),

        SizedBox(height: size.height * 0.01,)
      ],
    );
  }
}
