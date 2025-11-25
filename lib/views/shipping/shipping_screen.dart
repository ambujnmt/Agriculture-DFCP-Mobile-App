import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/cart/view_cart.dart';
import 'package:dfcp/views/orders/order_confirmation_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';

class ShippingScreen extends StatefulWidget {
  final String? productId;
  final int? quantity, price;
  final List<Map<String, dynamic>>? itemsData;
  const ShippingScreen({super.key, this.productId, this.quantity, this.price, this.itemsData});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {

  int selectedPayOption = 1, addressIndex = -1, paymentIndex = -1;
  String selectedAddressId = "", selectedPayment = "";
  bool isApiCalling = false, placingOrder = false;
  final customText = CustomText(), helper = Helper(), api = API();
  List addressesList = [];

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  getAddress() async {
    setState(() {
      isApiCalling = true;
    });

    final response = await api.getAddress();

    setState(() {
      isApiCalling = false;
    });

    if (response["status"] == 1) {
      addressesList = response["addresses"];
      setState(() {});
      log("address list :- $addressesList");
    } else {
      helper.errorDialog(response["message"]);
      if(response["message"] == TextConstants.invalidToken) {
        loginController.clearDataLogout();
        helper.successDialog(TextConstants.logoutSuccess);
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => const ProductsViewScreen()),
        // );
      }
    }
  }


