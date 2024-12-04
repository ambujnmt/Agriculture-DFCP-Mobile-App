import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/orders/progress_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const ProductDetailScreen()),
            // );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText.kText(
                TextConstants.orderTracking,
                30,
                FontWeight.w700,
                ColorConstants.kTextGreen,
                TextAlign.center,
              ),
              DividerWidget(),
              SizedBox(
                height: height * .030,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(TextConstants.home, 10, FontWeight.w400,
                      ColorConstants.lightGreyColor, TextAlign.start),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 14,
                    color: ColorConstants.lightGreyColor,
                  ),
                  const SizedBox(width: 5),
                  customText.kText(TextConstants.order, 10, FontWeight.w400,
                      ColorConstants.lightGreyColor, TextAlign.start),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 14,
                    color: ColorConstants.lightGreyColor,
                  ),
                  const SizedBox(width: 5),
                  customText.kText(
                      "${TextConstants.id} 1234567890",
                      10,
                      FontWeight.w400,
                      ColorConstants.lightGreyColor,
                      TextAlign.start),
                ],
              ),
              SizedBox(height: height * .020),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: customText.kText(
                          "${TextConstants.orderId}: 1234567890",
                          14,
                          FontWeight.w700,
                          ColorConstants.lightGreyColor,
                          TextAlign.start),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: ColorConstants.lightGreyColor,
                                    width: 1)),
                            height: height * .050,
                            width: width * .22,
                            child: Center(
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.note,
                                    color: ColorConstants.lightGreyColor,
                                    size: 12,
                                  ),
                                  label: customText.kText(
                                      "Invoice",
                                      10,
                                      FontWeight.w600,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorConstants.purpleColor,
                            ),
                            margin: EdgeInsets.only(left: 5),
                            height: height * .050,
                            width: width * .22,
                            child: Center(
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  label: customText.kText(
                                      "Track Order",
                                      10,
                                      FontWeight.w600,
                                      Colors.white,
                                      TextAlign.start)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .020),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: customText.kText(
                        "${TextConstants.orderDate} : ",
                        10,
                        FontWeight.w400,
                        ColorConstants.lightGreyColor,
                        TextAlign.start),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: customText.kText("16 Feb 2022", 14, FontWeight.w700,
                        Colors.black, TextAlign.start),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 12,
                    width: 1,
                    color: ColorConstants.lightGreyColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.car_crash_sharp,
                      color: ColorConstants.kTextGreen,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: customText.kText(
                          "${TextConstants.estimatedDelivery} : 16 May, 2022",
                          12,
                          FontWeight.w400,
                          ColorConstants.kTextGreen,
                          TextAlign.start),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .010),
              Divider(color: ColorConstants.lightGreyColor.withOpacity(.5)),
              Container(
                width: double.infinity,
                child: ProgressStepperScreen(),
              ),
              SizedBox(height: height * .010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: height * .070,
                        width: width * .100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/veg_image.png'),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: customText.kText("Tomato", 16, FontWeight.w400,
                            ColorConstants.lightGreyColor, TextAlign.start),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: customText.kText("599.0", 16, FontWeight.w700,
                              Colors.black, TextAlign.start),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: customText.kText(
                              "${TextConstants.qty} : 2",
                              16,
                              FontWeight.w400,
                              ColorConstants.lightGreyColor,
                              TextAlign.start),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: ColorConstants.lightGreyColor.withOpacity(.5)),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  "${TextConstants.payment}",
                                  14,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            customText.kText("VISA", 14, FontWeight.w500,
                                Colors.black, TextAlign.start),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  "${TextConstants.delivery}",
                                  14,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  "${TextConstants.address}",
                                  14,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  "847 Jewess Bridge Apt.",
                                  14,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  "174 London, UK",
                                  14,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  "474-769-3919",
                                  14,
                                  FontWeight.w500,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .010),
              Divider(color: ColorConstants.lightGreyColor.withOpacity(.5)),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  TextConstants.needHelp,
                                  16,
                                  FontWeight.w800,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: ColorConstants.lightGreyColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  customText.kText(
                                      TextConstants.orderInfo,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_outward_outlined,
                                    color: ColorConstants.lightGreyColor,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.car_crash_outlined,
                                    color: ColorConstants.lightGreyColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  customText.kText(
                                      TextConstants.deliveryInfo,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_outward_outlined,
                                    color: ColorConstants.lightGreyColor,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.cabin,
                                    color: ColorConstants.lightGreyColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  customText.kText(
                                      TextConstants.returns,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_outward_outlined,
                                    color: ColorConstants.lightGreyColor,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: customText.kText(
                                  TextConstants.orderSum,
                                  16,
                                  FontWeight.w800,
                                  Colors.black,
                                  TextAlign.start),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      TextConstants.discount,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  customText.kText(
                                      "5544",
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      TextConstants.discount,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  customText.kText(
                                      "5544",
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      TextConstants.delivery,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  customText.kText(
                                      "5544",
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      TextConstants.orderTax,
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  customText.kText(
                                      "5544",
                                      14,
                                      FontWeight.w500,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                ],
                              ),
                            ),
                            customText.kText(
                                "--------------------",
                                16,
                                FontWeight.w400,
                                ColorConstants.lightGreyColor,
                                TextAlign.start),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText.kText(
                                      TextConstants.orderTotal,
                                      18,
                                      FontWeight.w800,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.start),
                                  customText.kText("5544", 18, FontWeight.w800,
                                      Colors.black, TextAlign.start),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
