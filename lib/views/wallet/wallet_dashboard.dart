import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/wallet/upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class WalletDashboard extends StatefulWidget {
  const WalletDashboard({super.key});

  @override
  State<WalletDashboard> createState() => _WalletDashboardState();
}

class _WalletDashboardState extends State<WalletDashboard> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: height,
              width: width,
              color: ColorConstants.kTextGreen,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 320, left: 0, right: 15, bottom: 20),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: customText.kText(
                            "Today",
                            20,
                            FontWeight.w400,
                            ColorConstants.kYellow,
                            TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: height * .010,
                        ),
                        ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Image.asset(
                                'assets/images/leading_icon.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          title: customText.kText("Advisor", 20,
                              FontWeight.w700, Colors.white, TextAlign.start),
                          subtitle: customText.kText(
                              "Paid to day, 12:11 PM",
                              12,
                              FontWeight.w300,
                              Colors.white,
                              TextAlign.start),
                          trailing: customText.kText(
                              "- 200",
                              16,
                              FontWeight.w700,
                              ColorConstants.kYellow,
                              TextAlign.start),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(72),
              ),
            ),
            height: height * .4,
            width: width,
            child: Container(
              margin: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                              child:
                                  Image.asset('assets/images/send_image1.png'),
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
                  SizedBox(height: height * .02),
                  customText.kText(
                    TextConstants.yourBalance,
                    20,
                    FontWeight.w400,
                    ColorConstants.kTextGreen,
                    TextAlign.start,
                  ),
                  customText.kText(
                    "₹ 1500",
                    22,
                    FontWeight.w700,
                    Colors.black,
                    TextAlign.start,
                  ),
                  SizedBox(height: height * .020),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                TextConstants.byReferal,
                                20,
                                FontWeight.w400,
                                ColorConstants.kTextGreen,
                                TextAlign.start,
                              ),
                              customText.kText(
                                "₹ 3000",
                                22,
                                FontWeight.w700,
                                Colors.black,
                                TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                TextConstants.byAdvise,
                                20,
                                FontWeight.w400,
                                ColorConstants.kTextGreen,
                                TextAlign.start,
                              ),
                              customText.kText(
                                "₹ 15000",
                                22,
                                FontWeight.w700,
                                Colors.black,
                                TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .030),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // bottom sheet
                        _showBottomSheet();
                      },
                      child: Container(
                        height: height * .0450,
                        width: width * .45,
                        decoration: BoxDecoration(
                            color: ColorConstants.kTextGreen,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: customText.kText(
                              TextConstants.addMoney,
                              22,
                              FontWeight.w700,
                              ColorConstants.kYellow,
                              TextAlign.center),
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

  _showBottomSheet() {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            // margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(20),
            height: 600,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText.kText(
                  TextConstants.select,
                  24,
                  FontWeight.w700,
                  ColorConstants.kTextGreen,
                  TextAlign.start,
                ),
                SizedBox(height: h * .020),
                Container(
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstants.kTextGreen, width: 3),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset('assets/images/upi.png'),
                      ),
                    ),
                    title: Container(
                      child: customText.kText(TextConstants.byUPI, 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                  ),
                ),
                SizedBox(height: h * .020),
                Container(
                  child: ListTile(
                    onTap: () {},
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstants.kTextGreen, width: 3),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset('assets/images/debit_credit.png'),
                      ),
                    ),
                    title: Container(
                      child: customText.kText(TextConstants.byDebitCard, 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                  ),
                ),
                SizedBox(height: h * .020),
                Container(
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstants.kTextGreen, width: 3),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset('assets/images/debit_credit.png'),
                      ),
                    ),
                    title: Container(
                      child: customText.kText(TextConstants.byCreditCard, 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                  ),
                ),
                SizedBox(height: h * .020),
                Container(
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstants.kTextGreen, width: 3),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset('assets/images/net_banking.png'),
                      ),
                    ),
                    title: Container(
                      child: customText.kText(TextConstants.byNetBanking, 22,
                          FontWeight.w700, Colors.black, TextAlign.start),
                    ),
                  ),
                ),
                SizedBox(height: h * .040),
                CustomButton(
                  buttonText: TextConstants.buttonText,
                  onpress: () {
                    // onpress function
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpiPayment(),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        });
  }
}
