import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/new_splash.dart';
import 'package:dfcp/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

class NewIntroScreen extends StatefulWidget {
  const NewIntroScreen({super.key});

  @override
  State<NewIntroScreen> createState() => _NewIntroScreenState();
}

class _NewIntroScreenState extends State<NewIntroScreen> with TickerProviderStateMixin {

  dynamic size;
  final customText = CustomText();
  bool movedToSplash = false;
  int introPage = 0;
  late Animation<double> animation;
  late AnimationController controller;
  late VideoPlayerController videoController1, videoController2;


  @override
  void initState() {
    super.initState();
    moveForward();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    animation = Tween<double>(begin: -2, end: 2).animate(controller)
      ..addListener(() {
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();

    videoController1 = VideoPlayerController.asset("assets/videos/globe.mp4")
      ..initialize().then((_) {
        setState(() {});
      });

    videoController1.play();

    videoController2 = VideoPlayerController.asset("assets/videos/aiAnimation.mp4")
      ..initialize().then((_) {
        setState(() {});
    });

  }

  moveForward() {
    if (introPage == 0) {
      Future.delayed(const Duration(seconds: 6), () {
        setState(() {
          introPage = 1;
        });
        moveForward();
        videoController2.play();
      });
    } else {
      if (!movedToSplash) {

        Future.delayed(const Duration(seconds: 6), () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: const NewSplashScreen(),
              duration: const Duration(seconds: 1)));
        });

      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animation.removeListener(listener)
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [

            SizedBox(
              height: size.height,
              width: size.width,
              child: introPage == 0
                // ? Image.asset("assets/images/simple_bgImage.png", fit: BoxFit.cover,)
                ? videoController1.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: videoController1.value.aspectRatio,
                    child: VideoPlayer(videoController1),
                  )
                  : Container()
                : videoController2.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: videoController2.value.aspectRatio,
                      child: VideoPlayer(videoController2),
                    )
                  : Container()
            ),

            // windmill
            Positioned(
              top: size.height * 0.71,
              left: size.width * 0.75,
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width * 0.2,
                child: Lottie.asset("assets/images/slowWind.json"),
              ),
            ), // SizedBox(

            // cloud animation
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

                //skip button
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
                            borderRadius: BorderRadius.circular(size.width * 0.03)),
                        child: customText.kText(TextConstants.skip, 16, FontWeight.w900,
                            ColorConstants.kTextGreen, TextAlign.center),
                      ),
                      onTap: () {
                        setState(() {
                          movedToSplash = true;
                        });
                        controller.dispose();
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const NewSplashScreen(),
                                duration: const Duration(seconds: 1)));
                      },
                    ),
                  ),
                ),

                introPage == 0
                ? Column(
                  children: [
                    // Container(
                    //   color: Colors.transparent,
                    //   height: size.width * 0.7,
                    //   width: size.width * 0.7,
                    //   child: Lottie.asset('assets/images/2.json'),
                    // ),
                    SizedBox(height: size.width * 0.7),
                    SizedBox(
                      height: size.width * 0.35,
                      child: customText.kText(
                          TextConstants.intelligentFarming,
                          45,
                          FontWeight.w700,
                          ColorConstants.kYellow,
                          TextAlign.center),
                    )
                  ],
                )
                : Column(
                  children: [
                    SizedBox(height: size.width * 0.7),
                    Stack(
                      children: [
                        SizedBox(
                          height: size.width * 0.25,
                          child: customText.kHeadingText(TextConstants.appTitle, 75,
                              FontWeight.w800, Colors.white, TextAlign.center),
                        ),
                        Positioned(
                          top: -1,
                          left: -1,
                          child: SizedBox(
                            height: size.width * 0.25,
                            child: customText.kHeadingText(
                                TextConstants.appTitle,
                                75,
                                FontWeight.w800,
                                ColorConstants.kTextGreen,
                                TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )

          ],
        ),
      ),
    );
  }

}
