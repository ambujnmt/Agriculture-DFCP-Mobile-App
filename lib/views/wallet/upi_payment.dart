import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/wallet/card_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UpiPayment extends StatefulWidget {
  const UpiPayment({super.key});

  @override
  State<UpiPayment> createState() => _UpiPaymentState();
}

class _UpiPaymentState extends State<UpiPayment> {
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
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
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
            customText.kText(
              TextConstants.completeYourPayment,
              22,
              FontWeight.w700,
              ColorConstants.kTextGreen,
              TextAlign.center,
            ),
            const DividerWidget(),
            SizedBox(height: height * .030),
            customText.kText(TextConstants.enterAmount, 20, FontWeight.w400,
                ColorConstants.kTextGreen, TextAlign.start),
            SizedBox(height: height * .010),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.currency_rupee_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .020),
            customText.kText(TextConstants.enterUpi, 20, FontWeight.w400,
                ColorConstants.kTextGreen, TextAlign.start),
            SizedBox(height: height * .010),
            Container(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                customText.kText(
                  TextConstants.verifyNow,
                  16,
                  FontWeight.w400,
                  ColorConstants.kTextGreen,
                  TextAlign.center,
                )
              ],
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  buttonText: TextConstants.payNow,
                  onpress: () {
                    // place your onpress function here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CardPayment(),
                      ),
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
