import 'package:carousel_slider/carousel_slider.dart';
import 'package:dfcp/admin/products/add_product.dart';
import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/cart/view_cart.dart';
import 'package:dfcp/views/products/product_review.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:developer';
import 'package:get/get.dart';


class ProductDetailScreen extends StatefulWidget {
  final String? productId;
  const ProductDetailScreen({super.key, this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final customText = CustomText(), helper = Helper(), api = API();
  bool isApiCalling = false, isOwnProduct = false, productAdding = false;
  int currentIndex = 0, availableUnits = 0, selectedQuantity = 1;
  Map<String, dynamic> productDetail = {};
  List imagesList = [];

  LoginController loginController = Get.put(LoginController());
  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  getProductDetail() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getProductDetail(widget.productId!);

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      productDetail = response["result"][0];
      availableUnits = int.parse(productDetail["qty"].toString().split(" ")[0]);
      if(productDetail["user_id"] == loginController.userId){
        setState(() {
          isOwnProduct = true;
        });
      }
      for(int i = 1; i < 6; i++) {
        if(productDetail["image_$i"] != "") {
          imagesList.add(productDetail["image_$i"]);
        }
      }
      setState(() {});

      log("images list at product detail screen :- $imagesList");

    } else {
      helper.errorDialog(response["message"]);
    }

    log("product details in product details & imagesList :- $productDetail $imagesList");

  }

  addToCart() async {

    setState(() {
      productAdding = true;
    });

    final response = await api.addToCart(productDetail["product_id"], selectedQuantity.toString());

    setState(() {
      productAdding = false;
    });

    if(response["status"] == 1) {
      helper.successDialog(response["message"]);
      Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsListing(comingFrom: "addToCart",) ));
      // bottomNavController.selectedIndex.value = 1;
      // bottomNavController.pageController.jumpToPage(1);
    } else {
      helper.errorDialog(response["message"]);
    }

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      child: Scaffold(
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
          actions: [
            if(isOwnProduct)
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.015, right: width * 0.02),
                  child: Icon(Icons.edit, size: 30, color: ColorConstants.kPrimary),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    AddProduct(productId: productDetail["product_id"], comingFrom: "productDetail") ));
                },
              )
          ],
        ),
        body: SafeArea(
          child: Container(
            // color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: productDetail.isEmpty
              ? const Center(
                  child: CustomProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomTitle(title: productDetail["product_name"],),

                    CarouselSlider(
                      items: [

                        for(int i = 0; i < imagesList.length; i++)
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(imagesList[i]),
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
                        dotsCount: imagesList.length,
                        position: currentIndex,
                        decorator: const DotsDecorator(
                          color: ColorConstants.kSecondary, // Inactive color
                          activeColor: ColorConstants.kPrimary,
                        ),
                      ),
                    ),

                    SizedBox(height: height * .020),
                    Container(
                      child: customText.kText(
                          productDetail["short_desc"],
                          20,
                          FontWeight.w600,
                          Colors.black,
                          TextAlign.center,
                          TextOverflow.visible,
                          1000
                      ),
                    ),

                    SizedBox(height: height * .020),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          customText.kText("Category : ", 16, FontWeight.w600, ColorConstants.kPrimary, TextAlign.center),

                          customText.kText(productDetail["cat_name"], 16, FontWeight.w400, Colors.black, TextAlign.start),

                        ],
                      ),
                    ),

                    SizedBox(height: height * .020),
                    Container(
                      child: customText.kText(
                        productDetail["long_desc"],
                        16,
                        FontWeight.w400,
                        Colors.black,
                        TextAlign.start,
                        TextOverflow.visible,
                        1000
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
                            child: customText.kTextStrikeThrough(
                              "₹ ${productDetail["regular_price"]}",
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
                          child: Center(
                            child: customText.kText(
                              "₹ ${productDetail["selling_price"]}",
                              20,
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
                              GestureDetector(
                                child: const Icon(Icons.remove),
                                onTap: () {
                                  if(selectedQuantity > 1) {
                                    setState(() {
                                      selectedQuantity -= 1;
                                    });
                                  }
                                },
                              ),
                              Container(
                                child: customText.kText(selectedQuantity.toString(), 16, FontWeight.w700,
                                    Colors.black, TextAlign.center),
                              ),
                              GestureDetector(
                                child: const Icon(Icons.add),
                                onTap: () {
                                  if(selectedQuantity < availableUnits) {
                                    setState(() {
                                      selectedQuantity += 1;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * .005),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: customText.kText("${TextConstants.availableQuantity} : $availableUnits Kg", 16, FontWeight.w400,
                          ColorConstants.kPrimary, TextAlign.end),
                    ),

                    SizedBox(height: height * .020),
                    CustomButton(
                      buttonText: TextConstants.buyNow,
                      onpress: () {
                        if(loginController.userId != null) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewCartScreen(
                              productId: productDetail["product_id"],
                              quantity: selectedQuantity)
                          ));
                        } else {
                          helper.errorDialog(TextConstants.loginFirst);
                        }
                      },
                    ),

                    SizedBox(height: height * .020),
                    GestureDetector(
                      onTap: () {
                        if(loginController.userId != null) {
                          addToCart();
                        } else {
                          helper.errorDialog(TextConstants.loginFirst);
                        }
                      },
                      child: Container(
                        height: height * 0.060,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstants.kPrimary,
                          borderRadius: BorderRadius.circular(width * 0.04),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(2, 4), color: Colors.black45, blurRadius: 9.9)
                          ],
                        ),
                        child: Center(
                          child: productAdding
                              ? CircularProgressIndicator(color: ColorConstants.kSecondary,)
                              : Text(
                                  TextConstants.addToCart,
                                  style: customText.kTextStyle(
                                    22, FontWeight.w700, ColorConstants.kSecondary),
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * .020),
                    Container(
                      height: height * 0.12,
                      width: width,
                      decoration: BoxDecoration(
                        // color: Colors.yellow.shade200
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          customText.kText(TextConstants.ratingReview, 20, FontWeight.w700, Colors.black, TextAlign.start),

                          GestureDetector(
                            child: Container(
                              height: height * 0.05,
                              width: width,
                              // color: Colors.red.shade200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  RatingBar.builder(
                                    itemSize: 20,
                                    initialRating: 4,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                    },
                                  ),
                                  
                                  customText.kText("4 out of 5", 20, FontWeight.w400, Colors.black, TextAlign.center),
                            
                                  Container(
                                    width: width * 0.3,
                                    // color: Colors.blue.shade200,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        customText.kText(TextConstants.viewAll, 20, FontWeight.w700, Colors.black, TextAlign.center),
                                        const Icon(Icons.arrow_forward_ios, size: 20)
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductReview() ));
                            },
                          ),

                          customText.kText("1200 Rating & Review", 18, FontWeight.w100, Colors.black, TextAlign.center)

                        ],
                      ),
                    )

                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}



// GestureDetector(
// onTap: () {
// if(loginController.userId != null) {
// addToCart();
// } else {
// helper.errorDialog(TextConstants.loginFirst);
// }
// },
// child: Container(
// height: height * 0.060,
// width: double.infinity,
// decoration: BoxDecoration(
// color: ColorConstants.kTextGreen,
// borderRadius: BorderRadius.circular(width * 0.04),
// ),
// child: Center(
// child: productAdding
// ? const CircularProgressIndicator(color: ColorConstants.kYellow,)
//     : Text(
// TextConstants.addToCart,
// style: customText.kTextStyle(
// 22, FontWeight.w700, ColorConstants.kYellow),
// ),
// ),
// ),
// ),
