import 'package:dfcp/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatefulWidget {
  const DividerWidget({super.key});

  @override
  State<DividerWidget> createState() => _DividerWidgetState();
}

class _DividerWidgetState extends State<DividerWidget> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 5,
      width: width * .2,
      decoration: BoxDecoration(
          color: ColorConstants.kSecondary,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
