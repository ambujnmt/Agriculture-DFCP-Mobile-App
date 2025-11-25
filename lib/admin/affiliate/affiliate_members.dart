import 'package:dfcp/admin/affiliate/affiliate_details.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AffiliateMembers extends StatefulWidget {
  const AffiliateMembers({super.key});

  @override
  State<AffiliateMembers> createState() => _AffiliateMembersState();
}

class _AffiliateMembersState extends State<AffiliateMembers> {

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
          title: customText.kHeadingText(TextConstants.appTitle, 45,
              FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.affiliate,),

              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) =>
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
                                    textRight: "Anamika",
                                    colorLeft: ColorConstants.kSecondary,
                                    colorRight: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: const  EdgeInsets.only(bottom: 10),
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
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/advisor_image.png",
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: customText.kRichText(
                            textLeft: TextConstants.email,
                            textRight: "someone@example.com",
                            colorLeft: ColorConstants.kSecondary,
                            colorRight: Colors.white,
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: customText.kRichText(
                            textLeft: TextConstants.address,
                            textRight: "Sector 63, Noida",
                            colorLeft: ColorConstants.kSecondary,
                            colorRight: Colors.white,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const AffiliateDetails() ));
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
                        ),


                      ],
                    ),
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
