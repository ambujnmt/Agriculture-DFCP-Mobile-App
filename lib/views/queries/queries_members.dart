import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dfcp/views/queries/input_query.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class QueriesMembers extends StatefulWidget {
  const QueriesMembers({super.key});

  @override
  State<QueriesMembers> createState() => _QueriesMembersState();
}

class _QueriesMembersState extends State<QueriesMembers> {

  final customText = CustomText(), api = API(), helper = Helper();
  String? selectedUserType;
  bool isApiCalling = false;
  List userTypeList = [];
  LoginController loginController = Get.put(LoginController());

  final List<String> items = [
    TextConstants.advisor,
    TextConstants.farmer,
    TextConstants.student,
    TextConstants.user
  ];

  getMembersList(String userType) async {

    log("usertype :- $userType");

    String userValue = "0";

    if(userType == TextConstants.advisor){
      userValue = "2";
    } else if(userType == TextConstants.farmer) {
      userValue = "3";
    } else if(userType == TextConstants.student) {
      userValue = "4";
    } else {
      userValue = "5";
    }

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getMembersList(userValue);

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      userTypeList = response["result"];
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
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      ),

      body: SafeArea(
        child: Container(
          width: width,
          // color: Colors.yellow.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitle(title: TextConstants.queryMember),

              Expanded(
                child: Container(
                  width: width,
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  padding: EdgeInsets.only(top: height * 0.02),
                  // color: Colors.blue.shade200,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        customText.kText(TextConstants.selectQueryMember, 20, FontWeight.w400, ColorConstants.kSecondary, TextAlign.start),

                        SizedBox(height: height * 0.01),

                        customText.kText(TextConstants.queryMemberDesc, 15, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start),

                        SizedBox(height: height * 0.02),

                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              TextConstants.userType,
                              overflow: TextOverflow.ellipsis,
                              style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kTextGrey),
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: customText.kTextStyle(20, FontWeight.w400, Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: selectedUserType,
                            onChanged: (value) {
                              setState(() {
                                selectedUserType = value;
                              });
                              getMembersList(selectedUserType!);
                            },
                            buttonStyleData: ButtonStyleData(
                              height: height * 0.06,
                              width: width * 0.95,
                              padding: const EdgeInsets.only(left:5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width * 0.04),
                                border: Border.all(color: ColorConstants.kGrey),
                                // color: ColorConstants.kPrimary,
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 40,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: width * 0.92,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                // color: ColorConstants.kPrimary,
                              ),
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility: MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.02),

                        selectedUserType != null
                        // ? customText.kText(selectedUserType!, 25, FontWeight.w700, ColorConstants.kTextGreen, TextAlign.center,)
                        ? CustomTitle(title: selectedUserType,)
                        : const SizedBox(),

                        SizedBox(height: height * 0.01),

                        for(int i = 0; i < userTypeList.length; i++)
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
                                          textRight: userTypeList[i]["name"],
                                          colorLeft: ColorConstants.kSecondary,
                                          colorRight: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: customText.kRichText(
                                          textLeft: TextConstants.mobile,
                                          textRight: userTypeList[i]["mobile"],
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
                                  textRight: userTypeList[i]["email"],
                                  colorLeft: ColorConstants.kSecondary,
                                  colorRight: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => const InputQuery()  ));
                                    },
                                    child: Container(
                                      child: customText.kText(
                                        TextConstants.query,
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
            ],
          ),
        ),
      )
    );
  }
}
