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
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: ColorConstants.kPrimary, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                height: 25,
                child: Image.asset('assets/images/send_image1.png'),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      ),
      body: Container(
        height: height,
        width: width,
        color: ColorConstants.kPrimary,
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: Container(
                height: height * 0.32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * 0.2),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      customText.kText(
                        TextConstants.yourBalance,
                        20,
                        FontWeight.w400,
                        ColorConstants.kPrimary,
                        TextAlign.start,
                      ),
                      customText.kText(
                        "₹ 1500",
                        22,
                        FontWeight.w700,
                        Colors.black,
                        TextAlign.start,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                TextConstants.byReferal,
                                20,
                                FontWeight.w400,
                                ColorConstants.kPrimary,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText.kText(
                                TextConstants.byAdvise,
                                20,
                                FontWeight.w400,
                                ColorConstants.kPrimary,
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
                        ],
                      ),

                      SizedBox(height: height * 0.03),
                      Center(
                        child: GestureDetector(
                          child: Container(
                            height: height * .055,
                            width: width * .45,
                            decoration: BoxDecoration(
                              color: ColorConstants.kPrimary,
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: Center(
                              child: customText.kText(
                                  TextConstants.addMoney,
                                  22,
                                  FontWeight.w700,
                                  ColorConstants.kSecondary,
                                  TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            _showBottomSheet();
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: customText.kText(
                            "Today",
                            20,
                            FontWeight.w400,
                            ColorConstants.kSecondary,
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
                              ColorConstants.kSecondary,
                              TextAlign.start),
                        ),
                      ],
                    );
                  },
                  childCount: 2
              ),
            ),

          ],
        ),
      )

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
            height: h * 0.6,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    TextConstants.select,
                    24,
                    FontWeight.w700,
                    ColorConstants.kPrimary,
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
                              color: ColorConstants.kPrimary, width: 3),
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
                              color: ColorConstants.kPrimary, width: 3),
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
                              color: ColorConstants.kPrimary, width: 3),
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
                              color: ColorConstants.kPrimary, width: 3),
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
            ),
          );
        });
  }
}
