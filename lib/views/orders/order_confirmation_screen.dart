import 'dart:developer';

import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/bottom_navigation/bottom_navigation.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {

  final customText = CustomText();
  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //   child: Container(
          //     margin: const EdgeInsets.only(left: 15),
          //     height: 40,
          //     width: 40,
          //     decoration: const BoxDecoration(
          //         color: ColorConstants.kTextGreen, shape: BoxShape.circle),
          //     child: Center(
          //       child: SizedBox(
          //         height: 25,
          //         child: Image.asset('assets/images/send_image1.png'),
          //       ),
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(builder: (context) => const DashboardScreen()),
          //     );
          //   },
          // ),
          title: customText.kHeadingText(TextConstants.appTitle, 45,
              FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: height * .15,
                  width: width * .35,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/order_success.png'))),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  child: customText.kText(TextConstants.thankYou, 28,
                      FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  child: customText.kText(
                      TextConstants.orderConfirmation,
                      32,
                      FontWeight.w700,
                      ColorConstants.kPrimary,
                      TextAlign.center),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    log("here i am");
                    bottomNavController.selectedIndex.value = 0;
                    bottomNavController.pageController.jumpToPage(0);
                    log("after move to 0");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigation() ));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsListing(comingFrom: "confirmOrder") ));
                  },
                  child: Container(
                    height: height * .050,
                    width: width * .2,
                    decoration: BoxDecoration(
                        color: ColorConstants.kPrimary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: customText.kText(TextConstants.doneButton, 16,
                          FontWeight.w700, Colors.white, TextAlign.start),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
