import 'package:data_table_2/data_table_2.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_box.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle,
            45, FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText.kText(
              TextConstants.ordersDashboard,
              30,
              FontWeight.w700,
              ColorConstants.kTextGreen,
              TextAlign.center,
            ),
            const DividerWidget(),
            SizedBox(height: height * .020),
            SizedBox(
              height: height * 0.7,
              width: width,
              // color: Colors.yellow,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText.kText(TextConstants.overview, 25, FontWeight.w400, ColorConstants.kTextGreen, TextAlign.center),
                            const DividerWidget()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * .020),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomBox(
                            textFontSize: 20,
                            countFontSize: 20,
                            textColor: ColorConstants.kYellow,
                            height: height * .17,
                            count: "20",
                            text: TextConstants.newOrder,
                            boxColor: ColorConstants.kTextGreen,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: CustomBox(
                            textFontSize: 20,
                            countFontSize: 20,
                            height: height * .17,
                            count: "50",
                            text: TextConstants.cancelledOrder,
                            boxColor: ColorConstants.kYellow,
                            textColor: ColorConstants.kTextGreen,
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
                            textColor: ColorConstants.kTextGreen,
                            height: height * .17,
                            count: "20",
                            text: TextConstants.orderInProcess,
                            boxColor: ColorConstants.kYellow,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: CustomBox(
                            textFontSize: 20,
                            countFontSize: 20,
                            height: height * .17,
                            count: "50",
                            text: TextConstants.pendingOrder,
                            boxColor: ColorConstants.kTextGreen,
                            textColor: ColorConstants.kYellow,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .020),
                    Center(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText.kText(TextConstants.ordersSummary, 25, FontWeight.w400, ColorConstants.kTextGreen, TextAlign.center),
                            const DividerWidget()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * .020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: horizontalController,
                      child: DataTable(
                        columnSpacing: 5,
                        dataRowHeight: 35,
                        headingRowHeight: 40,
                        border: const TableBorder(
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            horizontalInside: BorderSide(color: Colors.black),
                            verticalInside: BorderSide(color: Colors.black)
                        ),
                        columns: [
                          DataColumn(
                            label: customText.kText(TextConstants.orderNumber, 15, FontWeight.w700, Colors.black, TextAlign.center),
                          ),
                          DataColumn(
                            label: customText.kText(TextConstants.productDetail, 15, FontWeight.w700, Colors.black, TextAlign.center),
                          ),
                          DataColumn(
                            label: customText.kText(TextConstants.qtyBox, 15, FontWeight.w700, Colors.black, TextAlign.center),
                          ),
                          DataColumn(
                            label: customText.kText(TextConstants.status, 15, FontWeight.w700, Colors.black, TextAlign.center),
                          ),
                          DataColumn(
                            label: customText.kText(TextConstants.expectedDeliveryData, 15, FontWeight.w700, Colors.black, TextAlign.center),
                          ),
                        ],
                        rows: List<DataRow>.generate(5, (index) => DataRow(
                            cells: [
                              DataCell(
                                Center(
                                  child: customText.kText('001', 12, FontWeight.w700, Colors.black, TextAlign.center)
                                )
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://media.istockphoto.com/id/466175630/photo/tomato-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=ELzCVzaiRMgiO7A5zQLkuws0N_lvPxrgJWPn7C7BXz0='))),
                                    ),
                                    const SizedBox(width: 10),
                                    customText.kText('Tomato', 12, FontWeight.w700, Colors.black, TextAlign.center)
                                  ],
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: customText.kText('30', 12, FontWeight.w700, Colors.black, TextAlign.center),
                                )
                              ),
                              DataCell(
                                  Center(
                                    child: customText.kText('In Process', 12, FontWeight.w700, Colors.black, TextAlign.center),
                                  )
                              ),
                              DataCell(
                                  Center(
                                    child: customText.kText('Today', 12, FontWeight.w700, Colors.black, TextAlign.center),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
