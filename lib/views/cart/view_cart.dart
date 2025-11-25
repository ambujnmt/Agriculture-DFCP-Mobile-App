import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/products/product_detail_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dfcp/views/shipping/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'dart:developer';

class ViewCartScreen extends StatefulWidget {

  final String? productId;
  final int? quantity;
  const ViewCartScreen({super.key, this.productId, this.quantity});

  @override
  State<ViewCartScreen> createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {

  String? productId;
  int? quantity;
  bool fetchingProduct = false, deletingProduct = false;
  List productDetails = [], quantityList = [], priceDetails = [];
  int finalSellPrice = 0, finalRegPrice = 0, deleteIndex = -1;
  final customText = CustomText(), helper = Helper(), api = API();

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
    quantity = widget.quantity;
    if(productId != null) {
      getProductDetail(productId!);
    } else {
      getCartItem();
    }
  }

  getProductDetail(String productId) async {

    setState(() {
      fetchingProduct = true;
    });

    final response = await api.getProductDetail(productId);

    setState(() {
      fetchingProduct = false;
    });

    if(response["status"] == 1) {
      productDetails = response["result"];
      finalSellPrice = quantity! * int.parse(productDetails[0]["selling_price"]);
      finalRegPrice = quantity! * int.parse(productDetails[0]["regular_price"]);
      setState(() {});
    } else {
      helper.errorDialog(response["message"]);
    }
  }

  getCartItem() async {

    setState(() {
      fetchingProduct = true;
    });

    final response = await api.getCartItems();

    setState(() {
      fetchingProduct = false;
    });

    if(response["status"] == 1){
      productDetails = response["result"];
      priceDetails = response["price_details"];
      for(int i = 0; i < productDetails.length; i++) {
        quantityList.add(productDetails[i]["cart_qty"]);
      }
      setState(() {});
    } else {
      setState(() {
        productDetails = response["result"];
        priceDetails = response["price_details"];
      });
      if(productDetails.isEmpty) {
        helper.alertMessage(response["message"]);
      } else {
        helper.errorDialog(response["message"]);
      }
    }
  }

  deleteCartItem(String cartId) async {

    setState(() {
      deletingProduct = true;
    });

    final response = await api.deleteCart(cartId);

    setState(() {
      deletingProduct = false;
    });

    if(response["status"] == 1) {
      deleteIndex = -1;
      helper.successDialog(response["message"]);
      getCartItem();
    } else {
      helper.errorDialog(response["message"]);
    }
  }

