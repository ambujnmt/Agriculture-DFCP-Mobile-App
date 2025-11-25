import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/chat/chat_screen.dart';
import 'package:dfcp/views/chat/select_chat_user.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AllChatListScreen extends StatefulWidget {
  const AllChatListScreen({super.key});

  @override
  State<AllChatListScreen> createState() => _AllChatListScreenState();
}

class _AllChatListScreenState extends State<AllChatListScreen> {

  final customText = CustomText(), helper = Helper();
  BottomNavController bottomNavController = Get.put(BottomNavController());

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
        backgroundColor: Colors.white,
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTitle(title: TextConstants.allChats,),
                  SizedBox(height: height * .020),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.only(left: 20),
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 206, 201, 201),
                      color: ColorConstants.kGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: TextConstants.search,
                        hintStyle: customText.kTextStyle(
                          18, FontWeight.w400, ColorConstants.kTextGrey),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Container(
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .020),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) => SizedBox(
                        height: 75,
                        width: double.infinity,
                        child: GestureDetector(
                          child: Container(
                            // color: Colors.grey,
                            padding: EdgeInsets.symmetric(vertical: width * 0.01),
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: width * 0.03),
                                  height: 60,
                                  width: 58,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: ColorConstants.kSecondary),
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/girl_image.png'),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: height * 0.035,
                                          width: width * 0.58,
                                          // color: Colors.red,
                                          child: customText.kEllipseText(
                                              "Hannah",
                                              18,
                                              FontWeight.w400,
                                              Colors.black,
                                              TextAlign.start,
                                              TextOverflow.ellipsis,
                                              1),
                                        ),
                                        SizedBox(
                                            height: height * 0.035,
                                            width: width * 0.16,
                                            // color: Colors.white,
                                            child: Center(
                                              child: customText.kText(
                                                "Just Now",
                                                10,
                                                FontWeight.w500,
                                                Colors.black,
                                                TextAlign.center,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          // height: height * 0.045,
                                          width: width * 0.65,
                                          // color: Colors.yellow,
                                          child: customText.kEllipseText(
                                              "A good example of a contains paragraph a topic sentence, details and a conclusion. ",
                                              12,
                                              FontWeight.w400,
                                              ColorConstants.kTextGrey,
                                              TextAlign.start,
                                              TextOverflow.ellipsis,
                                              2),
                                        ),
                                        Container(
                                          height: height * 0.035,
                                          width: width * 0.1,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.02,
                                              vertical: width * 0.01),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: ColorConstants.kPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: customText.kText(
                                                "${index + 1}",
                                                12,
                                                FontWeight.w500,
                                                ColorConstants.kSecondary,
                                                TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChatScreen()));
                          },
                        ),
                      ),
                    ),
                  ),
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
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const SelectChatUser(),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectChatUser() ));
          },
        ),
      ),
    );
  }
}
