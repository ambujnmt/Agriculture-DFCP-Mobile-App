import 'package:data_table_2/data_table_2.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_box.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/orders/order_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class OrdersDashboardScreen extends StatefulWidget {
  const OrdersDashboardScreen({super.key});

  @override
  State<OrdersDashboardScreen> createState() => _OrdersDashboardScreenState();
}

class _OrdersDashboardScreenState extends State<OrdersDashboardScreen> {

  final customText = CustomText();
  ScrollController horizontalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const DashboardScreen()),
            // );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle,
            45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.manageOrders,),

              Container(
                height: height * 0.8,
                width: width,
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomBox(
                              textFontSize: 20,
                              countFontSize: 20,
                              textColor: ColorConstants.kSecondary,
                              height: height * 0.18,
                              count: "20",
                              text: TextConstants.newOrder,
                              boxColor: ColorConstants.kPrimary,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: CustomBox(
                              textFontSize: 20,
                              countFontSize: 20,
                              height: height * 0.18,
                              count: "50",
                              text: TextConstants.cancelledOrder,
                              boxColor: ColorConstants.kSecondary,
                              textColor: ColorConstants.kPrimary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomBox(
                              textFontSize: 20,
                              countFontSize: 20,
                              textColor: ColorConstants.kPrimary,
                              height: height * 0.18,
                              count: "20",
                              text: TextConstants.orderInProcess,
                              boxColor: ColorConstants.kSecondary,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: CustomBox(
                              textFontSize: 20,
                              countFontSize: 20,
                              height: height * 0.18,
                              count: "50",
                              text: TextConstants.pendingOrder,
                              boxColor: ColorConstants.kPrimary,
                              textColor: ColorConstants.kSecondary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * .020),

                      Container(
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
                                          // image: DecorationImage(
                                          //     image: NetworkImage("{ordersList[index][order_details][0][image_1]}"),
                                          //     fit: BoxFit.cover
                                          // )
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
                                                  text: "",
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
                                                    text: "",
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
                                                    text: "",
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
                                                    text: "${TextConstants.rupeeSymbol}",
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
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingScreen(orderId: ordersList[index]["id"]) ));
                                  }
                              ),
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 0.01, right: width * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    // SizedBox(
                                    //   height: height * 0.04,
                                    //   width: width * 0.32,
                                    //   child: Center(
                                    //     child: customText.kText(ordersList[index]["order_status"], 18, FontWeight.w800, ColorConstants.kYellow, TextAlign.start),
                                    //   )
                                    // ),

                                    // GestureDetector(
                                    //     child: Container(
                                    //       height: height * 0.04,
                                    //       width: width * 0.25,
                                    //       decoration: BoxDecoration(
                                    //           border: Border.all(color: ColorConstants.kTextGrey, width: 1.5),
                                    //           borderRadius: BorderRadius.circular(width * 0.02)
                                    //       ),
                                    //       child: Row(
                                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //         children: [
                                    //           const Icon(Icons.delete, color: ColorConstants.kTextGrey,),
                                    //           customText.kText(TextConstants.cancel, 15, FontWeight.w500, ColorConstants.kTextGrey, TextAlign.center)
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     onTap: () {
                                    //       // deleteDialog();
                                    //     }
                                    // ),

                                    GestureDetector(
                                      child: Container(
                                        height: height * 0.04,
                                        width: width * 0.25,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: ColorConstants.kTextGrey, width: 1.5),
                                          borderRadius: BorderRadius.circular(width * 0.02)
                                        ),
                                        child: Center(
                                          child: customText.kText(TextConstants.viewMore, 15, FontWeight.w500, ColorConstants.kTextGrey, TextAlign.center),
                                        )
                                      ),
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingScreen() ));
                                      }
                                    ),

                                  ],
                                ),
                              )
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: height * .08),
          
            ],
          ),
        ),
      ),
    );
  }
}





// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   controller: horizontalController,
//   child: DataTable(
//     columnSpacing: 5,
//     dataRowHeight: 35,
//     headingRowHeight: 40,
//     border: const TableBorder(
//         top: BorderSide(color: Colors.black),
//         left: BorderSide(color: Colors.black),
//         bottom: BorderSide(color: Colors.black),
//         right: BorderSide(color: Colors.black),
//         horizontalInside: BorderSide(color: Colors.black),
//         verticalInside: BorderSide(color: Colors.black)
//     ),
//     columns: [
//       DataColumn(
//         label: customText.kText(TextConstants.orderNumber, 15, FontWeight.w700, Colors.black, TextAlign.center),
//       ),
//       DataColumn(
//         label: customText.kText(TextConstants.productDetail, 15, FontWeight.w700, Colors.black, TextAlign.center),
//       ),
//       DataColumn(
//         label: customText.kText(TextConstants.qtyBox, 15, FontWeight.w700, Colors.black, TextAlign.center),
//       ),
//       DataColumn(
//         label: customText.kText(TextConstants.status, 15, FontWeight.w700, Colors.black, TextAlign.center),
//       ),
//       DataColumn(
//         label: customText.kText(TextConstants.expectedDeliveryData, 15, FontWeight.w700, Colors.black, TextAlign.center),
//       ),
//     ],
//     rows: List<DataRow>.generate(10, (index) => DataRow(
//         cells: [
//           DataCell(
//             Center(
//               child: customText.kText('001', 12, FontWeight.w700, Colors.black, TextAlign.center)
//             )
//           ),
//           DataCell(
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   decoration: const BoxDecoration(
//                       color: Colors.red,
//                       image: DecorationImage(
//                           image: NetworkImage(
//                               'https://media.istockphoto.com/id/466175630/photo/tomato-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=ELzCVzaiRMgiO7A5zQLkuws0N_lvPxrgJWPn7C7BXz0='))),
//                 ),
//                 const SizedBox(width: 10),
//                 customText.kText('Tomato', 12, FontWeight.w700, Colors.black, TextAlign.center)
//               ],
//             ),
//           ),
//           DataCell(
//             Center(
//               child: customText.kText('30', 12, FontWeight.w700, Colors.black, TextAlign.center),
//             )
//           ),
//           DataCell(
//               Center(
//                 child: customText.kText('In Process', 12, FontWeight.w700, Colors.black, TextAlign.center),
//               )
//           ),
//           DataCell(
//               Center(
//                 child: customText.kText('Today', 12, FontWeight.w700, Colors.black, TextAlign.center),
//               )
//           ),
//         ],
//       ),
//     ),
//   ),
// ),

// SizedBox(height: height * .020),
// Center(
//   child: SizedBox(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         customText.kText(TextConstants.ordersSummary, 25, FontWeight.w400, ColorConstants.kTextGreen, TextAlign.center),
//         const DividerWidget()
//       ],
//     ),
//   ),
// ),


// Center(
//   child: SizedBox(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         customText.kText(TextConstants.overview, 25, FontWeight.w400, ColorConstants.kTextGreen, TextAlign.center),
//         const DividerWidget(),
//       ],
//     ),
//   ),
// ),