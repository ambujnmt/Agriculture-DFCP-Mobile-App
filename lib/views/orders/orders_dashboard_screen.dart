import 'package:data_table_2/data_table_2.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_box.dart';
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
              child: Image.asset('assets/images/send_image.png'),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: Image.asset("assets/images/dfcp_image.png"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            customText.kText(
              TextConstants.ordersDashboard,
              30,
              FontWeight.w700,
              ColorConstants.kTextGreen,
              TextAlign.center,
            ),
            Container(
              height: 5,
              width: width * .2,
              decoration: BoxDecoration(
                color: ColorConstants.kYellow,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: height * .020),
            const Center(
                child: Text(
              TextConstants.overview,
              style: TextStyle(
                color: ColorConstants.kTextGreen,
                fontFamily: "Red Rose",
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            )),
            Container(
              margin: const EdgeInsets.only(left: 115),
              height: 5,
              width: width * .2,
              decoration: BoxDecoration(
                color: ColorConstants.kYellow,
                borderRadius: BorderRadius.circular(12),
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
            const Text(
              TextConstants.ordersSummary,
              style: TextStyle(
                color: ColorConstants.kTextGreen,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: "Red Rose",
              ),
            ),
            Container(
              height: 5,
              width: width * .2,
              decoration: BoxDecoration(
                color: ColorConstants.kYellow,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: height * .020),
            Expanded(
              child: Container(
                child: DataTable2(
                  columnSpacing: 6,
                  horizontalMargin: 6,
                  minWidth: 600,
                  border: const TableBorder(
                    right: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    horizontalInside: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    verticalInside: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  columns: [
                    DataColumn(
                      label: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey),
                      ),
                    ),
                    const DataColumn2(
                      label: Text(
                        'Order No.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Red Rose"),
                      ),
                      size: ColumnSize.L,
                    ),
                    const DataColumn(
                      label: Text(
                        'Product Detail',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Red Rose"),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        'Qty/Box',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Red Rose"),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Red Rose"),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        'Expected Delivery Data',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Red Rose"),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    5,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const DataCell(Text(
                          '001',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Red Rose"),
                        )),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              const Text(
                                'Tamato',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Red Rose"),
                              ),
                            ],
                          ),
                        ),
                        const DataCell(Text(
                          '30',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Red Rose"),
                        )),
                        const DataCell(Text(
                          'In Process',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Red Rose"),
                        )),
                        const DataCell(Text(
                          'Today',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Red Rose"),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
