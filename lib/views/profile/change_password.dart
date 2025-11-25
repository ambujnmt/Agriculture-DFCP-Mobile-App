import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth/success_screen.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final customText = CustomText();
  bool oldHidden = true, newHidden = true, confirmNewHidden = true;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.1),
                    Center(
                      child: customText.kText(
                        TextConstants.changePassword,
                        32,
                        FontWeight.w700,
                        ColorConstants.kSecondary,
                        TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Center(
                      child: customText.kText(
                        TextConstants.createPassDesc,
                        18,
                        FontWeight.w400,
                        ColorConstants.kSecondary,
                        TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.08),
                    CustomTextField(
                      controller: oldPasswordController,
                      obsecureText: oldHidden,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hint: TextConstants.oldPassword,
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.white),
                      isSuffixIcon: true,
                      suffixIcon: Icon(
                        oldHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          oldHidden = !oldHidden;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: newPasswordController,
                      obsecureText: newHidden,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hint: TextConstants.newPassword,
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.white),
                      isSuffixIcon: true,
                      suffixIcon: Icon(
                        newHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          newHidden = !newHidden;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: confirmNewPasswordController,
                      obsecureText: confirmNewHidden,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hint: TextConstants.confirmNewPassword,
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.white),
                      isSuffixIcon: true,
                      suffixIcon: Icon(
                        confirmNewHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          confirmNewHidden = !confirmNewHidden;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.1),
                    CustomButton(
                      buttonText: TextConstants.kContinue,
                      onpress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SuccessScreen(from: "createPassword"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
