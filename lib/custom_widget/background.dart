import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Background({super.key});

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container(
            //   height: height,
            //   width: width,
            //   color: ColorConstants.kPrimary,
            // ),
            SizedBox(
              height: height,
              width: width,
              // child: Image.asset('assets/images/login_background.png', fit: BoxFit.fill,),
              // child: Image.asset('assets/images/simple_bgImage.png', fit: BoxFit.fill,),
              child: Image.asset(
                'assets/images/background_bg.png',
                fit: BoxFit.fill,
              ),
            ),
            // Positioned(
            //   top: height * 0.45,
            //   child: Stack(
            //     children: [
            //       SizedBox(
            //         height: width * 0.25,
            //         child: customText.kHeadingText(TextConstants.appTitle, 75,
            //             FontWeight.w800, Colors.white, TextAlign.center),
            //       ),
            //       Positioned(
            //         top: -1,
            //         left: -1,
            //         child: SizedBox(
            //           height: width * 0.25,
            //           child: customText.kHeadingText(
            //               TextConstants.appTitle,
            //               75,
            //               FontWeight.w800,
            //               ColorConstants.kTextGreen,
            //               TextAlign.center),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
      ),
    );
  }
}
