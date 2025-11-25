import 'package:dfcp/admin/members/advisor_add_update.dart';
import 'package:dfcp/admin/members/farmer_add_update.dart';
import 'package:dfcp/admin/members/member_details.dart';
import 'package:dfcp/admin/members/student_add_update.dart';
import 'package:dfcp/admin/members/user_add_update.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class MembersListing extends StatefulWidget {
  final int? from;
  const MembersListing({super.key, this.from});

  @override
  State<MembersListing> createState() => _MembersListingState();
}

class _MembersListingState extends State<MembersListing> {

  final customText = CustomText();

  deleteDialog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorConstants.kPrimary,
        content: customText.kText(
          TextConstants.userDeleteDes,
          20,
          FontWeight.w700,
          Colors.white,
          TextAlign.start),
        actions: <Widget>[
          TextButton(
            child: customText.kText(
              TextConstants.no,
              20,
              FontWeight.w600,
              Colors.white,
              TextAlign.center),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          TextButton(
            child: customText.kText(
              TextConstants.yes,
              20,
              FontWeight.w600,
              ColorConstants.kSecondary,
              TextAlign.center),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ],
      ),
    );
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

      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    widget.from == 1
                    ? TextConstants.advisors
                    : widget.from == 2
                      ? TextConstants.farmers
                      : widget.from == 3
                        ? TextConstants.students
                        : TextConstants.users,
                    30,
                    FontWeight.w700,
                    ColorConstants.kPrimary,
                    TextAlign.center,
                  ),
                  const DividerWidget(),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [

                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, height * 0.1),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
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
                                    width: width * 0.65,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: customText.kRichText(
                                      textLeft: TextConstants.name,
                                      textRight: "Anamika",
                                      colorLeft: ColorConstants.kSecondary,
                                      colorRight: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.65,
                                    margin: const EdgeInsets.only(bottom: 10),
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
                            margin: const EdgeInsets.only(bottom: 20),
                            child: customText.kRichText(
                              textLeft: TextConstants.email,
                              textRight: "someone@example.com",
                              colorLeft: ColorConstants.kSecondary,
                              colorRight: Colors.white,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: width * 0.52,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      GestureDetector(
                                          child: Container(
                                            height: height * 0.04,
                                            width: width * 0.25,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 1.5),
                                                borderRadius: BorderRadius.circular(width * 0.02)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(Icons.delete, color: Colors.white,),
                                                customText.kText(TextConstants.delete, 15, FontWeight.w500, Colors.white, TextAlign.center)
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            deleteDialog();
                                          }
                                      ),

                                      GestureDetector(
                                        child: Container(
                                          height: height * 0.04,
                                          width: width * 0.25,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 1.5),
                                              borderRadius: BorderRadius.circular(width * 0.02)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(Icons.edit_square, color: Colors.white,),
                                              customText.kText(TextConstants.update, 15, FontWeight.w500, Colors.white, TextAlign.center)
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          if(widget.from == 1) {
                                            Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => const AdvisorAddUpdate() ));
                                          } else if(widget.from == 2) {
                                            Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => const FarmerAddUpdate() ));
                                          } else if(widget.from == 3) {
                                            Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => const StudentAddUpdate() ));
                                          } else if(widget.from == 4) {
                                            Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => const UserAddUpdate() ));
                                          }
                                        },
                                      ),

                                    ],
                                  )
                              ),

                              GestureDetector(
                                onTap: () {

                                  String title = "";
                                  if(widget.from == 1) {
                                    title = TextConstants.advisor;
                                  } else if(widget.from == 2) {
                                    title = TextConstants.farmer;
                                  } else if(widget.from == 3) {
                                    title = TextConstants.student;
                                  } else if(widget.from == 4) {
                                    title = TextConstants.user;
                                  }

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MemberDetails(title: title) ));
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
                    ),
                  ),

                  Container(
                    height: 55,
                    width: width,
                    decoration: BoxDecoration(
                      color: ColorConstants.kPrimary,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, -4),
                            blurRadius: 7.5,
                            color: Colors.black54
                        )
                      ]
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    child: GestureDetector(
                      child: Container(
                        height: 75,
                        width: width,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/add_image.png'),
                      ),
                      onTap: () {
                        if(widget.from == 1) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const AdvisorAddUpdate() ));
                        } else if(widget.from == 2) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const FarmerAddUpdate() ));
                        } else if(widget.from == 3) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const StudentAddUpdate() ));
                        } else if(widget.from == 4) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const UserAddUpdate() ));
                        }
                      },
                    ),
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}
