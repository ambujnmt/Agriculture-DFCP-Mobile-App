import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class AffiliateOrderDetails extends StatefulWidget {
  const AffiliateOrderDetails({super.key});

  @override
  State<AffiliateOrderDetails> createState() => _AffiliateOrderDetailsState();
}

class _AffiliateOrderDetailsState extends State<AffiliateOrderDetails> {

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
        centerTitle: true,
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const CustomTitle(title: TextConstants.affiliate,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                    verticalInside: BorderSide(color: Colors.black)),
                columns: [
                  const DataColumn(
                    label: Center(
                      child: Text(TextConstants.srNo),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: width * 0.25,
                      child: const Center(
                        child: Text(TextConstants.orderId),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: width * 0.25,
                      child: const Center(
                        child: Text(TextConstants.items),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox (
                      width: width * 0.3,
                      child: const Center(
                        child: Text(TextConstants.description),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: width * 0.25,
                      child: const Center(
                        child: Text(TextConstants.amount),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: width * 0.25,
                      child: const Center(
                        child: Text(TextConstants.date),
                      ),
                    ),
                  ),
                ],
                rows: const [
                  DataRow(
                      cells: [
                        DataCell(
                          Center(
                            child: Text("01"),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text("43280948234"),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text("Tomato"),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text("xyz"),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text("100"),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text("16.12.2024"),
                          ),
                        ),
                      ]
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      )
    );
  }

}
