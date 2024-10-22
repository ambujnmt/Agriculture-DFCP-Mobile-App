import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: ColorConstants.kTextGreen, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                height: 25,
                child: Image.asset('assets/images/send_image1.png'),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            premiumAndType(TextConstants.premiumMonthly, "1 Month"),
            SizedBox(height: height * .010),
            premiumAndType(TextConstants.premiumAnnualy, "12 Month"),
            SizedBox(height: height * .10),
            CustomButton(
              buttonText: TextConstants.continueAndPay,
            ),
          ],
        ),
      ),
    );
  }

  Widget premiumAndType(String text, String premiumText) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(15),
      height: height * .2,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.kTextGreen,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: customText.kText(text, 18, FontWeight.w700,
                ColorConstants.kYellow, TextAlign.center),
          ),
          Container(
            height: height * .04,
            width: width * .3,
            decoration: BoxDecoration(
              color: ColorConstants.kYellow,
              borderRadius: BorderRadius.circular(36),
            ),
            child: Center(
              child: customText.kText(premiumText, 12, FontWeight.w700,
                  ColorConstants.kTextGreen, TextAlign.start),
            ),
          ),
        ],
      ),
    );
  }
}
