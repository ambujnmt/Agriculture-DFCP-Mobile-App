import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:developer';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {

  dynamic size;
  final customText = CustomText();
  bool movedToSplash = false;
  int introPage = 0;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    moveForward();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 10));

    animation = Tween<double>(begin: -2, end: 2).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  moveForward() {
    if (introPage == 0) {
      Future.delayed(const Duration(seconds: 6), () {
        setState(() {
          introPage = 1;
        });
        moveForward();
      });
    } else {

      if(!movedToSplash) {
        log("check moved to splash is $movedToSplash");
        Future.delayed(
            const Duration(seconds: 6),
                () {
              controller.dispose();
              Navigator.pushReplacement(context,
                  PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: const SplashScreen(),
                      duration: const Duration(seconds: 1)));
            }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(image: DecorationImage(
            image: AssetImage("assets/images/simple_bgImage.png"),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [

              Positioned(
                top: size.height * 0.71,
                left: size.width * 0.75,
                child: SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                  child: Lottie.asset("assets/images/slowWind.json"),
                ),
              ), // SizedBox(

              Opacity(
                opacity: 0.8,
                child: Align(
                  alignment: Alignment(animation.value, 0.6),
                  child: SizedBox(
                    height: size.width * 1.0,
                    width: size.width,
                    child: Lottie.asset('assets/images/cloud animation.json'),
                  ),
                ),
              ),

              Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.07, right: size.width * 0.03),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        // child: customText.kText("Skip", 22, FontWeight.w400, Colors.black, TextAlign.center),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          decoration: BoxDecoration(
                            color: ColorConstants.kYellow,
                            borderRadius: BorderRadius.circular(size.width * 0.03)
                          ),
                          child: customText.kText("Skip", 16, FontWeight.w900, ColorConstants.kTextGreen, TextAlign.center),
                        ),
                        onTap: () {
                          setState(() {
                            movedToSplash = true;
                          });
                          log("moved to splash :- $movedToSplash");
                          controller.dispose();
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: const SplashScreen(),
                              duration: const Duration(seconds: 1)));
                        },
                      ),
                    ),
                  ),


                  introPage == 0
                      ? Column(
                          children: [
                            // Align(
                            //   alignment: Alignment(animation.value, 1),
                            //   child: Container(
                            //     color: Colors.transparent,
                            //     height: size.width * 0.7,
                            //     width: size.width * 0.7,
                            //     child: Lottie.asset('assets/images/tractor.json'),
                            //   ),
                            // ),
                            Container(
                              color: Colors.transparent,
                              height: size.width * 0.7,
                              width: size.width * 0.7,
                              child: Lottie.asset('assets/images/10.json'),
                            ),
                            SizedBox(
                              height: size.width * 0.35,
                              child: customText.kText(
                                "Intelligent Farming", 45, FontWeight.w700,
                                const Color(0xffFDC200), TextAlign.center),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            // SizedBox(
                            //   height: size.width * 0.7,
                            //   width: size.width * 0.7,
                            //   child: Image.asset('assets/images/smart farming.png'),
                            // ),
                            Container(
                              color: Colors.transparent,
                              height: size.width * 0.7,
                              width: size.width * 0.7,
                              child: Lottie.asset('assets/images/1.json'),
                            ),
                            SizedBox(height: size.height * 0.02),
                            SizedBox(
                                height: size.width * 0.32,
                                child: customText.kText(
                                    "Our Solutions empowers agricultural operators, reduces operation costs, improve crop quality, and increases yield rate",
                                    20,
                                    FontWeight.w700,
                                    const Color(0xffFDC200),
                                    TextAlign.center))
                          ],
                        ),
                  SizedBox(height: size.height * 0.15),
                  DotsIndicator(
                    dotsCount: 2,
                    position: introPage,
                    decorator: DotsDecorator(
                        size: const Size.square(12.0),
                        activeSize: const Size(24.0, 12.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        color: Colors.black,
                        activeColor: const Color(0xffFDC200)),
                  )
                ],
              )
            ],
          ),
      ),
    );
  }

}








