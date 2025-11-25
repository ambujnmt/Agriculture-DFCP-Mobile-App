import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/ratings_reviews/ratings_reviews.dart';
import 'package:flutter/material.dart';
import '../../custom_widget/custom_title.dart';
import 'dart:developer';

class OrderTrackingScreen extends StatefulWidget {
  final String? orderId;
  const OrderTrackingScreen({super.key, this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {

  bool isApiCalling = false;
  int progressStatus = 0;
  String orderStatus = "";
  final customText = CustomText(), api = API(), helper = Helper();
  Map<String, dynamic> orderDetails = {};

  @override
  void initState() {
    super.initState();
    getOrderDetails();
  }

  getOrderDetails() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getOrderDetails(widget.orderId!);

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1){

      orderDetails = response["order"];
      orderStatus = orderDetails["order_status"];
      if(orderStatus == "Confirmed"){
        progressStatus = 0;
      } else if(orderStatus == "Shipped"){
        progressStatus = 1;
      } else if(orderStatus == "Out for Delivery"){
        progressStatus = 2;
      } else if(orderStatus == "Delivered"){
        progressStatus = 3;
      }
      
      setState(() {});

    } else {

    }

  }

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitle(title: TextConstants.orderTracking,),
              isApiCalling
              ? const Center(
                  child: CustomProgressIndicator(),
                )
              : Wrap(
                children: [

                  SizedBox(height: height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText.kText("${TextConstants.orderId}: ${orderDetails["order_number"]}",
                        20,
                        FontWeight.w700,
                        ColorConstants.lightGreyColor,
                        TextAlign.start,
                      ),

                      GestureDetector(
                        child: Container(
                          height: height * .040,
                          width: width * .22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.02),
                            border: Border.all(
                              color: ColorConstants.lightGreyColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sticky_note_2, color: ColorConstants.lightGreyColor, size: 20,),
                              customText.kText(TextConstants.invoice, 15, FontWeight.w400, ColorConstants.lightGreyColor, TextAlign.start)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * .07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(
                        width: width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.calendar_month, color: ColorConstants.lightGreyColor,),
                            SizedBox(
                              width: width * 0.28,
                              child: customText.kText(
                                "${TextConstants.orderDate}\n${orderDetails["created_at"].toString().split(" ")[0]}",
                                15,
                                FontWeight.w400,
                                ColorConstants.lightGreyColor,
                                TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: height * 0.04,
                        width: 2,
                        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                        color: ColorConstants.lightGreyColor,
                      ),

                      SizedBox(
                        width: width * 0.48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.local_shipping, color: ColorConstants.kPrimary,),
                            SizedBox(
                              width: width * 0.41,
                              child: customText.kText(
                                "${TextConstants.estimatedDelivery}\n${TextConstants.oneToFourBusinessDays}",
                                15,
                                FontWeight.w400,
                                ColorConstants.kPrimary,
                                TextAlign.center,
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * .07),
                  SizedBox(
                    height: height * 0.09,
                    // color:Colors.yellow.shade200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: customText.kText(
                                TextConstants.orderConfirm, 14, FontWeight.w400,
                                progressStatus >= 0 ? ColorConstants.kPrimary : ColorConstants.lightGreyColor, TextAlign.center),
                            ),
                            Expanded(
                              child: customText.kText(
                                TextConstants.shipped, 14, FontWeight.w400,
                                progressStatus >= 1 ? ColorConstants.kPrimary : ColorConstants.lightGreyColor, TextAlign.center),
                            ),
                            Expanded(
                              child: customText.kText(
                                TextConstants.outForDelivery, 14, FontWeight.w400,
                                progressStatus >= 2 ? ColorConstants.kPrimary : ColorConstants.lightGreyColor, TextAlign.center),
                            ),
                            Expanded(
                              child: customText.kText(
                                TextConstants.delivered, 14, FontWeight.w400,
                                progressStatus >= 3 ? ColorConstants.kPrimary : ColorConstants.lightGreyColor, TextAlign.center),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              height: height * 0.03,
                              width: width * 0.07,
                              decoration: BoxDecoration(
                                color: progressStatus >= 0 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                shape: BoxShape.circle
                              ),
                            ),

                            Container(
                              height: height * 0.002,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                color: progressStatus >= 1 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                borderRadius: BorderRadius.circular(width * 0.01)
                              ),
                            ),

                            Container(
                              height: height * 0.03,
                              width: width * 0.07,
                              decoration: BoxDecoration(
                                  color: progressStatus >= 1 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                  shape: BoxShape.circle
                              ),
                            ),

                            Container(
                              height: height * 0.002,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  color: progressStatus >= 2 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                  borderRadius: BorderRadius.circular(width * 0.01)
                              ),
                            ),

                            Container(
                              height: height * 0.03,
                              width: width * 0.07,
                              decoration: BoxDecoration(
                                  color: progressStatus >= 2 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                  shape: BoxShape.circle
                              ),
                            ),

                            Container(
                              height: height * 0.002,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  color: progressStatus >= 3 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                  borderRadius: BorderRadius.circular(width * 0.01)
                              ),
                            ),

                            Container(
                              height: height * 0.03,
                              width: width * 0.07,
                              decoration: BoxDecoration(
                                  color: progressStatus >= 3 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                  shape: BoxShape.circle
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Divider(color: ColorConstants.lightGreyColor.withOpacity(.5), height: 0,),
                  ),

                  for(int i = 0; i < orderDetails["order_details"].length; i++)
                  Container(
                    height: height * 0.1,
                    // color: Colors.yellow.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorConstants.kSecondary, width: 2),
                            borderRadius: BorderRadius.circular(width * 0.03),
                            image: DecorationImage(
                              image: NetworkImage(orderDetails["order_details"][i]["image_1"]),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.5,
                          // color: Colors.green.shade200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // color: Colors.red.shade200,
                                width: width * 0.5,
                                // margin: EdgeInsets.only(left: width * 0.03),
                                child: customText.kText(orderDetails["order_details"][i]["product_name"], 18, FontWeight.w700,
                                  Colors.black, TextAlign.start, ),
                              ),
                              SizedBox(height: height * 0.005),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customText.kText(
                                      "${TextConstants.qty} ${orderDetails["order_details"][i]["qty"]}",
                                      16,
                                      FontWeight.w400,
                                      ColorConstants.lightGreyColor,
                                      TextAlign.center),
                                  customText.kText("${TextConstants.rupeeSymbol} ${orderDetails["order_details"][i]["total_price"]}", 16, FontWeight.w700,
                                      ColorConstants.lightGreyColor, TextAlign.center),
                                ],
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: SizedBox(
                            width: width * 0.15,
                            child: const ImageIcon(
                              AssetImage("assets/images/feedback.png"),
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                          onTap: () {},
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Divider(color: ColorConstants.lightGreyColor.withOpacity(.5), height: 0,),
                  ),

                  Container(
                    // color: Colors.yellow.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: customText.kText(
                                    TextConstants.paymentMethod,
                                    16,
                                    FontWeight.w800,
                                    Colors.black,
                                    TextAlign.start),
                              ),

                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: customText.kText(orderDetails["payment_method"], 14, FontWeight.w500,
                                    Colors.black, TextAlign.start),
                              ),


                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: customText.kText(
                                    TextConstants.paymentStatus,
                                    16,
                                    FontWeight.w800,
                                    Colors.black,
                                    TextAlign.start),
                              ),
                              customText.kText(orderDetails["payment_status"], 14, FontWeight.w500,
                                  Colors.black, TextAlign.start),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: customText.kText(
                                    TextConstants.delivery,
                                    16,
                                    FontWeight.w800,
                                    Colors.black,
                                    TextAlign.start),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: customText.kText(
                                    orderDetails["address"]["name"],
                                    14,
                                    FontWeight.w500,
                                    Colors.black,
                                    TextAlign.start),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: customText.kText(
                                    orderDetails["address"]["phone"],
                                    14,
                                    FontWeight.w500,
                                    Colors.black,
                                    TextAlign.start),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: customText.kText(
                                    "${orderDetails["address"]["address"]}, ${orderDetails["address"]["area"]}, "
                                    "${orderDetails["address"]["city_name"]}, ${orderDetails["address"]["state_name"]}, "
                                    "${orderDetails["address"]["zipcode"]}",
                                    14,
                                    FontWeight.w500,
                                    Colors.black,
                                    TextAlign.start,
                                    TextOverflow.visible,
                                    5
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Divider(color: ColorConstants.lightGreyColor.withOpacity(.5), height: 0,),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: customText.kText(
                            TextConstants.orderSum,
                            16,
                            FontWeight.w800,
                            Colors.black,
                            TextAlign.start),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 10),
                      //   child: Row(
                      //     mainAxisAlignment:
                      //     MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       customText.kText(
                      //           TextConstants.discount,
                      //           14,
                      //           FontWeight.w500,
                      //           ColorConstants.lightGreyColor,
                      //           TextAlign.start),
                      //       customText.kText(
                      //           "5544",
                      //           14,
                      //           FontWeight.w500,
                      //           ColorConstants.lightGreyColor,
                      //           TextAlign.start),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                                "${TextConstants.rupeeSymbol} 00",
                                14,
                                FontWeight.w500,
                                ColorConstants.lightGreyColor,
                                TextAlign.start),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText.kText(
                                TextConstants.deliveryFee,
                                14,
                                FontWeight.w500,
                                ColorConstants.lightGreyColor,
                                TextAlign.start),
                            customText.kText(
                                "${TextConstants.rupeeSymbol} 00",
                                14,
                                FontWeight.w500,
                                ColorConstants.lightGreyColor,
                                TextAlign.start),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                                "${TextConstants.rupeeSymbol} 00",
                                14,
                                FontWeight.w500,
                                ColorConstants.lightGreyColor,
                                TextAlign.start),
                          ],
                        ),
                      ),
                      customText.kText(
                          "----------------------",
                          16,
                          FontWeight.w400,
                          ColorConstants.lightGreyColor,
                          TextAlign.start),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
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
                            customText.kText("${TextConstants.rupeeSymbol} ${orderDetails["total_amount"]}", 18, FontWeight.w800,
                                Colors.black, TextAlign.start),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: width * 0.6,
                      margin: EdgeInsets.only(top: height * 0.02, bottom: height * 0.03),
                      child: CustomButton(
                        buttonText: TextConstants.ratingReview,
                        onpress: () {
                          // log("Order details :- $orderDetails");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RatingsReviews(orderDetails: orderDetails) ));
                        },
                      ),
                    )
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



