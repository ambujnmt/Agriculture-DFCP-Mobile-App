import 'dart:developer';
import 'package:dfcp/admin/affiliate/affiliate_members.dart';
import 'package:dfcp/views/dashboard/admin_dashboard.dart';
import 'package:dfcp/views/dashboard/advisor_dashboard.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/views/dashboard/farmer_dashboard.dart';
import 'package:dfcp/views/dashboard/student_dashboard.dart';
import 'package:dfcp/views/dashboard/user_dashboard.dart';
import 'package:dfcp/views/chat/all_chat_list_screen.dart';
import 'package:dfcp/views/meetings/meetings_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dfcp/views/settings/settings_screen.dart';
import 'package:get/get.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  dynamic size;
  String userType = "";
  final customText = CustomText(), box = GetStorage();
  BottomNavController bottomNavController = Get.put(BottomNavController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    userType = box.read("userType");
    log("user type :- ${box.read("userType")}");
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        // child: PageView(
        // physics: const NeverScrollableScrollPhysics(),
        // controller: sideDrawerController.pageController,
        // )
        child: PageView(
          controller: bottomNavController.pageController,
          onPageChanged: (num) {
            setState(() {
              bottomNavController.selectedIndex.value = num;
            });
          },
          children: [

            loginController.userType == TextConstants.superAdmin
              ? const AdminDashboard()
              : loginController.userType == TextConstants.advisor
                ? const AdvisorDashboard()
                : loginController.userType == TextConstants.farmer
                  ? const FarmerDashboard()
                  : loginController.userType == TextConstants.student
                    ? const StudentDashboard()
                    : const UserDashboard(), // 0

            const ProductsViewScreen(), // 1
            const AffiliateMembers(), // 2
            const MeetingsScreen(), // 3
            const AllChatListScreen(), // 4
            const SettingsScreen(),

          ]
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: ColorConstants.kPrimary,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            bottomNavController.selectedIndex.value == 1
              ? SizedBox(
            height: 60,
            width: size.width * 0.18,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [

                Positioned(
                  top: -35,
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      // height: 55,
                      // width: 55,
                      decoration: const BoxDecoration(
                          color: ColorConstants.kSecondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, -2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                          ]
                      ),
                      child: const Center(
                        child: ImageIcon(
                          AssetImage("assets/images/store.png"),
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                    top: 30,
                    child: customText.kText(TextConstants.market, 14, FontWeight.w500, Colors.white, TextAlign.center)
                )


              ],
            ),
          )
              : GestureDetector(
                  child: SizedBox(
                    width: size.width * 0.18,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ImageIcon(
                          AssetImage("assets/images/store.png"),
                          color: Colors.white,
                          size: 30,
                        ),

                        // const SizedBox(height: 5),

                        // customText.kText(TextConstants.market, 14, FontWeight.w500, Colors.white, TextAlign.center)

                      ],
                    ),
                  ),
                onTap: () {
                    bottomNavController.selectedIndex.value = 1;
                    bottomNavController.pageController.jumpToPage(1);
                },
              ),

            bottomNavController.selectedIndex.value == 2
              ? SizedBox(
            height: 60,
            width: size.width * 0.2,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [

                Positioned(
                  top: -35,
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      // height: 55,
                      // width: 55,
                      decoration: const BoxDecoration(
                          color: ColorConstants.kSecondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, -2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                          ]
                      ),
                      child: const Center(
                        child: ImageIcon(
                          AssetImage("assets/images/marketing.png"),
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                    top: 30,
                    child: customText.kText(TextConstants.marketing, 14, FontWeight.w500, Colors.white, TextAlign.center)
                )


              ],
            ),
          )
              : GestureDetector(
                child: SizedBox(
                            width: size.width * 0.2,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ImageIcon(
                    AssetImage("assets/images/marketing.png"),
                    color: Colors.white,
                    size: 30,
                  ),

                  // const SizedBox(height: 5),
                  //
                  // customText.kText(TextConstants.marketing, 14, FontWeight.w500, Colors.white, TextAlign.center)

                ],
                            ),
                          ),
                onTap: () {
                  bottomNavController.selectedIndex.value = 2;
                  bottomNavController.pageController.jumpToPage(2);
                },
              ),

            if(userType != "User")
            bottomNavController.selectedIndex.value == 3
              ? SizedBox(
              height: 60,
              width: size.width * 0.18,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [

                  Positioned(
                    top: -35,
                    child: Container(
                      height: 65,
                      width: 65,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      child: Container(
                        // height: 55,
                        // width: 55,
                        decoration: const BoxDecoration(
                          color: ColorConstants.kSecondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -2),
                              color: Colors.black26,
                              blurRadius: 4
                            ),
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                          ]
                        ),
                        child: const Center(
                          child: ImageIcon(
                            AssetImage("assets/images/talk.png"),
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 30,
                    child: customText.kText(TextConstants.meetings, 14, FontWeight.w500, Colors.white, TextAlign.center)
                  )


                ],
              ),
            )
              : GestureDetector(
                child: SizedBox(
                width: size.width * 0.18,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ImageIcon(
                        AssetImage("assets/images/talk.png"),
                        color: Colors.white,
                        size: 30,
                      ),

                      // const SizedBox(height: 5),
                      //
                      // customText.kText(TextConstants.meetings, 14, FontWeight.w500, Colors.white, TextAlign.center)

                    ],
                  ),
                            ),
              onTap: () {
                  bottomNavController.selectedIndex.value = 3;
                  bottomNavController.pageController.jumpToPage(3);
              },
              ),

            if(userType != "User")
            bottomNavController.selectedIndex.value == 4
              ? SizedBox(
            height: 60,
            width: size.width * 0.18,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [

                Positioned(
                  top: -35,
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      // height: 55,
                      // width: 55,
                      decoration: const BoxDecoration(
                          color: ColorConstants.kSecondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, -2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                          ]
                      ),
                      child: const Center(
                        child: ImageIcon(
                          AssetImage("assets/images/chat1.png"),
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                    top: 30,
                    child: customText.kText(TextConstants.chats, 14, FontWeight.w500, Colors.white, TextAlign.center)
                )


              ],
            ),
          )
              : GestureDetector(
                child: SizedBox(
                            width: size.width * 0.18,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ImageIcon(
                    AssetImage("assets/images/chat1.png"),
                    color: Colors.white,
                    size: 30,
                  ),

                  // const SizedBox(height: 5),
                  //
                  // customText.kText(TextConstants.chats, 14, FontWeight.w500, Colors.white, TextAlign.center)

                ],
                            ),
                          ),
              onTap: () {
                  bottomNavController.selectedIndex.value = 4;
                  bottomNavController.pageController.jumpToPage(4);
              },
              ),

            bottomNavController.selectedIndex.value == 5
              ? SizedBox(
            height: 60,
            width: size.width * 0.18,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [

                Positioned(
                  top: -35,
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      // height: 55,
                      // width: 55,
                      decoration: const BoxDecoration(
                          color: ColorConstants.kSecondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, -2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black26,
                                blurRadius: 4
                            ),
                          ]
                      ),
                      child: const Center(
                        child: ImageIcon(
                          AssetImage("assets/images/gear.png"),
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                    top: 30,
                    child: customText.kText(TextConstants.settings, 14, FontWeight.w500, Colors.white, TextAlign.center)
                )


              ],
            ),
          )
              : GestureDetector(
                child: SizedBox(
                            width: size.width * 0.18,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ImageIcon(
                    AssetImage("assets/images/gear.png"),
                    color: Colors.white,
                    size: 30,
                  ),
                  //
                  // const SizedBox(height: 5),
                  //
                  // customText.kText(TextConstants.settings, 14, FontWeight.w500, Colors.white, TextAlign.center)

                ],
                            ),
                          ),
              onTap: () {
                  bottomNavController.selectedIndex.value = 5;
                  bottomNavController.pageController.jumpToPage(5);
              },
              ),

          ],
        ),
      )
    );
  }

}


