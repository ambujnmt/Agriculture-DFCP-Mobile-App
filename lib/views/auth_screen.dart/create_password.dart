import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {

  final customText = CustomText();
  bool isNewPassHidden = true, isConfirmPassHidden = true;

  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              children: [
                SizedBox(height: height * 0.18),
                customText.kText(TextConstants.createNewPass, 32, FontWeight.w700, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.01),
                customText.kText(TextConstants.createPassDesc, 18, FontWeight.w400, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.08),
                CustomTextField(
                  controller: newPassController,
                  obsecureText: isNewPassHidden,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  hint: TextConstants.newPass,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.white,),
                  isSuffixIcon: true,
                  suffixIcon: Icon(
                    isNewPassHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white,
                  ),
                  onSuffixTap: () {
                    setState(() {
                      isNewPassHidden = !isNewPassHidden;
                    });
                  },
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: confirmPassController,
                  obsecureText: isConfirmPassHidden,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  hint: TextConstants.confirmPass,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.white,),
                  isSuffixIcon: true,
                  suffixIcon: Icon(
                    isConfirmPassHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white,
                  ),
                  onSuffixTap: () {
                    setState(() {
                      isConfirmPassHidden = !isConfirmPassHidden;
                    });
                  },
                ),
                SizedBox(height: height * 0.2),
                CustomButton(
                  buttonText: TextConstants.kContinue,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
