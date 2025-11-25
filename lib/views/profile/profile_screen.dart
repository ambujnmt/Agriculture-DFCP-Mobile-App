import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
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
  bool isApiCalling = false;
  final customText = CustomText(), api = API(), helper = Helper();
  Map<String, dynamic> profileData = {};

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getProfile();

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] ==1) {

      setState(() {
        profileData = response["result"];
      });

    } else {}

  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      child: Scaffold(
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
          title: customText.kHeadingText(TextConstants.appTitle,
              45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
          centerTitle: true,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: isApiCalling
          ? const Center(
              child: CustomProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitle(title: TextConstants.profile,),
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
                            border: Border.all(color: ColorConstants.kGrey, width: 3)
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
                              color: ColorConstants.kSecondary,
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
                        top: size.height * 0.12,
                        child: Container(
                          height: size.height * 0.6,
                          width: size.width,
                          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          // color: Colors.red.shade200,
                          child: Column(
                            children: [

                              Align(
                                alignment: Alignment.center,
                                child: customText.kText(
                                  profileData["user_type"] == "1"
                                    ? TextConstants.superAdmin
                                    : profileData["user_type"] == "2"
                                      ? TextConstants.advisor
                                      : profileData["user_type"] == "3"
                                        ? TextConstants.farmer
                                        : profileData["user_type"] == "4"
                                          ? TextConstants.student
                                          : TextConstants.user,
                                  25, FontWeight.w800, ColorConstants.kSecondary, TextAlign.center)
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 0.32,
                                    child: customText.kText("${TextConstants.name} : ", 18, FontWeight.w700, ColorConstants.kSecondary, TextAlign.start),
                                  ),
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    child: customText.kText(profileData["name"], 18, FontWeight.w700, Colors.white, TextAlign.start),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.width * 0.01,),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 0.32,
                                    child: customText.kText("${TextConstants.email} : ", 18, FontWeight.w700, ColorConstants.kSecondary, TextAlign.start),
                                  ),
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    child: customText.kText(profileData["email"], 18, FontWeight.w700, Colors.white, TextAlign.start),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.width * 0.01,),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 0.32,
                                    child: customText.kText("${TextConstants.contact} : ", 18, FontWeight.w700, ColorConstants.kSecondary, TextAlign.start),
                                  ),
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    child: customText.kText(profileData["mobile"], 18, FontWeight.w700, Colors.white, TextAlign.start),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.width * 0.01,),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 0.32,
                                    alignment: Alignment.center,
                                    child: customText.kText("${TextConstants.subscriptionPlan} : ", 18, FontWeight.w700, ColorConstants.kSecondary, TextAlign.start),
                                  ),
                                  Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    child: customText.kText(profileData["membership_type"], 18, FontWeight.w700, Colors.white, TextAlign.start),

                                  ),
                                ],
                              ),

                              // SizedBox(height: size.width * 0.05,),
                              const Spacer(),

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

                              SizedBox(height: size.height * 0.02,)

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

      ),
    );
  }

}
