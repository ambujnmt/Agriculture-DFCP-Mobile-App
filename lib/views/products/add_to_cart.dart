import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/products/product_detail_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const DashboardScreen()),
            // );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText.kText(
              TextConstants.cart,
              30,
              FontWeight.w700,
              ColorConstants.kPrimary,
              TextAlign.center,
            ),
            DividerWidget(),
            SizedBox(height: height * .020),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int intex) => Card(
                  elevation: 4,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: height * .18,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: height * .1,
                              width: width * .2,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/wheat.png'))),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * .6,
                                    height: height * .050,
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: customText.kEllipseText(
                                      "Product title Product title Product title Product title t title Product title Product title",
                                      16,
                                      FontWeight.w700,
                                      Colors.black,
                                      TextAlign.start,
                                      TextOverflow.ellipsis,
                                      2,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    width: width * .6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              customText.kText(
                                                "Price: ",
                                                12,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start,
                                              ),
                                              customText.kText(
                                                  "₹ 400",
                                                  12,
                                                  FontWeight.w700,
                                                  Colors.black,
                                                  TextAlign.start),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              customText.kText(
                                                "Available: ",
                                                12,
                                                FontWeight.w400,
                                                Colors.black,
                                                TextAlign.start,
                                              ),
                                              customText.kText(
                                                  "20",
                                                  12,
                                                  FontWeight.w700,
                                                  Colors.black,
                                                  TextAlign.start),
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
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * .040,
                                width: width * .3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: const Icon(
                                        Icons.remove,
                                        size: 16,
                                      ),
                                    ),
                                    Container(
                                      child: customText.kText(
                                          "1",
                                          16,
                                          FontWeight.w700,
                                          Colors.black,
                                          TextAlign.center),
                                    ),
                                    Container(
                                      child: const Icon(Icons.add, size: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * .040,
                                width: width * .3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 18,
                                      ),
                                    ),
                                    Container(
                                      child: customText.kText(
                                          "Remove",
                                          14,
                                          FontWeight.w700,
                                          Colors.redAccent,
                                          TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