// SizedBox(
//   height: height * 0.01,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     customText.kText(TextConstants.home, 10, FontWeight.w400,
//         ColorConstants.lightGreyColor, TextAlign.start),
//     const SizedBox(width: 5),
//     Icon(
//       Icons.keyboard_arrow_right_outlined,
//       size: 14,
//       color: ColorConstants.lightGreyColor,
//     ),
//     const SizedBox(width: 5),
//     customText.kText(TextConstants.order, 10, FontWeight.w400,
//         ColorConstants.lightGreyColor, TextAlign.start),
//     const SizedBox(width: 5),
//     Icon(
//       Icons.keyboard_arrow_right_outlined,
//       size: 14,
//       color: ColorConstants.lightGreyColor,
//     ),
//     const SizedBox(width: 5),
//     customText.kText(
//         "${TextConstants.id} 1234567890",
//         10,
//         FontWeight.w400,
//         ColorConstants.lightGreyColor,
//         TextAlign.start),
//   ],
// ),
// SizedBox(height: height * .020),


// child: Center(
//   child: TextButton.icon(
//     onPressed: () {},
//     icon: Icon(
//       Icons.note,
//       color: ColorConstants.lightGreyColor,
//       size: 12,
//     ),
//     label: customText.kText(
//       "Invoice",
//       10,
//       FontWeight.w600,
//       ColorConstants.lightGreyColor,
//       TextAlign.start,
//     ),
//   ),
// ),


