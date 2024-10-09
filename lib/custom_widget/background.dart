import 'package:dfcp/constants/color_constants.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: ColorConstants.kPrimary,
          ),
          SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              'assets/images/login_background.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: -325,
            left: 40,
            child: SizedBox(
                height: height * 0.9,
                width: width * 0.9,
                child: Image.asset('assets/images/top_curve.png')),
          ),
          Positioned(
            top: height * 0.4,
            left: -55,
            child: SizedBox(
              height: height * 0.5,
              width: width * 0.5,
              child: Image.asset("assets/images/left_curve.png"),
            ),
          ),
          Positioned(
            top: height * 0.5,
            left: width * 0.65,
            child: SizedBox(
              height: height * 0.5,
              width: width * 0.5,
              child: Image.asset("assets/images/right_curve.png"),
            ),
          )
        ],
      ),
    ));
  }
}
