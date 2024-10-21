import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/profile/change_password.dart';
import 'package:dfcp/views/profile/subscribe_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  dynamic size;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: ColorConstants.kTextGreen, shape: BoxShape.circle),
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
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle,
            45, FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.kText(
                    TextConstants.profile,
                    30,
                    FontWeight.w700,
                    ColorConstants.kTextGreen,
                    TextAlign.center,
                  ),
                  const DividerWidget(),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const Spacer(),
            Container(
              height: size.height * 0.73,
              width: size.width,
              decoration: BoxDecoration(
                color: ColorConstants.kPrimary,
                // borderRadius: const BorderRadius.only(
                //   topLeft: Radius.circular(70),
                //   topRight: Radius.circular(70),
                // )
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 50.0)),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -50,
                    child: Container(
                      height: size.width * 0.3,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/girl_image.png"),
                          fit: BoxFit.fitWidth
                        ),
                        borderRadius: BorderRadius.circular(size.width * 0.15),
                        border: Border.all(color: ColorConstants.searchBoxColor, width: 3)
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    // left: 20,
                    child: GestureDetector(
                      child: Container(
                        height: size.width * 0.09,
                        width: size.width * 0.08,
                        decoration: BoxDecoration(
                          color: ColorConstants.kYellow,
                          borderRadius: BorderRadius.circular(size.width * 0.03),
                        ),
                        child: const Center(
                          child: Icon(Icons.edit, color: Colors.white,),
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) => AddUser(userDetail: userController.profileData),
                        // ));
                      },
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.15,
                    child: Container(
                      height: size.height * 0.5,
                      width: size.width,
                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      padding: EdgeInsets.all(size.width * 0.03),
                      // color: Colors.yellow,
                      child: Column(
                        children: [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: size.height * 0.04,
                                width: size.width * 0.32,
                                // color: Colors.white,
                                child: customText.kText("${TextConstants.name} :- ", 22, FontWeight.w700, ColorConstants.kYellow, TextAlign.start),
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.6,
                                // color: Colors.red,
                                alignment: Alignment.centerLeft,
                                child: customText.kText("Anamika", 18, FontWeight.w700, Colors.white, TextAlign.start),
                              ),
                            ],
                          ),

                          SizedBox(height: size.width * 0.02,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: size.height * 0.04,
                                width: size.width * 0.32,
                                // color: Colors.white,
                                child: customText.kText("${TextConstants.email} :- ", 22, FontWeight.w700, ColorConstants.kYellow, TextAlign.start),
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.6,
                                // color: Colors.red,
                                alignment: Alignment.centerLeft,
                                child: customText.kText("anamika20@gmail.com", 18, FontWeight.w700, Colors.white, TextAlign.start),
                              ),
                            ],
                          ),

                          SizedBox(height: size.width * 0.02,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: size.height * 0.04,
                                width: size.width * 0.32,
                                // color: Colors.white,
                                child: customText.kText("${TextConstants.contact} :- ", 22, FontWeight.w700, ColorConstants.kYellow, TextAlign.start),
                              ),
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.6,
                                // color: Colors.red,
                                alignment: Alignment.centerLeft,
                                child: customText.kText("1234567890", 18, FontWeight.w700, Colors.white, TextAlign.start),
                              ),
                            ],
                          ),

                          SizedBox(height: size.width * 0.15,),

                          CustomButton(
                            buttonText: TextConstants.subscribeNow,
                            onpress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SubscribeScreen() ));
                            },
                          ),

                          SizedBox(height: size.width * 0.05,),

                          CustomButton(
                            buttonText: TextConstants.changePassword,
                            onpress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword() ));
                            },
                          ),

                        ],
                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),

    );
  }

}
