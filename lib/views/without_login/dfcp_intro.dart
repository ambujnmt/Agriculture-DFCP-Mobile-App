import 'package:carousel_slider/carousel_slider.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth/login_screen.dart';
import 'package:dfcp/views/without_login/market_profile_home.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AppFeatureIntro extends StatefulWidget {
  const AppFeatureIntro({super.key});

  @override
  State<AppFeatureIntro> createState() => _AppFeatureIntroState();
}

class _AppFeatureIntroState extends State<AppFeatureIntro> {

  dynamic size;
  int currentIndex = 0;
  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.025, right: size.width * 0.03),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                // child: customText.kText("Skip", 22, FontWeight.w400, Colors.black, TextAlign.center),
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  decoration: BoxDecoration(
                      color: ColorConstants.kPrimary,
                      borderRadius:
                      BorderRadius.circular(size.width * 0.03)),
                  child: customText.kText(
                      TextConstants.skip,
                      16,
                      FontWeight.w900,
                      Colors.white,
                      TextAlign.center),
                ),
                onTap: () {
                  log("skip button pressed");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MarketProfileHome() ));

                },
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          // color: Colors.yellow.shade200,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.only(top: 3),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                const CustomTitle(title: TextConstants.intro,),
        
                CarouselSlider(
                  items: [
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/slider_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/slider_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/slider_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      }),
                ),
        
                Center(
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: currentIndex,
                    decorator: const DotsDecorator(
                      color: ColorConstants.kSecondary, // Inactive color
                      activeColor: ColorConstants.kPrimary,
                    ),
                  ),
                ),
        
                const SizedBox(height: 10),
        
                customText.kText("●  ${TextConstants.whatIsDfcp}", 18, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                const SizedBox(height: 5),
        
                customText.kText("●  ${TextConstants.howItWorks}", 18, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                const SizedBox(height: 5),
        
                customText.kText("●  ${TextConstants.howYouCanUse}", 18, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                customText.kText("●  ${TextConstants.roleSuitableForYou}", 18, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start),
        
                const SizedBox(height: 5),
                customText.kText("1  ${TextConstants.advisor}", 16, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                const SizedBox(height: 5),
                customText.kText("2  ${TextConstants.farmer}", 16, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                const SizedBox(height: 5),
                customText.kText("3  ${TextConstants.student}", 16, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                const SizedBox(height: 5),
                customText.kText("4  ${TextConstants.user}", 16, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
        
                customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 7),
        
                const SizedBox(height: 10),
        
                CustomButton(
                  buttonText: "Next",
                  onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                  },
                ),
        
                const SizedBox(height: 15),
              ],
            ),
          )
        ),
      )

    );
  }
}
