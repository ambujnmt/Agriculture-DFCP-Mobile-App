import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/student_controller.dart';
import 'package:dfcp/custom_widget/custom_drawer.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/notifications/notifications.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  int currentIndex = 0, cropStatus = 0, selectedTab = 1;
  bool isApiCalling = false, isCropActive = false;
  DateTime date = DateTime.now();
  Map<String, dynamic> profileData = {};
  final customText = CustomText(), helper = Helper(), api = API(), box = GetStorage();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController searchController = TextEditingController();
  StudentController studentController = Get.put(StudentController());

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getProfile();

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      setState(() {
        profileData = response["result"];
        studentController.userName = profileData["name"];
      });

      log("profile Data :- $profileData");

    } else {

      helper.errorDialog(response["message"]);

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
          key: _key,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: customText.kHeadingText(TextConstants.appTitle,
              45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
            actions: [
              GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.notifications_active, size: 30,),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen() ));
                },
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    CustomTitle(title: "Hi, ${studentController.userName}",),

                    Container(
                      height: 50,
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: ColorConstants.kGrey,
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          SizedBox(
                            width: width * 0.7,
                            child: TextField(
                                controller: searchController,
                                style: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                                )
                            ),
                          ),

                          const SizedBox(width: 5,),

                          GestureDetector(
                            child: const Center(child: Icon(Icons.search, size: 30,)),
                            onTap: () {
                              log("search button pressed");
                            },
                          )

                        ],
                      ),
                    ),

                    customText.kText(
                      TextConstants.weather,
                      25,
                      FontWeight.w700,
                      ColorConstants.kPrimary,
                      TextAlign.center,
                    ),

                    Container(
                      height: height * 0.25,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.kPrimary, width: 2),
                          borderRadius: BorderRadius.circular(width * 0.05)
                      ),
                      child: Column(
                        children: [

                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                // color: Colors.red.shade200,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(width * 0.05),
                                    topRight: Radius.circular(width * 0.05),
                                  )
                              ),
                              child: Column(
                                children: [

                                  Expanded(
                                    child: Row(
                                      children: [

                                        Container(
                                            height: double.infinity,
                                            width: width * 0.58,
                                            // color: Colors.blue.shade200,
                                            child: Row(
                                              children: [

                                                const Icon(Icons.location_on, size: 26,),
                                                SizedBox(
                                                    width: width * 0.5,
                                                    child: customText.kText("Block H, Sector 63, Noida", 16, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3)
                                                ),


                                              ],
                                            )
                                        ),

                                        Expanded(
                                          child: Container(
                                            // color: Colors.purple.shade200,
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [

                                                  customText.kText(DateFormat("h:mma").format(date).toString(), 14, FontWeight.w500, Colors.black, TextAlign.end),
                                                  customText.kText("${DateFormat('EEE').format(date)} ${date.day}, ${DateFormat('MMMM').format(DateTime(0, date.month)).toString()}", 14, FontWeight.w500, Colors.black, TextAlign.end),


                                                ],
                                              )
                                          ),
                                        )


                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            // width: width * 0.45,
                                            // color: Colors.green.shade200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                customText.kText("Precipitation: 0%", 16, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),
                                                customText.kText("Humidity: 32%", 16, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),
                                                customText.kText("Wind: 19 km/h", 16, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),

                                              ],
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Row(
                                            children: [

                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    customText.kText("26", 28, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),
                                                    customText.kText("Sunny", 20, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),

                          const Divider(color: ColorConstants.kPrimary, thickness: 2, height: 0,),

                          Expanded(
                            child: Container(
                              // height: height * 0.16,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                // color: Colors.yellow.shade200,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(width * 0.05),
                                    bottomRight: Radius.circular(width * 0.05),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customText.kText(TextConstants.visibility, 16, FontWeight.w700, Colors.black, TextAlign.center),
                                      customText.kText("10 Km", 14, FontWeight.w500, Colors.black, TextAlign.center),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      customText.kText(TextConstants.sunrise, 16, FontWeight.w700, Colors.black, TextAlign.center),
                                      customText.kText("5:52 am", 14, FontWeight.w500, Colors.black, TextAlign.center),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      customText.kText(TextConstants.sunset, 16, FontWeight.w700, Colors.black, TextAlign.center),
                                      customText.kText("6:10 pm", 14, FontWeight.w500, Colors.black, TextAlign.center),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    customText.kText(
                      TextConstants.manuringCrops,
                      25,
                      FontWeight.w700,
                      ColorConstants.kPrimary,
                      TextAlign.center,
                    ),

                    Container(
                      height: height * 0.42,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.kPrimary, width: 2),
                          borderRadius: BorderRadius.circular(width * 0.05)
                      ),
                      child: Column(
                        children: [

                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                // color: Colors.red.shade200,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(width * 0.05),
                                    topRight: Radius.circular(width * 0.05),
                                  )
                              ),
                              child: customText.kText("Crop name", 20, FontWeight.w700, Colors.black, TextAlign.start),
                            ),
                          ),

                          const Divider(color: ColorConstants.kPrimary, thickness: 2, height: 0,),

                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText.kText("Manuring\ndate", 14, FontWeight.w600, Colors.black, TextAlign.center),
                                      customText.kText("Est. Harvest\ndate", 14, FontWeight.w600, Colors.black, TextAlign.center),
                                    ],
                                  ),

                                  const SizedBox(height: 5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                        height: height * 0.03,
                                        width: width * 0.07,
                                        decoration: BoxDecoration(
                                            color: cropStatus >= 0 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                            shape: BoxShape.circle
                                        ),
                                      ),

                                      Container(
                                        height: height * 0.002,
                                        width: width * 0.55,
                                        decoration: BoxDecoration(
                                            color: cropStatus >= 1 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                            borderRadius: BorderRadius.circular(width * 0.01)
                                        ),
                                      ),

                                      Container(
                                        height: height * 0.03,
                                        width: width * 0.07,
                                        decoration: BoxDecoration(
                                            color: cropStatus >= 2 ? ColorConstants.kPrimary : ColorConstants.kGrey,
                                            shape: BoxShape.circle
                                        ),
                                      ),

                                    ],
                                  ),

                                  const SizedBox(height: 5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      customText.kText("${DateFormat('EEE').format(date)}, ${date.day} ${DateFormat('MMMM').format(DateTime(0, date.month)).toString()}", 14, FontWeight.w500, Colors.black, TextAlign.center),
                                      customText.kText("${DateFormat('EEE').format(date)}, ${date.day} ${DateFormat('MMMM').format(DateTime(0, date.month)).toString()}", 14, FontWeight.w500, Colors.black, TextAlign.center),
                                    ],
                                  ),

                                  const SizedBox(height: 3),

                                  customText.kText(TextConstants.availableQuantity, 20, FontWeight.w400, Colors.black, TextAlign.center)

                                ],
                              ),
                            ),
                          ),

                          const Divider(color: ColorConstants.kPrimary, thickness: 2, height: 0,),

                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 10,),

                                  SizedBox(
                                    height: height * 0.07,
                                    child: customText.kText("Farmer name", 20, FontWeight.w700, Colors.black, TextAlign.start),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      
                                      customText.kText(TextConstants.distance, 20, FontWeight.w400, Colors.black, TextAlign.center),
                                      customText.kText("10 km", 20, FontWeight.w400, Colors.black, TextAlign.center),

                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: width * 0.01),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.kPrimary,
                                          borderRadius: BorderRadius.circular(width * 0.04),
                                        ),
                                        child: Center(
                                          child: customText.kText(TextConstants.manage, 18, FontWeight.w400, ColorConstants.kSecondary, TextAlign.center)
                                        ),
                                      )

                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      customText.kText(TextConstants.status, 20, FontWeight.w400, Colors.black, TextAlign.center),

                                      Switch(
                                        trackOutlineColor: MaterialStateProperty.resolveWith(
                                              (final Set<MaterialState> states) {
                                            if (states.contains(MaterialState.selected)) {
                                              return null;
                                            }

                                            return Colors.transparent;
                                          },
                                        ),
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: ColorConstants.kSecondary,
                                        value: isCropActive,
                                        onChanged: (bool value) {
                                          setState(() {
                                            isCropActive = value;
                                          });
                                        },
                                      )

                                    ],
                                  )

                                ],
                              ),
                            ),
                          )


                        ],
                      ),
                    ),

                    Row(
                      children: [

                        // const DividerWidget(),

                        GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                customText.kText(
                                  TextConstants.advisors,
                                  25,
                                  FontWeight.w700,
                                  ColorConstants.kPrimary,
                                  TextAlign.center,
                                ),

                                selectedTab == 1
                                ? const DividerWidget()
                                : const SizedBox()

                            ],
                          ),
                          onTap: () {

                            setState(() {
                              selectedTab = 1;
                            });

                          },
                        ),

                        SizedBox(width: width * 0.15,),

                        GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              customText.kText(
                                TextConstants.farmers,
                                25,
                                FontWeight.w700,
                                ColorConstants.kPrimary,
                                TextAlign.center,
                              ),

                              selectedTab == 2
                                ? const DividerWidget()
                                : const SizedBox()

                            ],
                          ),
                          onTap: () {
                            setState(() {
                            selectedTab = 2;
                            });
                          },
                        ),


                      ],
                    ),

                    SizedBox(height: height * 0.02,),

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
                                      textRight: "xyz",
                                      colorLeft: ColorConstants.kSecondary,
                                      colorRight: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
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
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  // image: DecorationImage(
                                  //   fit: BoxFit.fill,
                                  //   image: AssetImage(
                                  //     "assets/images/advisor_image.png",
                                  //   ),
                                  // ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.person, size: 55, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: customText.kRichText(
                              textLeft: TextConstants.email,
                              textRight: "testemail@gmail.com",
                              colorLeft: ColorConstants.kSecondary,
                              colorRight: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // if(loginController.accessToken == null){
                                  //   helper.errorDialog(TextConstants.loginFirst);
                                  // } else {
                                  //   Navigator.pushReplacement(context,
                                  //     MaterialPageRoute(builder: (context) =>
                                  //         UserDetails(details: users[index], userType: 5),
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Container(
                                  child: customText.kText(
                                    TextConstants.readMore,
                                    18,
                                    FontWeight.w700,
                                    ColorConstants.kSecondary,
                                    TextAlign.start,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

}
