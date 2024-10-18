import 'package:flutter/material.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';

class EngagementAgreementScreen extends StatefulWidget {
  const EngagementAgreementScreen({super.key});

  @override
  State<EngagementAgreementScreen> createState() =>
      _EngagementAgreementScreenState();
}

class _EngagementAgreementScreenState extends State<EngagementAgreementScreen> {
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

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
            bottom: 0, // Ensure it stretches to the bottom
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    TextConstants.engagementAgreement,
                    22,
                    FontWeight.w700,
                    ColorConstants.kTextGreen,
                    TextAlign.start,
                  ),
                  const DividerWidget(),
                  const SizedBox(height: 20),

                  // Regulation Image
                  Container(
                    height: 140,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/agreement_info.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Regulation Text
                  customText.kText(
                    "Why do we use it? It is a long established fact that a "
                    "reader will be distracted by the readable content of a page. "
                    "Many desktop publishing packages and web editors now use it. Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it. Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it Many desktop publishing packages and web editors now use it",
                    22,
                    FontWeight.w400,
                    Colors.black,
                    TextAlign.start,
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