// Expanded(
//   flex: 1,
//   child: Container(
//     child: customText.kText(
//         "${TextConstants.orderId}: ${orderDetails["order_number"]}",
//         14,
//         FontWeight.w700,
//         ColorConstants.lightGreyColor,
//         TextAlign.start),
//   ),
// ),
// Expanded(
//   flex: 1,
//   child: Container(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                   color: ColorConstants.lightGreyColor,
//                   width: 1)),
//           height: height * .050,
//           width: width * .22,
//           child: Center(
//             child: TextButton.icon(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.note,
//                   color: ColorConstants.lightGreyColor,
//                   size: 12,
//                 ),
//                 label: customText.kText(
//                     "Invoice",
//                     10,
//                     FontWeight.w600,
//                     ColorConstants.lightGreyColor,
//                     TextAlign.start)),
//           ),
//         ),
//         // Container(
//         //   decoration: BoxDecoration(
//         //     borderRadius: BorderRadius.circular(12),
//         //     color: ColorConstants.purpleColor,
//         //   ),
//         //   margin: EdgeInsets.only(left: 5),
//         //   height: height * .050,
//         //   width: width * .22,
//         //   child: Center(
//         //     child: TextButton.icon(
//         //         onPressed: () {},
//         //         icon: const Icon(
//         //           Icons.location_on,
//         //           color: Colors.white,
//         //           size: 12,
//         //         ),
//         //         label: customText.kText(
//         //             "Track Order",
//         //             10,
//         //             FontWeight.w600,
//         //             Colors.white,
//         //             TextAlign.start)),
//         //   ),
//         // )
//       ],
//     ),
//   ),
// ),


