import 'package:carousel_slider/carousel_slider.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final customText = CustomText();
  int currentIndex = 0;

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
                  builder: (context) => const ProductsViewScreen()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText.kText(
                TextConstants.details,
                30,
                FontWeight.w700,
                ColorConstants.kTextGreen,
                TextAlign.center,
              ),
              DividerWidget(),
              SizedBox(
                height: height * .030,
              ),
              CarouselSlider(
                items: [
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/veg_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/wheat.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/tamato.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 2,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: 3,
                  position: currentIndex,
                  decorator: const DotsDecorator(
                    color: ColorConstants.kYellow, // Inactive color
                    activeColor: ColorConstants.kTextGreen,
                  ),
                ),
              ),
              SizedBox(height: height * .020),
              Container(
                child: customText.kText(
                  "Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                  16,
                  FontWeight.w400,
                  Colors.black,
                  TextAlign.start,
                ),
              ),
              SizedBox(height: height * .010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * .050,
                    width: width * .30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Center(
                      child: customText.kText(
                        "₹ 500",
                        16,
                        FontWeight.w700,
                        Colors.black,
                        TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: height * .050,
                    width: width * .30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: const Icon(Icons.remove),
                        ),
                        Container(
                          child: customText.kText("1", 16, FontWeight.w700,
                              Colors.black, TextAlign.center),
                        ),
                        Container(
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .005),
              Container(
                child: customText.kText("In Stock", 16, FontWeight.w400,
                    ColorConstants.kTextGreen, TextAlign.start),
              ),
              SizedBox(height: height * .020),
              CustomButton(
                buttonText: TextConstants.byNow,
                onpress: () {},
              ),
              SizedBox(height: height * .010),
              GestureDetector(
                onTap: () {
                  // onpress
                },
                child: Container(
                  height: height * 0.060,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.kTextGreen,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  child: Center(
                    child: Text(
                      TextConstants.addToCart,
                      style: customText.kTextStyle(
                          22, FontWeight.w700, ColorConstants.kYellow),
                    ),
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
