import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/orders/order_tracking_screen.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

  final customText = CustomText(), api = API(), helper = Helper();
  bool isApiCalling = false;
  List ordersList = [];


  @override
  void initState() {
    super.initState();
    getOrderHistory();
  }

  getOrderHistory() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getOrderHistory();

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {
      setState(() {
        ordersList = response["orders"];
      });
    } else {
      if(response["message"] != TextConstants.invalidToken) {
        helper.alertMessage(response["message"]);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
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
        title: customText.kAppTitle(),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const CustomTitle(title: TextConstants.orderHistory,),

            isApiCalling
            ? const Center(
                child: CustomProgressIndicator(),
              )
            : Expanded(
              child: ListView.builder(
                itemCount: ordersList.length,
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                itemBuilder: (context, index) {
                    return Container(
                      height: height * 0.2,
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.02),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(width * 0.03)
                      ),
                      child: Stack(
                        children: [

                          // side container
                          Container(
                            width: width * 0.12,
                            decoration: BoxDecoration(
                              color: ColorConstants.kPrimary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.03),
                                bottomLeft: Radius.circular(width * 0.03),
                              )
                            ),
                          ),

                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: height * 0.2,
                              width: width * 0.9,
                              margin: EdgeInsets.fromLTRB(width * 0.02, height * 0.01, width * 0.02, 0),
                              // color: Colors.yellow.shade100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    height: height * 0.14,
                                    width: width * 0.3,
                                    margin: EdgeInsets.only(right: width * 0.02),
                                    decoration: BoxDecoration(
                                      // color: ColorConstants.buttonColor
                                      border: Border.all(color: ColorConstants.kSecondary, width: 3),
                                      borderRadius: BorderRadius.circular(width * 0.03),
                                      image: DecorationImage(
                                        image: NetworkImage("${ordersList[index]["order_details"][0]["image_1"]}"),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),

                                  SizedBox(
                                    height: height * 0.13,
                                    width: width * 0.55,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                              text: '${TextConstants.orderId} : ',
                                              style: customText.kTextStyle(16, FontWeight.w700, Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ordersList[index]["order_number"],
                                                style: customText.kTextStyle(16, FontWeight.w400, Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),

                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: '${TextConstants.paymentMethod} : ',
                                            style: customText.kTextStyle(16, FontWeight.w700, Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ordersList[index]["payment_method"],
                                                style: customText.kTextStyle(16, FontWeight.w400, Colors.black)
                                              ),
                                            ],
                                          ),
                                        ),

                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: '${TextConstants.paymentStatus} : ',
                                            style: customText.kTextStyle(16, FontWeight.w700, Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: ordersList[index]["payment_status"],
                                                  style: customText.kTextStyle(14, FontWeight.w400, Colors.black)
                                              ),
                                            ],
                                          ),
                                        ),

                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: '${TextConstants.price} : ',
                                            style: customText.kTextStyle(16, FontWeight.w700, Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "${TextConstants.rupeeSymbol} ${ordersList[index]["total_amount"] }",
                                                  style: customText.kTextStyle(14, FontWeight.w400, Colors.black)
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                                child: Container(
                                  height: height * 0.04,
                                  width: width * 0.25,
                                  margin: EdgeInsets.only(bottom: height * 0.01, right: width * 0.02),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: ColorConstants.kTextGrey, width: 1.5),
                                      borderRadius: BorderRadius.circular(width * 0.02)
                                  ),
                                  child: Center(
                                    child: customText.kText(TextConstants.viewMore, 15, FontWeight.w500, ColorConstants.kTextGrey, TextAlign.center),
                                  )
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingScreen(orderId: ordersList[index]["id"]) ));
                                }
                            ),
                          ),

                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: Padding(
                          //     padding: EdgeInsets.only(bottom: height * 0.01, right: width * 0.02),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.end,
                          //       children: [
                          //
                          //         // SizedBox(
                          //         //   height: height * 0.04,
                          //         //   width: width * 0.32,
                          //         //   child: Center(
                          //         //     child: customText.kText(ordersList[index]["order_status"], 18, FontWeight.w800, ColorConstants.kYellow, TextAlign.start),
                          //         //   )
                          //         // ),
                          //
                          //         // GestureDetector(
                          //         //     child: Container(
                          //         //       height: height * 0.04,
                          //         //       width: width * 0.25,
                          //         //       decoration: BoxDecoration(
                          //         //           border: Border.all(color: ColorConstants.kTextGrey, width: 1.5),
                          //         //           borderRadius: BorderRadius.circular(width * 0.02)
                          //         //       ),
                          //         //       child: Row(
                          //         //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //         //         children: [
                          //         //           const Icon(Icons.delete, color: ColorConstants.kTextGrey,),
                          //         //           customText.kText(TextConstants.cancel, 15, FontWeight.w500, ColorConstants.kTextGrey, TextAlign.center)
                          //         //         ],
                          //         //       ),
                          //         //     ),
                          //         //     onTap: () {
                          //         //       // deleteDialog();
                          //         //     }
                          //         // ),
                          //
                          //         GestureDetector(
                          //           child: Container(
                          //             height: height * 0.04,
                          //             width: width * 0.25,
                          //             decoration: BoxDecoration(
                          //               border: Border.all(color: ColorConstants.kTextGrey, width: 1.5),
                          //               borderRadius: BorderRadius.circular(width * 0.02)
                          //             ),
                          //             child: Center(
                          //               child: customText.kText(TextConstants.viewMore, 15, FontWeight.w500, ColorConstants.kTextGrey, TextAlign.center),
                          //             )
                          //           ),
                          //           onTap: () {
                          //
                          //           }
                          //         ),
                          //
                          //       ],
                          //     ),
                          //   )
                          // )

                        ],
                      ),
                    );
                },
              ),
            )

          ],
        )
      )

    );
  }
}