// customText.kText("16 Feb 2022", 14, FontWeight.w700,
//     Colors.black, TextAlign.start),


// Container(
//   margin: const EdgeInsets.only(right: 10),
//   child: const Icon(
//     // Icons.deli
//     Icons.car_crash_sharp,
//     color: ColorConstants.kTextGreen,
//   ),
// ),
// Expanded(
//   child: customText.kText(
//       "${TextConstants.estimatedDelivery} : 16 May, 2022",
//       14,
//       FontWeight.w400,
//       ColorConstants.kTextGreen,
//       TextAlign.start),
// ),

// child: customText.kText(
//   "${TextConstants.orderDate}\n16 Feb 2022",
//   15,
//   FontWeight.w400,
//   ColorConstants.lightGreyColor,
//   TextAlign.start,
// ),


// Expanded(
//   flex: 1,
//   child: Container(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: 10),
//           child: customText.kText(
//               TextConstants.needHelp,
//               16,
//               FontWeight.w800,
//               Colors.black,
//               TextAlign.start),
//         ),
//         Container(
//           margin: EdgeInsets.only(bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.info_outline,
//                 color: ColorConstants.lightGreyColor,
//                 size: 18,
//               ),
//               SizedBox(width: 5),
//               customText.kText(
//                   TextConstants.orderInfo,
//                   14,
//                   FontWeight.w500,
//                   ColorConstants.lightGreyColor,
//                   TextAlign.start),
//               SizedBox(width: 5),
//               Icon(
//                 Icons.arrow_outward_outlined,
//                 color: ColorConstants.lightGreyColor,
//                 size: 18,
//               )
//             ],
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.car_crash_outlined,
//                 color: ColorConstants.lightGreyColor,
//                 size: 18,
//               ),
//               SizedBox(width: 5),
//               customText.kText(
//                   TextConstants.deliveryInfo,
//                   14,
//                   FontWeight.w500,
//                   ColorConstants.lightGreyColor,
//                   TextAlign.start),
//               SizedBox(width: 5),
//               Icon(
//                 Icons.arrow_outward_outlined,
//                 color: ColorConstants.lightGreyColor,
//                 size: 18,
//               )
//             ],
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.cabin,
//                 color: ColorConstants.lightGreyColor,
//                 size: 18,
//               ),
//               SizedBox(width: 5),
//               customText.kText(
//                   TextConstants.returns,
//                   14,
//                   FontWeight.w500,
//                   ColorConstants.lightGreyColor,
//                   TextAlign.start),
//               SizedBox(width: 5),
//               Icon(
//                 Icons.arrow_outward_outlined,
//                 color: ColorConstants.lightGreyColor,
//                 size: 18,
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),


// Container(
//   // color: Colors.blue.shade200,
//   child: Column(
//     children: [
//
//       Row(
//         children: [
//
//           Container(
//             width: width * 0.3,
//             // color: Colors.red.shade200,
//             child: customText.kText(
//               TextConstants.payment,
//               16,
//               FontWeight.w800,
//               Colors.black,
//               TextAlign.start,
//             ),
//           ),
//
//           Container(
//             width: width * 0.6,
//             // color: Colors.green.shade200,
//             child: customText.kText("VISA", 14, FontWeight.w500,
//                 Colors.black, TextAlign.start),
//           )
//
//         ],
//       ),
//
//       SizedBox(height: height * 0.01),
//
//       Row(
//         children: [
//
//           Container(
//             width: width * 0.3,
//             // color: Colors.red.shade200,
//             child: customText.kText(
//               TextConstants.delivery,
//               16,
//               FontWeight.w800,
//               Colors.black,
//               TextAlign.start,
//             ),
//           ),
//
//           Container(
//             width: width * 0.6,
//             // color: Colors.green.shade200,
//             child: customText.kText("847 Jewess Bridge Apt., 174 London, UK \n 474-769-3919", 14, FontWeight.w500,
//                 Colors.black, TextAlign.start),
//           )
//
//         ],
//       ),
//
//     ],
//   ),
// ),
//
// SizedBox(height: height * 0.3,),