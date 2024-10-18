import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth_screen.dart/forgot_password.dart';
import 'package:dfcp/views/auth_screen.dart/registeration_screen.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
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
      body: Stack(
        children: [
          Background(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.18),
                  customText.kText(TextConstants.login, 32, FontWeight.w700,
                      ColorConstants.kYellow, TextAlign.center),
                  SizedBox(height: height * 0.01),
                  customText.kText(TextConstants.loginDesc, 16, FontWeight.w400,
                      ColorConstants.kYellow, TextAlign.center),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hint: TextConstants.email,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: passwordController,
                    obsecureText: isPassHidden,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hint: TextConstants.password,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    isSuffixIcon: true,
                    suffixIcon: Icon(
                      isPassHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white,
                    ),
                    onSuffixTap: () {
                      setState(() {
                        isPassHidden = !isPassHidden;
                      });
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: customText.kText(
                          TextConstants.forgotPassword,
                          16,
                          FontWeight.w400,
                          ColorConstants.kYellow,
                          TextAlign.center),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.2),
                  CustomButton(
                    buttonText: TextConstants.login,
                    onpress: () {
                      log("login button pressed");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardScreen()),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomButton(
                    buttonText: TextConstants.createAccount,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationScreen()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
