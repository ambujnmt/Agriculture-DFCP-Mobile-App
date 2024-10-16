import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth_screen.dart/otp_screen.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final customText = CustomText();

  TextEditingController emailController = TextEditingController();

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
                SizedBox(height: height * 0.18),
                customText.kText(TextConstants.forgotPassword, 32, FontWeight.w700, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.01),
                customText.kText(TextConstants.forgotPassDesc, 18, FontWeight.w400, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hint: TextConstants.email,
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.white,),
                ),
                SizedBox(height: height * 0.3),
                CustomButton(
                  buttonText: TextConstants.submit,
                  onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpScreen() ));
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
