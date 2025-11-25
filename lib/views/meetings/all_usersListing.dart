// ignore_for_file: prefer_const_constructors

import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/meetings/user_detail.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:developer';

class AllUsersListing extends StatefulWidget {
  const AllUsersListing({super.key});

  @override
  State<AllUsersListing> createState() => _AllUsersListingState();
}

class _AllUsersListingState extends State<AllUsersListing> {

  int selectedIndex = 2;
  bool isApiCalling = false;
  final customText = CustomText(), api = API(), helper = Helper();
  List advisors = [], farmers = [], students = [], users = [];

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    getMembersList("2");
  }

  getMembersList(String userType) async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getMembersList(userType);

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      userType == "2"
        ? advisors = response["result"]
        : userType == "3"
          ? farmers = response["result"]
          : userType == "4"
            ? students = response["result"]
            : users = response["result"];

      setState(() {});
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
          margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                selectedIndex == 2
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText.kText(
                          TextConstants.advisors,
                          18,
                          FontWeight.w700,
                          ColorConstants.kPrimary,
                          TextAlign.center,
                        ),

                        const DividerWidget(),

                        SizedBox(height: height * 0.01,)
                      ],
                    )
                  : GestureDetector(
                    child: customText.kText(
                      TextConstants.advisors,
                      16,
                      FontWeight.w500,
                      ColorConstants.kPrimary,
                      TextAlign.center,
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                      getMembersList("2");
                    },
                  ),

                SizedBox(width: width * 0.04,),

                selectedIndex == 3
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText.kText(
                          TextConstants.farmers,
                          18,
                          FontWeight.w700,
                          ColorConstants.kPrimary,
                          TextAlign.center,
                        ),

                        const DividerWidget(),

                        SizedBox(height: height * 0.01,)
                      ],
                    )
                  : GestureDetector(
                    child: customText.kText(
                      TextConstants.farmers,
                      16,
                      FontWeight.w500,
                      ColorConstants.kPrimary,
                      TextAlign.center,
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                      getMembersList("3");
                    },
                  ),

                SizedBox(width: width * 0.04,),

                selectedIndex == 4
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    TextConstants.students,
                    18,
                    FontWeight.w700,
                    ColorConstants.kPrimary,
                    TextAlign.center,
                  ),

                  const DividerWidget(),

                  SizedBox(height: height * 0.01,)
                ],
              )
                  : GestureDetector(
                child: customText.kText(
                  TextConstants.students,
                  16,
                  FontWeight.w500,
                  ColorConstants.kPrimary,
                  TextAlign.center,
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  getMembersList("4");
                },
              ),

                SizedBox(width: width * 0.04,),

                selectedIndex == 5
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    TextConstants.users,
                    18,
                    FontWeight.w700,
                    ColorConstants.kPrimary,
                    TextAlign.center,
                  ),

                  const DividerWidget(),

                  SizedBox(height: height * 0.01,)
                ],
              )
                  : GestureDetector(
                child: customText.kText(
                  TextConstants.users,
                  16,
                  FontWeight.w500,
                  ColorConstants.kPrimary,
                  TextAlign.center,
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 5;
                  });
                  getMembersList("5");
                },
              ),
              ],
            ),

            isApiCalling
            ? Center(child: CustomProgressIndicator())
            : Expanded(
              child: SizedBox(
                child:
                selectedIndex == 2
                ? ListView.builder(
                    itemCount: advisors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
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
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: customText.kRichText(
                                        textLeft: TextConstants.name,
                                        textRight: advisors[index]["name"],
                                        colorLeft: ColorConstants.kSecondary,
                                        colorRight: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: customText.kRichText(
                                        textLeft: TextConstants.mobile,
                                        textRight: advisors[index]["mobile"],
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
                                  child: Center(
                                    child: Icon(Icons.person, size: 55, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: customText.kRichText(
                                textLeft: TextConstants.email,
                                textRight: advisors[index]["email"],
                                colorLeft: ColorConstants.kSecondary,
                                colorRight: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    log("check access token :- ${loginController.accessToken}");
                                    if(loginController.accessToken == null){
                                      helper.errorDialog(TextConstants.loginFirst);
                                    } else {
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                          UserDetails(details: advisors[index], userType: 2),
                                        ),
                                      );
                                    }
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
                      );
                    },
                  )
                : selectedIndex == 3
                  ? ListView.builder(
                      itemCount: farmers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
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
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: customText.kRichText(
                                          textLeft: TextConstants.name,
                                          textRight: farmers[index]["name"],
                                          colorLeft: ColorConstants.kSecondary,
                                          colorRight: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: customText.kRichText(
                                          textLeft: TextConstants.mobile,
                                          textRight: farmers[index]["mobile"],
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
                                    child: Center(
                                      child: Icon(Icons.person, size: 55, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: customText.kRichText(
                                  textLeft: TextConstants.email,
                                  textRight: farmers[index]["email"],
                                  colorLeft: ColorConstants.kSecondary,
                                  colorRight: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if(loginController.accessToken == null){
                                        helper.errorDialog(TextConstants.loginFirst);
                                      } else {
                                        Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) =>
                                            UserDetails(details: farmers[index], userType: 3),
                                          ),
                                        );
                                      }
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
                        );
                      },
                    )
                  : selectedIndex == 4
                    ? ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
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
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: customText.kRichText(
                                            textLeft: TextConstants.name,
                                            textRight: students[index]["name"],
                                            colorLeft: ColorConstants.kSecondary,
                                            colorRight: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: customText.kRichText(
                                            textLeft: TextConstants.mobile,
                                            textRight: students[index]["mobile"],
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
                                      child: Center(
                                        child: Icon(Icons.person, size: 55, color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: customText.kRichText(
                                    textLeft: TextConstants.email,
                                    textRight: students[index]["email"],
                                    colorLeft: ColorConstants.kSecondary,
                                    colorRight: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if(loginController.accessToken == null){
                                          helper.errorDialog(TextConstants.loginFirst);
                                        } else {
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) =>
                                              UserDetails(details: students[index], userType: 4),
                                            ),
                                          );
                                        }
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
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
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
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: customText.kRichText(
                                            textLeft: TextConstants.name,
                                            textRight: users[index]["name"],
                                            colorLeft: ColorConstants.kSecondary,
                                            colorRight: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: customText.kRichText(
                                            textLeft: TextConstants.mobile,
                                            textRight: users[index]["mobile"],
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
                                      child: Center(
                                        child: Icon(Icons.person, size: 55, color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: customText.kRichText(
                                    textLeft: TextConstants.email,
                                    textRight: users[index]["email"],
                                    colorLeft: ColorConstants.kSecondary,
                                    colorRight: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if(loginController.accessToken == null){
                                          helper.errorDialog(TextConstants.loginFirst);
                                        } else {
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) =>
                                              UserDetails(details: users[index], userType: 5),
                                            ),
                                          );
                                        }
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
                          );
                        },
                      )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
