import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/user_controller.dart';
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
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  int currentIndex = 0;
  bool isApiCalling = false;
  Map<String, dynamic> profileData = {};
  final customText = CustomText(), helper = Helper(), api = API(), box = GetStorage();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  UserController userController = Get.put(UserController());
  TextEditingController searchController = TextEditingController();

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
        userController.userName = profileData["name"];
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

                    CustomTitle(title: "Hi, ${userController.userName}",),

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

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

}
