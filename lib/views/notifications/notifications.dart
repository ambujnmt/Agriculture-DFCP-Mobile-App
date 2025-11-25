import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  final customText = CustomText(), api = API(), helper = Helper();

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

      body: SafeArea(
        child: Container(
          width: width,
          // color: Colors.yellow.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.notifications),

              Expanded(
                child: Container(
                  width: width,
                  // color: Colors.blue.shade200,
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          // height: height * 0.1,
                          width: width,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.01),
                          margin: EdgeInsets.only(bottom: width * 0.02),
                          decoration: BoxDecoration(
                              color: ColorConstants.kGrey,
                              borderRadius: BorderRadius.circular(
                                  width * 0.05)),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications_active_outlined,
                                  size: 30),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              SizedBox(
                                  width: width * 0.73,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      customText.kText(
                                        "New order",
                                        18,
                                        FontWeight.w600,
                                        Colors.black,
                                        TextAlign.start),
                                      customText.kText(
                                        "You got new order from abhishek.",
                                        14,
                                        FontWeight.w500,
                                        Colors.black,
                                        TextAlign.start),
                                    ],
                                  )
                              ),

                            ],
                          ),
                        ),

                        Container(
                          // height: height * 0.1,
                          width: width,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.01),
                          margin: EdgeInsets.only(bottom: width * 0.02),
                          decoration: BoxDecoration(
                              color: ColorConstants.kGrey,
                              borderRadius: BorderRadius.circular(
                                  width * 0.05)),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications_active_outlined,
                                  size: 30),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              SizedBox(
                                  width: width * 0.73,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      customText.kText(
                                          "New meeting scheduled",
                                          18,
                                          FontWeight.w600,
                                          Colors.black,
                                          TextAlign.start),
                                      customText.kText(
                                          "Student scheduled a meeting with you.",
                                          14,
                                          FontWeight.w500,
                                          Colors.black,
                                          TextAlign.start),
                                    ],
                                  )
                              ),

                            ],
                          ),
                        ),

                        Container(
                          // height: height * 0.1,
                          width: width,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.01),
                          margin: EdgeInsets.only(bottom: width * 0.02),
                          decoration: BoxDecoration(
                              color: ColorConstants.kGrey,
                              borderRadius: BorderRadius.circular(
                                  width * 0.05)),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications_active_outlined,
                                  size: 30),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              SizedBox(
                                  width: width * 0.73,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      customText.kText(
                                          "You got ratings",
                                          18,
                                          FontWeight.w600,
                                          Colors.black,
                                          TextAlign.start),
                                      customText.kText(
                                          "You got 4 stars on order no : 2392831.",
                                          14,
                                          FontWeight.w500,
                                          Colors.black,
                                          TextAlign.start),
                                    ],
                                  )
                              ),

                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )

    );
  }
}
