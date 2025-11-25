import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/meetings/all_usersListing.dart';
import 'package:dfcp/views/meetings/schedule_meeting.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final int? userType;
  final Map<String, dynamic>? details;
  const UserDetails({super.key, this.userType, this.details});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  int userType = 0;
  Map<String, dynamic> details = {};
  final customText = CustomText();

  @override
  void initState() {
    super.initState();
    userType = widget.userType!;
    details = widget.details!;
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AllUsersListing()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        // color: Colors.yellow,
        // margin: const EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                userType == 2
                ? const CustomTitle(title: TextConstants.advisorDetailText,)
                : userType == 3
                  ? const CustomTitle(title: "${TextConstants.farmer} ${TextConstants.details}")
                  : userType == 4
                    ? const CustomTitle(title: "${TextConstants.student} ${TextConstants.details}")
                    : const CustomTitle(title: "${TextConstants.user} ${TextConstants.details}"),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    height: height * .200,
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
                                    textRight: details["name"],
                                    colorLeft: ColorConstants.kSecondary,
                                    colorRight: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: customText.kRichText(
                                    textLeft: TextConstants.mobile,
                                    textRight: details["mobile"],
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
                                // image: const DecorationImage(
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
                          margin: const EdgeInsets.only(bottom: 10),
                          child: customText.kRichText(
                            textLeft: TextConstants.email,
                            textRight: details["email"],
                            colorLeft: ColorConstants.kSecondary,
                            colorRight: Colors.white,
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: customText.kRichText(
                            textLeft: TextConstants.description,
                            textRight: "",
                            colorLeft: ColorConstants.kSecondary,
                            colorRight: Colors.white,
                          ),
                        ),

                        const Spacer(),

                        CustomButton(
                          buttonText: TextConstants.scheduleMeeting,
                          onpress: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ScheduleMeeting(userDetails: details) ));
                          },
                        ),

                        SizedBox(height: height * 0.01,),


                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     margin:
            //         const EdgeInsets.only(bottom: 20, left: 10, right: 10),
            //     child: CustomButton(
            //       buttonText: "Schedule Meeting",
            //       onpress: () {
            //         print("Schedule Meeting");
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const ScheduleMeeting(),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