  placeOrder() async {

    log("itemsData before placing order :- ${widget.itemsData}");
    
    if(selectedAddressId.isNotEmpty) {
      if(selectedPayment.isNotEmpty) {
        
        setState(() {
          placingOrder = true;
        });

        final response;
        if(widget.productId != null) {
          response = await api.buyNow(widget.productId!, widget.quantity.toString(), selectedAddressId, selectedPayment);
        } else {
          response = await api.placeOrder(selectedAddressId, selectedPayment, widget.itemsData!);
        }

        setState(() {
          placingOrder = false;
        });

        if(response["status"] == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderConfirmationScreen() ));
        } else {
          helper.errorDialog(response["message"]);
        }
        
      } else {
        helper.errorDialog(TextConstants.selectPayment);
      }
    } else {
      helper.errorDialog(TextConstants.selectAddress);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ViewCartScreen(productId: widget.productId, quantity: widget.quantity, ) ));
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
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ViewCartScreen(productId: widget.productId, quantity: widget.quantity,) ));
            },
          ),
          title: customText.kHeadingText(TextConstants.appTitle, 45,
              FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        ),

        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const CustomTitle(title: TextConstants.selectShippingAddress,),

                isApiCalling
                ? const Center(
                    child: CustomProgressIndicator(),
                  )
                : addressesList.isNotEmpty
                  ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      for(int i = 0; i < addressesList.length ; i++)
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: height * 0.01),
                          decoration: BoxDecoration(
                            border: Border.all(color: addressIndex == i ? ColorConstants.kPrimary : ColorConstants.kGrey),
                            borderRadius: BorderRadius.circular(width * 0.05)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: ColorConstants.kPrimary,
                                      value: addressesList[i]["id"],
                                      groupValue: selectedAddressId,
                                      onChanged: (value) {
                                        selectedAddressId = value;
                                        addressIndex = i;
                                        setState(() {});
                                        log("selected Address :- $selectedAddressId");
                                      }),

                                    addressesList[i]["address_type"] == "Home"
                                    ? const Icon(Icons.home, size: 30)
                                    : addressesList[i]["address_type"] == "Work"
                                      ? const Icon(Icons.work, size: 30)
                                      : const Icon(Icons.apartment, size: 30),

                                    SizedBox(width: width * 0.02),
                                    customText.kText(
                                      addressesList[i]["address_type"],
                                      18,
                                      FontWeight.w800,
                                      Colors.black,
                                      TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * .010),
                                customText.kText(
                                  addressesList[i]["name"],
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start,
                                ),
                                SizedBox(height: height * .010),
                                customText.kText(
                                  addressesList[i]["phone"],
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start,
                                ),
                                SizedBox(height: height * .010),
                                customText.kText(
                                  addressesList[i]["email"],
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start,
                                ),
                                SizedBox(height: height * .010),
                                customText.kText(
                                  "${addressesList[i]["address"]}, ${addressesList[i]["area"]}, ${addressesList[i]["city_name"]}, ${addressesList[i]["state_name"]}, ${addressesList[i]["zipcode"]}",
                                  16,
                                  FontWeight.w400,
                                  Colors.black,
                                  TextAlign.start,
                                  TextOverflow.ellipsis,
                                  5
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          selectedAddressId = addressesList[i]["id"];
                          addressIndex = i;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                )
                  : Container(),

                SizedBox(height: height * .01,),
                const CustomTitle(title: TextConstants.selectPaymentMethod,),

                customText.kText("${TextConstants.pay} ${TextConstants.rupeeSymbol} ${widget.price}", 18, FontWeight.w500, ColorConstants.kPrimary, TextAlign.center),

                SizedBox(height: height * .01,),

                GestureDetector(
                  child: Container(
                    height: height * 0.06,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color: paymentIndex == 1 ? ColorConstants.kPrimary : ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.03)
                    ),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: ColorConstants.kPrimary,
                          value: TextConstants.upi,
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            selectedPayment = value!;
                            paymentIndex = 1;
                            setState(() {});
                          }),
                        customText.kText(TextConstants.upi, 20, FontWeight.w500, Colors.black, TextAlign.start),
                      ],
                    ),
                  ),
                  onTap: () {
                    selectedPayment = TextConstants.upi;
                    paymentIndex = 1;
                    setState(() {});
                  },
                ),

                GestureDetector(
                  child: Container(
                    height: height * 0.06,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color: paymentIndex == 2 ? ColorConstants.kPrimary : ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.03)
                    ),
                    child: Row(
                      children: [
                        Radio(
                            activeColor: ColorConstants.kPrimary,
                            value: TextConstants.debit,
                            groupValue: selectedPayment,
                            onChanged: (value) {
                              selectedPayment = value!;
                              paymentIndex = 2;
                              setState(() {});
                            }),
                        customText.kText(TextConstants.debit, 20, FontWeight.w500, Colors.black, TextAlign.start),
                      ],
                    ),
                  ),
                  onTap: () {
                    selectedPayment = TextConstants.debit;
                    paymentIndex = 2;
                    setState(() {});
                  }
                ),

                GestureDetector(
                  child: Container(
                    height: height * 0.06,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color: paymentIndex == 3 ? ColorConstants.kPrimary : ColorConstants.kGrey),
                        borderRadius: BorderRadius.circular(width * 0.03)
                    ),
                    child: Row(
                      children: [
                        Radio(
                            activeColor: ColorConstants.kPrimary,
                            value: TextConstants.credit,
                            groupValue: selectedPayment,
                            onChanged: (value) {
                              selectedPayment = value!;
                              paymentIndex = 3;
                              setState(() {});
                            }),
                        customText.kText(TextConstants.credit, 20, FontWeight.w500, Colors.black, TextAlign.start),
                      ],
                    ),
                  ),
                  onTap: () {
                    selectedPayment = TextConstants.credit;
                    paymentIndex = 3;
                    setState(() {});
                  },
                ),

                GestureDetector(
                  child: Container(
                    height: height * 0.06,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    decoration: BoxDecoration(
                      border: Border.all(color: paymentIndex == 4 ? ColorConstants.kPrimary : ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.03)
                    ),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: ColorConstants.kPrimary,
                          value: TextConstants.cod,
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            selectedPayment = value!;
                            paymentIndex = 4;
                            setState(() {});
                          }),
                        customText.kText(TextConstants.cod, 20, FontWeight.w500, Colors.black, TextAlign.start),
                      ],
                    ),
                  ),
                  onTap: () {
                    selectedPayment = TextConstants.cod;
                    paymentIndex = 4;
                    setState(() {});
                  },
                ),

                SizedBox(height: height * .01,),
                GestureDetector(
                  onTap: () {
                    placeOrder();
                  },
                  child: Container(
                    height: height * 0.060,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.kPrimary,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Center(
                      child: placingOrder
                        ? const CircularProgressIndicator(color: ColorConstants.kSecondary,)
                        : customText.kText(TextConstants.pay, 22, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                    ),
                  ),
                ),

                SizedBox(height: height * .02,),

              ],
            ),
          ),
        )

      ),
    );
  }
}
