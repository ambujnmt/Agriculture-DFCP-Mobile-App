import 'package:dfcp/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double? value;
  const CustomProgressIndicator({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorConstants.kPrimary,
      value: value,
    );
  }
}
