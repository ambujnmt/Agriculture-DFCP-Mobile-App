import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth_screen.dart/login_screen.dart';
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

class _NewIntroScreenState extends State<NewIntroScreen>
    with TickerProviderStateMixin {
  dynamic size;
  final customText = CustomText();
  bool movedToSplash = false;
  int introPage = 0;
  late VideoPlayerController videoController1, videoController2;
  late Animation<double> cloudAnimation, logoAnimation;
  late AnimationController cloudController, logoController;

  @override
  void initState() {
    super.initState();
    moveForward();


    logoController = AnimationController(
        duration: const Duration(seconds: 1000), vsync: this);

    cloudController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    cloudAnimation = Tween<double>(begin: -2, end: 2).animate(cloudController)
      ..addListener(() {
        // setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          cloudController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          cloudController.forward();
        }
      });

    cloudController.forward();

    // videoController1 = VideoPlayerController.asset("assets/videos/globe.mp4")
    videoController1 = VideoPlayerController.asset("assets/videos/globeFramedAnimation.mp4")
      ..initialize().then((_) {
        setState(() {});
      });

    videoController1.play();

    videoController2 =
        // VideoPlayerController.asset("assets/videos/aiAnimation45.mp4")
        VideoPlayerController.asset("assets/videos/3aFramedAnimation.mp4")
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
    } else if (introPage == 1){
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          introPage = 2;
        });
        moveForward();
        // videoController2.play();
        logoController.forward();
      });
    }
      else {
      Future.delayed(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animation.removeListener(listener)
    cloudController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/simple_bgImage.png"),
            fit: BoxFit.fitHeight
          )
        ),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.35,
              width: size.width * 0.95,
              // padding: EdgeInsets.all(2),
              // color: Colors.white,
              margin: EdgeInsets.only(top: size.height * 0.05, left: size.width * 0.025),
              child: introPage == 0
                  // ? Image.asset("assets/images/simple_bgImage.png", fit: BoxFit.cover,)
                  ? videoController1.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: videoController1.value.aspectRatio,
                          child: VideoPlayer(videoController1),
                        )
                      : Container()
                  : introPage == 1
                    ? videoController2.value.isInitialized
                        ? AspectRatio(
                          aspectRatio: videoController2.value.aspectRatio,
                          child: VideoPlayer(videoController2),
                        )
                        : Container()
                    : Center(
                      child: Stack(
                          children: [
                            RotationTransition(
                              turns: Tween(begin: 0.0, end: 20.0).animate(logoController),
                              child: SizedBox(
                                height: size.height * 0.2,
                                child: Image.asset("assets/images/logo base.png"),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.2,
                                child: Image.asset("assets/images/logo top.png"))
                          ],
                        ),
                    ),
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
                alignment: Alignment(cloudAnimation.value, 0.6),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        decoration: BoxDecoration(
                            color: ColorConstants.kYellow,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.03)),
                        child: customText.kText(
                            TextConstants.skip,
                            16,
                            FontWeight.w900,
                            ColorConstants.kTextGreen,
                            TextAlign.center),
                      ),
                      onTap: () {
                        setState(() {
                          movedToSplash = true;
                        });
                        cloudController.dispose();
                        Future.delayed(
                            const Duration(seconds: 5),
                                () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => const LoginScreen())));
                        // Navigator.pushReplacement(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.leftToRight,
                        //         child: const NewSplashScreen(),
                        //         duration: const Duration(seconds: 1)));
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
                                child: customText.kHeadingText(
                                    TextConstants.appTitle,
                                    75,
                                    FontWeight.w800,
                                    Colors.white,
                                    TextAlign.center),
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
