import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/meetings/add_meeting.dart';
import 'package:dfcp/views/meetings/all_usersListing.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:get/get.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {

  bool isApiCalling = false;
  final customText = CustomText(), api = API(), helper = Helper();
  List meetingList = [];

  LoginController loginController = Get.put(LoginController());
  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  void initState() {
    super.initState();
    getMeetings();
  }

  getMeetings() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.meetingList();

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      setState(() {
        meetingList = response["result"];
      });

    } else {
      helper.errorDialog(response["message"]);
      if(response["message"] == TextConstants.invalidToken) {
        loginController.clearDataLogout();
        helper.successDialog(TextConstants.logoutSuccess);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ProductsViewScreen()),
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => helper.alertDialog(context, TextConstants.exitFromApp,
        TextConstants.exitAppDesc,
          () { ScaffoldMessenger.of(context).removeCurrentSnackBar();},
          () { SystemNavigator.pop();}
      ),
      child: Scaffold(
        appBar: AppBar(
          // leading: GestureDetector(
          //   child: Container(
          //     margin: const EdgeInsets.only(left: 15),
          //     height: 40,
          //     width: 40,
          //     decoration: const BoxDecoration(
          //         color: ColorConstants.kPrimary, shape: BoxShape.circle),
          //     child: Center(
          //       child: SizedBox(
          //         height: 25,
          //         child: Image.asset('assets/images/send_image1.png'),
          //       ),
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset("assets/images/dashboard_icon.png"),
            ),
            onTap: () {
              bottomNavController.selectedIndex.value = 0;
              bottomNavController.pageController.jumpToPage(0);
            },
          ),
          title: customText.kHeadingText(TextConstants.appTitle, 45,
              FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const CustomTitle(title: TextConstants.meetings,),

                  isApiCalling
                  ?  const Center(
                    child: CustomProgressIndicator(),
                  )
                  : Expanded(
                    child: ListView.builder(
                      // padding: EdgeInsets.only(bottom: width * 0.05),
                      itemCount: meetingList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.kPrimary,
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
                                      ColorConstants.kSecondary,
                                      TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: width * .6,
                                    child: customText.kText(
                                      meetingList[index]["meeting_person_name"],
                                      18,
                                      FontWeight.w700,
                                      Colors.white,
                                      TextAlign.start,
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
                                      "${TextConstants.email} :-",
                                      18,
                                      FontWeight.w700,
                                      ColorConstants.kSecondary,
                                      TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: width * .65,
                                    child: customText.kText(
                                      meetingList[index]["meeting_person_email"],
                                      18,
                                      FontWeight.w700,
                                      Colors.white,
                                      TextAlign.start,
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
                                      ColorConstants.kSecondary,
                                      TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: width * .65,
                                    child: customText.kText(
                                      meetingList[index]["meeting_date"],
                                      18,
                                      FontWeight.w700,
                                      Colors.white,
                                      TextAlign.start,
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
                                      ColorConstants.kSecondary,
                                      TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: width * .65,
                                    child: customText.kText(
                                      meetingList[index]["meeting_time"],
                                      18,
                                      FontWeight.w700,
                                      Colors.white,
                                      TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       child: customText.kText(
                              //         "${TextConstants.members} :-",
                              //         18,
                              //         FontWeight.w700,
                              //         ColorConstants.kYellow,
                              //         TextAlign.center,
                              //       ),
                              //     ),
                              //     const SizedBox(width: 10),
                              //     Container(
                              //       child: customText.kText(
                              //         "Students, Farmers",
                              //         18,
                              //         FontWeight.w700,
                              //         Colors.white,
                              //         TextAlign.center,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: customText.kText(
                                      "${TextConstants.description} :-",
                                      18,
                                      FontWeight.w700,
                                      ColorConstants.kSecondary,
                                      TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: width * .5,
                                    child: customText.kText(
                                      meetingList[index]["meeting_purpose"],
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
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: height * 0.05),
                ],
              ),
            ),
            // Container(
            //   height: 55,
            //   width: width,
            //   color: ColorConstants.kPrimary,
            // ),
            // Positioned(
            //   bottom: 20,
            //   child: GestureDetector(
            //     child: Container(
            //       height: 75,
            //       width: width,
            //       padding: const EdgeInsets.all(10),
            //       decoration: const BoxDecoration(
            //           color: Colors.white, shape: BoxShape.circle),
            //       child: Image.asset('assets/images/add_image.png'),
            //     ),
            //     onTap: () {
            //       log("meeting add button pressed");
            //       // Navigator.push(
            //       //     context,
            //       //     MaterialPageRoute(
            //       //         builder: (context) => const AddMeeting()));
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const AllUsersListing(),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
        floatingActionButton: GestureDetector(
          child: Container(
            height: 55,
            width: 55,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: ColorConstants.kSecondary, width: 3),
                shape: BoxShape.circle
            ),
            child: Center(
              child: Image.asset("assets/images/add_image.png"),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMeeting() ));
          },
        ),
      ),
    );
  }
}
