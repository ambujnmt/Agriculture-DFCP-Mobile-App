import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/orders/order_confirmation_screen.dart';
import 'package:dfcp/views/orders/order_tracking_screen.dart';
import 'package:dfcp/views/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class ViewCartScreen extends StatefulWidget {
  const ViewCartScreen({super.key});

  @override
  State<ViewCartScreen> createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
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
              MaterialPageRoute(
                  builder: (context) => const ProductDetailScreen()),
            );
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
                TextConstants.cartText,
                30,
                FontWeight.w700,
                ColorConstants.kTextGreen,
                TextAlign.center,
              ),
              const DividerWidget(),
              SizedBox(
                height: height * .030,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(5),
                    height: height * .1,
                    width: width * .25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorConstants.kYellow,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/veg_image.png'),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customText.kText("Tomato", 20, FontWeight.w700,
                            ColorConstants.productNameColor, TextAlign.start),
                        const SizedBox(height: 10),
                        Container(
                          width: width * .56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText.kRichTextWithoutSpace(
                                  textLeft: TextConstants.rupeeSymbol,
                                  textRight: "100",
                                  colorLeft: Colors.black,
                                  colorRight: Colors.black),
                              customText.kRichTextWithoutSpace(
                                  textLeft: "Qty",
                                  textRight: "100",
                                  colorLeft: Colors.black,
                                  colorRight: Colors.black),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                height: 25,
                                width: width * .1,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: customText.kText(
                                      "+",
                                      18,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.center),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                height: 25,
                                width: width * .15,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: customText.kText(
                                      "1",
                                      18,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.center),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 25,
                                width: width * .1,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: customText.kText(
                                      "-",
                                      18,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.center),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: width * .18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.delete,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 10),
                                    customText.kText(
                                        "Delete",
                                        12,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              customText.kText(TextConstants.productDescription, 20,
                  FontWeight.w700, ColorConstants.kYellow, TextAlign.start),
              const SizedBox(height: 10),
              customText.kText(
                  "Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                  16,
                  FontWeight.w400,
                  Colors.black,
                  TextAlign.start),
              SizedBox(height: height * .040),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                height: height * .420,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: customText.kText(
                          TextConstants.billDetails,
                          20,
                          FontWeight.w700,
                          ColorConstants.kTextGreen,
                          TextAlign.start),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText.kText(
                              TextConstants.itemTotal,
                              14,
                              FontWeight.w500,
                              ColorConstants.greyEight,
                              TextAlign.start),
                          customText.kRichTextWithoutSpace(
                            textLeft: TextConstants.rupeeSymbol,
                            textRight: "100",
                            colorLeft: Colors.black,
                            colorRight: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText.kText(
                              TextConstants.deliveryFee,
                              14,
                              FontWeight.w500,
                              ColorConstants.greyEight,
                              TextAlign.start),
                          customText.kRichTextWithoutSpace(
                            textLeft: TextConstants.rupeeSymbol,
                            textRight: "20",
                            colorLeft: Colors.black,
                            colorRight: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: customText.kText(
                        "----------------------------",
                        16,
                        FontWeight.w400,
                        ColorConstants.greyEight,
                        TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: customText.kText(
                        TextConstants.platFormFeeDescription,
                        16,
                        FontWeight.w400,
                        ColorConstants.greyEight,
                        TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText.kText(
                              TextConstants.platFormFee,
                              14,
                              FontWeight.w500,
                              ColorConstants.greyEight,
                              TextAlign.start),
                          customText.kRichTextWithoutSpace(
                            textLeft: TextConstants.rupeeSymbol,
                            textRight: "00",
                            colorLeft: Colors.black,
                            colorRight: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText.kText(
                              TextConstants.gstAndRestarantCharges,
                              14,
                              FontWeight.w500,
                              ColorConstants.greyEight,
                              TextAlign.start),
                          customText.kRichTextWithoutSpace(
                            textLeft: TextConstants.rupeeSymbol,
                            textRight: "50",
                            colorLeft: Colors.black,
                            colorRight: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: customText.kText(
                        "-------------------------------------",
                        16,
                        FontWeight.w400,
                        ColorConstants.greyEight,
                        TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText.kText(
                              TextConstants.toPayText,
                              20,
                              FontWeight.w700,
                              ColorConstants.kTextGreen,
                              TextAlign.start),
                          customText.kRichTextWithoutSpace(
                            textLeft: TextConstants.rupeeSymbol,
                            textRight: "250",
                            colorLeft: Colors.black,
                            colorRight: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const OrderConfirmationScreen(),
                  //   ),
                  // );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderTrackingScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  height: height * .060,
                  width: double.infinity,
                  child: SliderButton(
                    action: () async {
                      return true;
                    },

                    label: customText.kText("${TextConstants.sliderToPay} 150 ",
                        20, FontWeight.w700, Colors.white, TextAlign.start),
                    icon: Center(
                        child: Icon(
                      Icons.keyboard_double_arrow_right,
                      color: ColorConstants.productNameColor,
                      size: 40.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    )),

                    ///Change All the color and size from here.
                    width: 230,
                    radius: 36,
                    buttonColor: Colors.white,
                    backgroundColor: ColorConstants.kTextGreen,
                    highlightedColor: Colors.white,
                    // baseColor: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
