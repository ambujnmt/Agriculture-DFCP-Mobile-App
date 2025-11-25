import 'package:dfcp/admin/affiliate/affiliate_order_detail.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class AffiliateDetails extends StatefulWidget {
  const AffiliateDetails({super.key});

  @override
  State<AffiliateDetails> createState() => _AffiliateDetailsState();
}

class _AffiliateDetailsState extends State<AffiliateDetails> {

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.affiliate,),

              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                // height: height * .200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.kPrimary,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: customText.kRichText(
                                textLeft: TextConstants.name,
                                textRight: "Anamika",
                                colorLeft: ColorConstants.kSecondary,
                                colorRight: Colors.white,
                              ),
                            ),
                            Container(
                              margin: const  EdgeInsets.only(bottom: 10),
                              child: customText.kRichText(
                                textLeft: TextConstants.mobile,
                                textRight: "1234567890",
                                colorLeft: ColorConstants.kSecondary,
                                colorRight: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          height: height * .08,
                          width: width * .200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/advisor_image.png",
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: customText.kRichText(
                        textLeft: TextConstants.email,
                        textRight: "someone@example.com",
                        colorLeft: ColorConstants.kSecondary,
                        colorRight: Colors.white,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: customText.kRichText(
                        textLeft: TextConstants.address,
                        textRight: "Electronic city metro station, Sector 63, Noida",
                        colorLeft: ColorConstants.kSecondary,
                        colorRight: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),

              DataTable(
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
                      width: width * 0.22,
                      child: const Center(
                        child: Text(TextConstants.years),
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
                    label: SizedBox (
                      width: width * 0.15,
                      child: const Center(
                        child: Text(TextConstants.details),
                      ),
                    ),
                  ),
                ],
                rows: [
                  for (int i = 0; i < 18; i++)
                  DataRow(
                    cells: [
                      DataCell(
                        Center(
                          child: Text((i+1).toString()),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text((2024+i).toString()),
                        ),
                      ),
                      const DataCell(
                        Center(
                          child: Text("50000"),
                        ),
                      ),
                      DataCell(
                        const Center(
                          child: Text(TextConstants.view),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AffiliateOrderDetails() ));
                        }
                      )
                    ]
                  )
                ]
              ),

              const SizedBox(height: 10),

            ],
          ),
        )
      ),
    );
  }
}
