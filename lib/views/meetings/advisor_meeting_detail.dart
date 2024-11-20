import 'dart:math';

import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/meetings/advisor_meeting.dart';
import 'package:dfcp/views/meetings/schedule_meeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AdvisorMeetingDetail extends StatefulWidget {
  const AdvisorMeetingDetail({super.key});

  @override
  State<AdvisorMeetingDetail> createState() => _AdvisorMeetingDetailState();
}

class _AdvisorMeetingDetailState extends State<AdvisorMeetingDetail> {
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
              MaterialPageRoute(builder: (context) => const AdvisorMeeting()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                customText.kText(
                  TextConstants.advisorDetailText,
                  30,
                  FontWeight.w700,
                  ColorConstants.kTextGreen,
                  TextAlign.center,
                ),
                const DividerWidget(),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    height: height * .200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.kTextGreen,
                        borderRadius: BorderRadius.circular(16)),
                    child: SingleChildScrollView(
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
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: customText.kRichText(
                                      textLeft: TextConstants.name,
                                      textRight: "Anamika",
                                      colorLeft: ColorConstants.kYellow,
                                      colorRight: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: customText.kRichText(
                                      textLeft: TextConstants.mobile,
                                      textRight: "1234567890",
                                      colorLeft: ColorConstants.kYellow,
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
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: customText.kRichText(
                              textLeft: TextConstants.email,
                              textRight: "someone@example.com",
                              colorLeft: ColorConstants.kYellow,
                              colorRight: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: customText.kRichText(
                              textLeft: TextConstants.description,
                              textRight:
                                  "text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry. ",
                              colorLeft: ColorConstants.kYellow,
                              colorRight: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: CustomButton(
                    buttonText: "Schedule Meeting",
                    onpress: () {
                      print("Schedule Meeting");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleMeeting(),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
