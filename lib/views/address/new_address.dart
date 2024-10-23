import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key});

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
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
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            customText.kText(
              TextConstants.addAddress,
              30,
              FontWeight.w700,
              ColorConstants.kTextGreen,
              TextAlign.center,
            ),
            const DividerWidget(),
            SizedBox(height: height * .020),
            Container(
              height: height * .2,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: customText.kText(
                            "Pradeep",
                            16,
                            FontWeight.w400,
                            Colors.black,
                            TextAlign.start,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Text('Edit'),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                child: Text('Delete'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * .010),
                    customText.kText(
                      "12345678990",
                      16,
                      FontWeight.w400,
                      Colors.black,
                      TextAlign.start,
                    ),
                    SizedBox(height: height * .010),
                    customText.kText(
                      "pradeep@gmail.com",
                      16,
                      FontWeight.w400,
                      Colors.black,
                      TextAlign.start,
                    ),
                    SizedBox(height: height * .010),
                    customText.kText(
                      "pradeep@gmail.com",
                      16,
                      FontWeight.w400,
                      Colors.black,
                      TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
