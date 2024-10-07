import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final customText = CustomText();
  bool isPassHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            const Background(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                children: [
                  SizedBox(height: height * 0.18),
                  customText.kText(TextConstants.login, 32, FontWeight.w700, ColorConstants.kYellow, TextAlign.center),
                  SizedBox(height: height * 0.01),
                  customText.kText(TextConstants.loginDesc, 16, FontWeight.w400, ColorConstants.kYellow, TextAlign.center),
                  SizedBox(height: height * 0.02),
                  // CustomTextField(
                  //   controller: emailController,
                  //   textInputType: TextInputType.emailAddress,
                  //   textInputAction: TextInputAction.next,
                  //   hint: TextConstants.email,
                  //   prefixIcon: const Icon(Icons.email, color: Colors.white,),
                  // ),
                  Container(
                    height: height * 0.065,
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorConstants.kTextFieldColor,
                      borderRadius: BorderRadius.circular(width * 0.04)
                    ),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: TextConstants.email,
                        hintStyle: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
                        prefixIcon: const Icon(Icons.email, color: Colors.white,)
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.065,
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: ColorConstants.kTextFieldColor,
                        borderRadius: BorderRadius.circular(width * 0.04)
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: isPassHidden,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: TextConstants.password,
                        hintStyle: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.white,),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            isPassHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              isPassHidden = !isPassHidden;
                            });
                          },
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: customText.kText(TextConstants.forgotPassword, 16, FontWeight.w400, ColorConstants.kYellow, TextAlign.center),
                  ),
                  SizedBox(height: height * 0.2),
                  CustomButton(
                    buttonText: 'Login',
                    onpress: () {
                      log("login button pressed");
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomButton(
                    buttonText: 'Create Account',
                    onpress: () {
                      log("create account pressed");
                    },
                  ),


                ],
              ),
            )

          ],
        ),
      )
      // body: Container(
      //   padding: EdgeInsets.all(15),
      //   decoration: const BoxDecoration(
      //       image: DecorationImage(
      //           image: AssetImage('assets/images/login_background.png'))),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       CustomButton(
      //         buttonText: 'Login',
      //         onpress: () {
      //           print('This is login butotn');
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       CustomButton(
      //         buttonText: 'Create Account',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
