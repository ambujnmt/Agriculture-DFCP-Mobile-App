import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth_screen.dart/login_screen.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  SuccessScreen({super.key});
  
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              children: [
                SizedBox(height: height * 0.15),
                Image.asset("assets/images/success.png"),
                SizedBox(height: height * 0.02),
                customText.kText(TextConstants.regSuccessMsg, 32, FontWeight.w700, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.15),
                CustomButton(
                  buttonText: TextConstants.backToHome,
                  onpress: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
