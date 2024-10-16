import 'dart:async';

import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth_screen.dart/create_password.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:developer';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final customText = CustomText();

  String remainingTimer = "60", otp = "";
  int resendOTPTimes = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (timer.tick < 61) {
          log("countdown 60 to 0 :- ${60 - timer.tick}");
          setState(() {
            remainingTimer = (60 - timer.tick).toString();
          });
        } else {
          log("timer is more then 60");
          setState(() {
            remainingTimer = "0";
          });
          timer.cancel();
        }
      },
    );
  }

  resendOTP() async {
    resendOTPTimes++;
    // call api again
  }

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
                customText.kText(TextConstants.verifyOtp, 32, FontWeight.w700, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.01),
                customText.kText(TextConstants.otpDesc, 18, FontWeight.w400, ColorConstants.kYellow, TextAlign.center),
                SizedBox(height: height * 0.02),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: width * 0.12,
                  style: const TextStyle( fontSize: 17 ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  isDense: true,
                  outlineBorderRadius: 20,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Color(0xff03420A),
                  ),
                  onCompleted: (pin) {
                    log("otp entered :- $pin");
                  },
                ),
                SizedBox(height: height * 0.25),
                remainingTimer == "0"
                    ? Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: customText.kText(
                          "Resend OTP",
                          18,
                          FontWeight.w900,
                          Colors.blue.shade300,
                          TextAlign.start),
                      onTap: () {
                        if (resendOTPTimes < 3) {
                          resendOTP();
                        }
                      },
                    ))
                    : Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                          text: "You can resend code request in",
                          style: customText.kTextStyle(
                              18, FontWeight.w600, ColorConstants.kYellow),
                          children: [
                            TextSpan(
                              text: " $remainingTimer ",
                              style: customText.kTextStyle(
                                  20,
                                  FontWeight.w900,
                                  Colors.white),
                            ),
                            TextSpan(
                              text: "s",
                              style: customText.kTextStyle(
                                  18, FontWeight.w600, ColorConstants.kYellow),
                            ),
                          ]),
                    )),
                SizedBox(height: height * 0.05),
                CustomButton(
                  buttonText: TextConstants.confirm,
                  onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePassword() ));
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
