import 'dart:developer';

import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/advisor_controller.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/controllers/farmer_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/controllers/student_controller.dart';
import 'package:dfcp/controllers/user_controller.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/address/new_address.dart';
import 'package:dfcp/views/orders/orders_dashboard_screen.dart';
import 'package:dfcp/views/profile/profile_screen.dart';
import 'package:dfcp/views/profile/subscribe_screen.dart';
import 'package:dfcp/views/referral/referral_screen.dart';
import 'package:dfcp/views/wallet/wallet_dashboard.dart';
import 'package:dfcp/views/without_login/dfcp_intro.dart';
import 'package:dfcp/views/without_login/market_profile_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  dynamic size;
  String userName = "", userType = "";
  final customText = CustomText(), helper = Helper(), box = GetStorage();
  // int selectedIndex = 0;
  BottomNavController bottomNavController = Get.put(BottomNavController());
  FarmerController farmerController = Get.put(FarmerController());
  AdvisorController advisorController = Get.put(AdvisorController());
  StudentController studentController = Get.put(StudentController());
  UserController userController = Get.put(UserController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    log("check user type :- ${box.read("userType")}");
    userType = box.read("userType");

    if(userType == "Farmer") {
      userName = farmerController.userName;
    } else if(userType == "Advisor") {
      userName = advisorController.userName;
    } else if(userType == "Student") {
      userName = studentController.userName;
    } else if(userType == "User") {
      userName = userController.userName;
    }

  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => helper.alertDialog(context, TextConstants.exitFromApp,
        TextConstants.exitAppDesc,
          () { ScaffoldMessenger.of(context).removeCurrentSnackBar();},
          () { SystemNavigator.pop();}
      ),
      child: Scaffold(
        appBar: AppBar(
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
        body: SafeArea(
          child: Stack(

            children: [

              SizedBox(
                width: double.infinity,
                child: Image.asset("assets/images/settingsBG.png", fit: BoxFit.fill,),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomTitle(title: TextConstants.settings,),
              ),

              Positioned(
                top: size.height * 0.12,
                left: size.width * 0.08,
                child: GestureDetector(
                  child: Container(
                    height: 45,
                    width: size.width * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    decoration: BoxDecoration(
                      color: ColorConstants.kSecondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: Colors.black38,
                          blurRadius: 4
                        ),
                      ]
                    ),
                    child: Center(
                      child: customText.kText(userName, 20, FontWeight.w700, ColorConstants.kPrimary, TextAlign.center, TextOverflow.ellipsis, 1),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen() ));
                  },
                ),
              ),

              Positioned(
                top: size.height * 0.045,
                left: size.width * 0.6,
                child: Container(
                  height: size.width * 0.32,
                  width: size.width * 0.33,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage("assets/images/girl_image.png"),
                          fit: BoxFit.fitWidth
                      ),
                      // borderRadius: BorderRadius.circular(size.width * 0.15),
                      border: Border.all(color: ColorConstants.kGrey, width: 3)
                  ),
                ),
              ),

              Positioned(
                top: size.height * 0.21,
                // left: size.width * 0.08,
                child: Container(
                  height: size.height * 0.45,
                  // width: size.width * 0.65,
                  // color: Colors.yellow.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*selectedIndex == 1
                      ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.7,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                          color: ColorConstants.kSecondary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(size.width * 0.05),
                            bottomRight: Radius.circular(size.width * 0.05),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.black38,
                              blurRadius: 4
                            ),
                          ]
                        ),
                        child: customText.kText(TextConstants.profile, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                      : */GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.07),
                            child: customText.kText(TextConstants.profile, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                          ),
                        onTap: () {
                            // setState(() {
                            //   selectedIndex = 1;
                            // });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen() ));
                        },
                      ),

                      /*selectedIndex == 2
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.5,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.wallet, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.wallet, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 2;
                          // });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WalletDashboard() ));
                        },
                      ),

                      /*selectedIndex == 3
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.5,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.referralLink, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.referralLink, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 3;
                          // });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReferralScreen() ));
                        },
                      ),

                      /*selectedIndex == 4
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.7,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.manageOrders, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.manageOrders, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 4;
                          // });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersDashboardScreen() ));
                        },
                      ),

                      /*selectedIndex == 5
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.5,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.simpleAddress, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.simpleAddress, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 5;
                          // });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewAddress() ));
                        },
                      ),

                      /*selectedIndex == 6
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.5,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.reports, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.reports, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 6;
                          // });
                        },
                      ),

                      /*selectedIndex == 7
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.7,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.subscriptionPlan, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.subscriptionPlan, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 7;
                          // });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscribeScreen() ));
                        },
                      ),

                      /*selectedIndex == 8
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.5,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.verifyAccount, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          : */GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.verifyAccount, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {
                          // setState(() {
                          //   selectedIndex = 8;
                          // });
                        },
                      ),

                      /*selectedIndex == 9
                          ? Container(
                        height: size.height * 0.05,
                        // width: size.width * 0.5,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.1),
                        decoration: BoxDecoration(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 0.05),
                              bottomRight: Radius.circular(size.width * 0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.black38,
                                  blurRadius: 4
                              ),
                            ]
                        ),
                        child: customText.kText(TextConstants.logout, 22, FontWeight.w600, ColorConstants.kPrimary, TextAlign.start),
                      )
                          :*/ GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: customText.kText(TextConstants.logout, 22, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
                        ),
                        onTap: () {

                            loginController.clearDataLogout();
                            helper.successDialog(TextConstants.logoutSuccess);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const AppFeatureIntro()),
                            );
                          // setState(() {
                          //   selectedIndex = 9;
                          // });
                        },
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),
        )
      ),
    );
  }
}