  updateCartItem(String cartId, String productId, String quantity) async {

    await api.updateCart(cartId, productId, quantity);
    await getCartItem();

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
        ),

        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 5),
            child: fetchingProduct
            ? const Center(
                child: CustomProgressIndicator()
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const CustomTitle(title: TextConstants.cartText,),

                  for(int i = 0; i < productDetails.length; i++)
                  Container(
                    height: height * 0.2,
                    width: width,
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.12,
                              width: width * 0.24,
                              margin: EdgeInsets.only(right: width * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstants.kSecondary, width: 2),
                                borderRadius: BorderRadius.circular(width * 0.02),
                                image: DecorationImage(
                                  image: NetworkImage(productDetails[i]["image_1"]),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: height * 0.08,
                                    width: double.infinity,
                                    child: customText.kText(productDetails[i]["product_name"], 20, FontWeight.w700,
                                        ColorConstants.productNameColor, TextAlign.start)
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      customText.kTextStrikeThrough(
                                        "${TextConstants.rupeeSymbol} ${productDetails[i]["regular_price"]}",
                                        18, FontWeight.w700, Colors.black, TextAlign.start),

                                      customText.kText(
                                        "${TextConstants.rupeeSymbol} ${productDetails[i]["selling_price"]}",
                                        18, FontWeight.w700, Colors.black, TextAlign.start),

                                      customText.kRichTextWithoutSpace(
                                        textLeft: "Qty",
                                        textRight: productId != null ? productDetails[i]["qty"] : productDetails[i]["stock_qty"],
                                        colorLeft: Colors.black,
                                        colorRight: Colors.black),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              height: height * 0.04,
                              width: width * 0.32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: width * 0.08,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(width * 0.025),
                                      ),
                                      child: const Center(child: Icon(Icons.remove)),
                                    ),
                                    onTap: () {

                                      if(productId != null) {
                                        if(quantity! > 1) {
                                          quantity = quantity! - 1;
                                          finalSellPrice = quantity! * int.parse(productDetails[i]["selling_price"]);
                                          finalRegPrice = quantity! * int.parse(productDetails[i]["regular_price"]);
                                          setState(() {});
                                        }
                                      } else {

                                        if(int.parse(quantityList[i]) > 1) {
                                          int temp = int.parse(quantityList[i]) - 1;
                                          quantityList[i] = temp.toString();
                                          setState(() {});
                                          updateCartItem(productDetails[i]["cart_id"], productDetails[i]["product_id"], quantityList[i]);
                                        }

                                      }

                                    },
                                  ),
                                  Container(
                                    height: 25,
                                    width: width * .15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: customText.kText(
                                        productId != null ? "$quantity" : "${quantityList[i]}",
                                        18,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: width * 0.08,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(width * 0.025),
                                      ),
                                      child: const Center(child: Icon(Icons.add)),
                                    ),
                                    onTap: () {

                                      if(productId != null) {
                                        if(quantity! < int.parse(productDetails[i]["qty"])){
                                            quantity = quantity! + 1;
                                            finalSellPrice = quantity! * int.parse(productDetails[i]["selling_price"]);
                                            finalRegPrice = quantity! * int.parse(productDetails[i]["regular_price"]);
                                            setState(() {});
                                        }
                                      } else {

                                        if(int.parse(quantityList[i]) < int.parse(productDetails[i]["stock_qty"])){
                                          int temp = int.parse(quantityList[i]) + 1;
                                          quantityList[i] = temp.toString();
                                          setState(() {});
                                          updateCartItem(productDetails[i]["cart_id"], productDetails[i]["product_id"], quantityList[i]);
                                        }

                                      }

                                    },
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              child: Container(
                                height: height * 0.04,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: deleteIndex == i
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3.0),
                                      child: CircularProgressIndicator(color: Colors.black,),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      customText.kText(
                                        TextConstants.delete,
                                        16,
                                        FontWeight.w700,
                                        Colors.black,
                                        TextAlign.center)
                                    ],
                                  ),
                              ),
                              onTap: () {
                                helper.alertDialog(
                                  context,
                                  TextConstants.deleteAlert,
                                  TextConstants.deleteAlertConfirmation,
                                  () {
                                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                  },
                                  () {
                                    if(productId != null) {
                                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                      Navigator.pop(context);
                                    } else {

                                      log("delete done button pressed");
                                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                      setState(() {
                                        deleteIndex = i;
                                      });
                                      deleteCartItem(productDetails[i]["cart_id"]);

                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  if(productDetails.isNotEmpty)
                  SizedBox(height: height * .040),
                  if(productDetails.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(10),
                    // height: height * .420,
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
                              ColorConstants.kPrimary,
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
                                  ColorConstants.kTextGrey,
                                  TextAlign.start),
                              customText.kRichTextWithoutSpace(
                                textLeft: TextConstants.rupeeSymbol,
                                textRight: productId != null ? finalSellPrice.toString() : priceDetails[0]["total_selling_price"].toString(),
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
                                  ColorConstants.kTextGrey,
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
                          margin: const EdgeInsets.only(bottom: 5),
                          child: customText.kText(
                            "---------------------------",
                            16,
                            FontWeight.w400,
                            ColorConstants.kTextGrey,
                            TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: customText.kText(
                            TextConstants.platFormFeeDescription,
                            16,
                            FontWeight.w400,
                            ColorConstants.kTextGrey,
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
                                  ColorConstants.kTextGrey,
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
                                  TextConstants.gstCharges,
                                  14,
                                  FontWeight.w500,
                                  ColorConstants.kTextGrey,
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
                          margin: const EdgeInsets.only(bottom: 5),
                          child: customText.kText(
                            "---------------------------",
                            16,
                            FontWeight.w400,
                            ColorConstants.kTextGrey,
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
                                  ColorConstants.kPrimary,
                                  TextAlign.start),
                              customText.kTextStrikeThrough(
                                productId != null
                                  ? "${TextConstants.rupeeSymbol} $finalRegPrice"
                                  : "${TextConstants.rupeeSymbol} ${priceDetails[0]["total_regular_price"]}",
                                18, FontWeight.w700, Colors.black, TextAlign.center),
                              customText.kRichTextWithoutSpace(
                                textLeft: TextConstants.rupeeSymbol,
                                textRight: productId != null ? finalSellPrice.toString() : priceDetails[0]["total_selling_price"].toString(),
                                colorLeft: Colors.black,
                                colorRight: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if(productDetails.isNotEmpty)
                  CustomButton(
                    buttonText: TextConstants.buttonText,
                    onpress: () {

                      List<Map<String, dynamic>> items = [];
                      if(productId == null) {
                        setState(() {
                          finalSellPrice = priceDetails[0]["total_selling_price"];
                        });
                        for (int i = 0; i < productDetails.length; i++) {
                          items.add({
                            "cart_id": productDetails[i]["cart_id"],
                            "product_id": productDetails[i]["product_id"],
                            "qty": quantityList[i]
                          });
                        }
                      }

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingScreen(
                        productId: productId, quantity: quantity, price: finalSellPrice, itemsData: items) ));
                    },
                  ),

                  SizedBox(height: height * 0.03,),
                ],
              ),
          ),
        ),
      ),
    );
  }
}



// const SizedBox(height: 10),
// customText.kText(TextConstants.productDescription, 20,
//     FontWeight.w700, ColorConstants.kYellow, TextAlign.start),
// const SizedBox(height: 10),
// customText.kText(
//     "Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
//     16,
//     FontWeight.w400,
//     Colors.black,
//     TextAlign.start,
//   TextOverflow.visible,
//   25,
// ),

