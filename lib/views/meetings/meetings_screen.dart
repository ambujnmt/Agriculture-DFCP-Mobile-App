// ignore_for_file: prefer_const_constructors

import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../constants/color_constants.dart';

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
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/add_image.png'))),
        ),
      ),
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
              TextConstants.meetings,
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
            SizedBox(height: height * .025),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
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
                                "Name :-",
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
                                "Date :-",
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
                                "Time :-",
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
                                "Members :-",
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
                                "Description :-",
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
