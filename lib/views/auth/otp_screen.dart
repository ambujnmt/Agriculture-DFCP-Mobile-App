import 'dart:async';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
import 'dart:developer';
import 'package:pinput/pinput.dart';


class OtpScreen extends StatefulWidget {
  final String? email;
  const OtpScreen({super.key, this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final customText = CustomText(), helper = Helper(), api = API();

  String remainingTimer = "60", otp = "";
  int resendOTPTimes = 0;
  bool isApiCalling = false;
  late final TextEditingController pinController;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
    focusNode = FocusNode();
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

  verifyOtp() async {

    if(otp != "") {

      setState(() {
        isApiCalling = true;
      });

      final response = await api.verifyOtp(widget.email!, otp);

      setState(() {
        isApiCalling = false;
      });

      if(response["status"] == 1) {
        helper.successDialog(response["message"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
      } else {
        helper.errorDialog(response["message"]);
      }

    } else {
      helper.errorDialog(TextConstants.validOTP);
    }

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: ColorConstants.kSecondary),
      ),
    );
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
                  customText.kText(TextConstants.verifyOtp, 32, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                  SizedBox(height: height * 0.01),
                  customText.kText(TextConstants.otpDesc, 18, FontWeight.w400, ColorConstants.kSecondary, TextAlign.center, TextOverflow.visible, 3),
                  SizedBox(height: height * 0.02),
                  // OTPTextField(
                  //   length: 6,
                  //   width: MediaQuery.of(context).size.width,
                  //   fieldWidth: width * 0.12,
                  //   style: const TextStyle( fontSize: 17, color: Colors.white ),
                  //   textFieldAlignment: MainAxisAlignment.spaceAround,
                  //   fieldStyle: FieldStyle.box,
                  //   isDense: true,
                  //   outlineBorderRadius: 20,
                  //   otpFieldStyle: OtpFieldStyle(
                  //     focusBorderColor: ColorConstants.kYellow,
                  //     enabledBorderColor: ColorConstants.kYellow,
                  //     backgroundColor: ColorConstants.otpFieldColor,
                  //   ),
                  //   onCompleted: (pin) {
                  //     log("otp entered :- $pin");
                  //     otp = pin;
                  //     setState(() {});
                  //   },
                  // ),
                  // Pinput(
                  //   length: 6,
                  //   cur
                  //   onChanged: (pin) {
                  //     log("otp entered :- $pin");
                  //         otp = pin;
                  //         setState(() {});
                  //   },
                  // ),
                  Pinput(
                    // smsRetriever: smsRetriever,
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                      otp = pin;
                      setState(() {});
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                      setState(() {
                        pinController.text = value;
                      });
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: ColorConstants.kPrimary,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: ColorConstants.kSecondary),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: ColorConstants.kPrimary,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: ColorConstants.kSecondary),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(height: height * 0.25),
                  remainingTimer == "0"
                      ? Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: customText.kText(
                            TextConstants.resendOtp,
                            18,
                            FontWeight.w900,
                            Colors.blue.shade900,
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
                            text: TextConstants.resendOtpDesc,
                            style: customText.kTextStyle(
                                18, FontWeight.w600, ColorConstants.kSecondary),
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
                                    18, FontWeight.w600, ColorConstants.kSecondary),
                              ),
                            ]),
                      )),
                  SizedBox(height: height * 0.05),
                  CustomButton(
                    buttonText: TextConstants.confirm,
                    loader: isApiCalling,
                    onpress: () {
                      verifyOtp();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePassword() ));
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
