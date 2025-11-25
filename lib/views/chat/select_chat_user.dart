import 'dart:developer';

import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/chat/advisor_tab_view.dart';
import 'package:dfcp/views/chat/all_chat_list_screen.dart';
import 'package:dfcp/views/chat/farmer_tab_view.dart';
import 'package:dfcp/views/chat/student_tab_view.dart';
import 'package:dfcp/views/chat/user_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SelectChatUser extends StatefulWidget {
  const SelectChatUser({super.key});

  @override
  State<SelectChatUser> createState() => _SelectChatUserState();
}

class _SelectChatUserState extends State<SelectChatUser> {

  String userType = "";
  final customText = CustomText(), box = GetStorage();

  @override
  void initState() {
    super.initState();

    log("check user type :- ${box.read("userType")}");
    userType = box.read("userType");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: userType == "Farmer" || userType == "Advisor"
        ? 1
        : 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const AllChatListScreen()),
              // );
            },
          ),
          title: customText.kHeadingText(TextConstants.appTitle, 45,
              FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        ),
        body: Container(
          // margin: const EdgeInsets.all(15),
          child: userType == "Farmer" || userType == "Advisor"
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: ColorConstants.kSecondary,
                    indicatorWeight: 4.0,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle:
                        customText.kTextStyle(14, FontWeight.w700, Colors.black),
                    tabs: const [
                      Tab(text: 'Student'),
                    ]),
                const Expanded(
                  child: TabBarView(
                    children: [
                      StudentTabView(),
                    ],
                  ),
                ),
              ],
            )
          :  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: ColorConstants.kSecondary,
                  indicatorWeight: 4.0,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle:
                  customText.kTextStyle(14, FontWeight.w700, Colors.black),
                  tabs: const [
                    Tab(text: 'Advisor'),
                    Tab(text: 'Farmer'),
                    Tab(text: 'Student'),
                    Tab(text: 'User'),
                  ]),
              const Expanded(
                child: TabBarView(
                  children: [
                    AdvisorTabView(),
                    FarmerTabView(),
                    StudentTabView(),
                    UserTabView(),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
