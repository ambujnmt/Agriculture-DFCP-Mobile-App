import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/meetings/advisor_meeting.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'add_meeting.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                customText.kText(
                  TextConstants.meetings,
                  30,
                  FontWeight.w700,
                  ColorConstants.kTextGreen,
                  TextAlign.center,
                ),
                const DividerWidget(),
                // Container(
                //   height: 5,
                //   width: width * .2,
                //   decoration: BoxDecoration(
                //     color: ColorConstants.kYellow,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                // ),
                SizedBox(height: height * .025),
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      height: height * .24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.kTextGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: customText.kText(
                                  "${TextConstants.name} :-",
                                  18,
                                  FontWeight.w700,
                                  ColorConstants.kYellow,
                                  TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                child: customText.kText(
                                  "Developer",
                                  18,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: customText.kText(
                                  "${TextConstants.date} :-",
                                  18,
                                  FontWeight.w700,
                                  ColorConstants.kYellow,
                                  TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                child: customText.kText(
                                  "22/08/2025",
                                  18,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: customText.kText(
                                  "${TextConstants.time} :-",
                                  18,
                                  FontWeight.w700,
                                  ColorConstants.kYellow,
                                  TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                child: customText.kText(
                                  "5:38 PM",
                                  18,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: customText.kText(
                                  "${TextConstants.members} :-",
                                  18,
                                  FontWeight.w700,
                                  ColorConstants.kYellow,
                                  TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                child: customText.kText(
                                  "Students, Farmers",
                                  18,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: customText.kText(
                                  "${TextConstants.description} :-",
                                  18,
                                  FontWeight.w700,
                                  ColorConstants.kYellow,
                                  TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: width * .5,
                                child: customText.kText(
                                  "Important meetings",
                                  18,
                                  FontWeight.w700,
                                  Colors.white,
                                  TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 55,
            width: width,
            color: ColorConstants.kPrimary,
          ),
          Positioned(
            bottom: 20,
            child: GestureDetector(
              child: Container(
                height: 75,
                width: width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Image.asset('assets/images/add_image.png'),
              ),
              onTap: () {
                log("meeting add button pressed");
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const AddMeeting()));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdvisorMeeting(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