// bottomNavigationBar: AnimatedNotchBottomBar(
//   bottomBarWidth: 1000000000000,
//   /// Provide NotchBottomBarController
//   // showTopRadius: false,
//
//   notchBottomBarController: _controller,
//   color: ColorConstants.kPrimary,
//   showLabel: true,
//   textOverflow: TextOverflow.visible,
//   maxLine: 1,
//   kBottomRadius: 0,
//   notchColor: ColorConstants.kSecondary,
//   removeMargins: true,
//   showShadow: false,
//   durationInMilliSeconds: 300,
//   itemLabelStyle: const TextStyle(fontSize: 10),
//   circleMargin: 2,
//   bottomBarItems: const [
//     BottomBarItem(
//       inActiveItem: Icon(
//         Icons.home_filled,
//         color: Colors.white,
//       ),
//       activeItem: Icon(
//         Icons.home_filled,
//         color: Colors.black,
//       ),
//       itemLabel: 'Page 1',
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(
//         Icons.star,
//         color: Colors.white,
//       ),
//       activeItem: Icon(
//         Icons.star,
//         color: Colors.black,
//       ),
//       itemLabel: 'Page 2',
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(
//         Icons.settings,
//         color: Colors.white,
//       ),
//       activeItem: Icon(
//         Icons.settings,
//         color: Colors.black,
//       ),
//       itemLabel: 'Page 3',
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(
//         Icons.person,
//         color: Colors.white,
//       ),
//       activeItem: Icon(
//         Icons.person,
//         color: Colors.black,
//       ),
//       itemLabel: 'Page 4',
//     ),
//     BottomBarItem(
//       inActiveItem: Icon(
//         Icons.person,
//         color: Colors.white,
//       ),
//       activeItem: Icon(
//         Icons.person,
//         color: Colors.black,
//       ),
//       itemLabel: 'Page 4',
//     ),
//   ],
//   onTap: (index) {
//     log('current selected index $index');
//     _pageController.jumpToPage(index);
//   },
//   kIconSize: 24.0,
// ),