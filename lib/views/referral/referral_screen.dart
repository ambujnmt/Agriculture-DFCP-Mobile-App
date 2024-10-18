import 'package:flutter/material.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/regulation_back.png',
              fit: BoxFit.cover,
            ),
          ),

          // Top Header with Navigation
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorConstants.kTextGreen,
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
                const SizedBox(width: 80),
                customText.kHeadingText(
                  TextConstants.appTitle,
                  45,
                  FontWeight.w800,
                  ColorConstants.kTextGreen,
                  TextAlign.center,
                ),
              ],
            ),
          ),

          // Scrollable Content
          Positioned(
            top: 120,
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
                    ColorConstants.kTextGreen,
                    TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 5,
                    width: width,
                    decoration: BoxDecoration(
                        color: ColorConstants.kYellow,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(height: 5),
                  customText.kText(
                    TextConstants.referralText,
                    16,
                    FontWeight.w400,
                    ColorConstants.kTextGreen,
                    TextAlign.center,
                  ),
                  SizedBox(
                    height: height * .020,
                  ),
                  customText.kText(
                    TextConstants.howDoesItWork,
                    20,
                    FontWeight.w700,
                    ColorConstants.blueColor,
                    TextAlign.center,
                  ),
                  SizedBox(
                    height: height * .020,
                  ),
                  customText.kText(
                    TextConstants.refCode,
                    20,
                    FontWeight.w400,
                    ColorConstants.kTextGreen,
                    TextAlign.center,
                  ),
                  SizedBox(
                    height: height * .020,
                  ),
                  Container(
                    height: height * .050,
                    width: width * .5,
                    decoration: BoxDecoration(
                      color: ColorConstants.kYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: customText.kText(
                        "PRADEEP500",
                        24,
                        FontWeight.w700,
                        ColorConstants.kTextGreen,
                        TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .120,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Place your share function here
                      Share.share("Hello i want to share this code");
                    },
                    child: Container(
                      height: height * .060,
                      width: width,
                      decoration: BoxDecoration(
                          color: ColorConstants.kYellow,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: customText.kText(
                          TextConstants.refNow,
                          24,
                          FontWeight.w700,
                          ColorConstants.kTextGreen,
                          TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
