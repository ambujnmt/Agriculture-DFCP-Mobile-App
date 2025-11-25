import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  bool isApiCalling = false;
  final customText = CustomText(), api = API(), helper = Helper();
  Map<String, dynamic> profileData = {};
  String referralCode = "";

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getProfile();

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      profileData = response["result"];
      referralCode = profileData["referral_code"];
      setState(() {});

    } else {

    }


  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/images/regulation_back.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorConstants.kPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 25,
                        child: Image.asset('assets/images/send_image1.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                customText.kHeadingText(
                  TextConstants.appTitle,
                  45,
                  FontWeight.w800,
                  ColorConstants.kPrimary,
                  TextAlign.center,
                ),
              ],
            ),
          ),

          isApiCalling
          ? const Center(
              child: CustomProgressIndicator(),
            )
          : Positioned(
            top: 80,
            left: 15,
            right: 15,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    height: height * .25,
                    width: width * .6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/referral.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  customText.kText(
                    TextConstants.earnMoneyByReferral,
                    30,
                    FontWeight.w700,
                    ColorConstants.kPrimary,
                    TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 5,
                    width: width,
                    decoration: BoxDecoration(
                        color: ColorConstants.kSecondary,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(height: 5),
                  customText.kText(
                    TextConstants.referralText,
                    16,
                    FontWeight.w400,
                    ColorConstants.kPrimary,
                    TextAlign.center,
                  ),
                  // SizedBox(
                  //   height: height * .020,
                  // ),
                  // customText.kText(
                  //   TextConstants.howDoesItWork,
                  //   20,
                  //   FontWeight.w700,
                  //   ColorConstants.blueColor,
                  //   TextAlign.center,
                  // ),
                  SizedBox(
                    height: height * .020,
                  ),
                  customText.kText(
                    TextConstants.refCode,
                    20,
                    FontWeight.w400,
                    ColorConstants.kPrimary,
                    TextAlign.center,
                  ),
                  SizedBox(
                    height: height * .020,
                  ),
                  Container(
                    height: height * .050,
                    width: width * .5,
                    decoration: BoxDecoration(
                      color: ColorConstants.kSecondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: customText.kText(
                        referralCode,
                        24,
                        FontWeight.w700,
                        ColorConstants.kPrimary,
                        TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .120,
                  ),

                  CustomButton(
                    buttonText: TextConstants.refNow,
                    onpress: () {
                      Share.share("Hello, this is my referral code $referralCode. You can use this code to register in DFCP app and get exciting deals");
                    },
                  )
                  // GestureDetector(
                  //   onTap: () {
                  //     // Place your share function here
                  //     Share.share("Hello i want to share this code PRADEEP500");
                  //   },
                  //   child: Container(
                  //     height: height * .060,
                  //     width: width,
                  //     decoration: BoxDecoration(
                  //         color: ColorConstants.kYellow,
                  //         borderRadius: BorderRadius.circular(12)),
                  //     child: Center(
                  //       child: customText.kText(
                  //         TextConstants.refNow,
                  //         24,
                  //         FontWeight.w700,
                  //         ColorConstants.kTextGreen,
                  //         TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
