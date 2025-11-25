// import 'package:dfcp/constants/color_constants.dart';
// import 'package:dfcp/constants/text_constants.dart';
// import 'package:dfcp/utils/custom_text.dart';
// import 'package:dfcp/views/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:page_transition/page_transition.dart';
// import 'dart:developer';
//
// import 'package:video_player/video_player.dart';
//
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});
//
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
//
//
//   dynamic size;
//   final customText = CustomText();
//   bool movedToSplash = false;
//   // int introPage = 0;
//
//   late Animation<double> animation;
//   late AnimationController controller;
//   // late VideoPlayerController videoController;
//
//   @override
//   void initState() {
//     super.initState();
//     moveForward();
//
//     controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 10));
//
//     animation = Tween<double>(begin: -2, end: 2).animate(controller)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           controller.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller.forward();
//         }
//       });
//
//     controller.forward();
//
//     // videoController = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
//     // videoController = VideoPlayerController.asset("assets/videos/introAnimation.mp4")
//     //   ..initialize().then((_) {
//     //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//     //     setState(() {});
//     //   });
//     // videoController.play();
//   }
//
//   moveForward() {
//
//     Future.delayed(const Duration(seconds: 6), () {
//       controller.dispose();
//
//       // Navigator.pushReplacement(
//       //   context,
//       //   PageTransition(
//       //     type: PageTransitionType.leftToRight,
//       //     child: const SplashScreen(),
//       //     duration: const Duration(seconds: 1)));
//
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
//
//     });
//     // if (introPage == 0) {
//     //   Future.delayed(const Duration(seconds: 6), () {
//     //     setState(() {
//     //       introPage = 1;
//     //     });
//     //     moveForward();
//     //     videoController.play();
//     //   });
//     // } else {
//     //   if (!movedToSplash) {
//     //
//     //   }
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         height: size.height,
//         width: size.width,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/simple_bgImage.png"),
//               fit: BoxFit.cover),
//         ),
//         child: Stack(
//           children: [
//
//             // SizedBox(
//             //   height: size.height,
//             //   width: size.width,
//             //   child: /*introPage == 0
//             //     ?*/ Image.asset("assets/images/simple_bgImage.png", fit: BoxFit.cover,)
//             //     /*: videoController.value.isInitialized
//             //       ? AspectRatio(
//             //           aspectRatio: videoController.value.aspectRatio,
//             //           child: VideoPlayer(videoController),
//             //         )
//             //       : Container()*/
//             // ),
//
//             // windmill
//             Positioned(
//               top: size.height * 0.71,
//               left: size.width * 0.75,
//               child: SizedBox(
//                 height: size.height * 0.2,
//                 width: size.width * 0.2,
//                 child: Lottie.asset("assets/images/slowWind.json"),
//               ),
//             ), // SizedBox(
//
//             // cloud animation
//             Opacity(
//               opacity: 0.8,
//               child: Align(
//                 alignment: Alignment(animation.value, 0.6),
//                 child: SizedBox(
//                   height: size.width * 1.0,
//                   width: size.width,
//                   child: Lottie.asset('assets/images/cloud animation.json'),
//                 ),
//               ),
//             ),
//
//             Column(
//               children: [
//
//                 //skip button
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: size.height * 0.07, right: size.width * 0.03),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: GestureDetector(
//                       // child: customText.kText("Skip", 22, FontWeight.w400, Colors.black, TextAlign.center),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                         decoration: BoxDecoration(
//                           color: ColorConstants.kYellow,
//                             borderRadius: BorderRadius.circular(size.width * 0.03)),
//                         child: customText.kText(TextConstants.skip, 16, FontWeight.w900,
//                             ColorConstants.kTextGreen, TextAlign.center),
//                       ),
//                       onTap: () {
//                         setState(() {
//                           movedToSplash = true;
//                         });
//                         controller.dispose();
//                         Navigator.pushReplacement(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.leftToRight,
//                             child: const SplashScreen(),
//                             duration: const Duration(seconds: 1)));
//                       },
//                     ),
//                   ),
//                 ),
//
//                 /*introPage == 0
//                     ?*/ Column(
//                         children: [
//                           // Align(
//                           //   alignment: Alignment(animation.value, 1),
//                           //   child: Container(
//                           //     color: Colors.transparent,
//                           //     height: size.width * 0.7,
//                           //     width: size.width * 0.7,
//                           //     child: Lottie.asset('assets/images/tractor.json'),
//                           //   ),
//                           // ),
//                           Container(
//                             color: Colors.transparent,
//                             height: size.width * 0.7,
//                             width: size.width * 0.7,
//                             child: Lottie.asset('assets/images/2.json'),
//                           ),
//
//                           SizedBox(
//                             height: size.width * 0.35,
//                             child: customText.kText(
//                               TextConstants.intelligentFarming,
//                               45,
//                               FontWeight.w700,
//                               const Color(0xffFDC200),
//                               TextAlign.center),
//                           )
//                         ],
//                       ),
//                     // : Column(
//                     //     children: [
//                     //       // SizedBox(
//                     //       //   height: size.width * 0.7,
//                     //       //   width: size.width * 0.7,
//                     //       //   child: Image.asset('assets/images/smart farming.png'),
//                     //       // ),
//                     //       // Container(
//                     //       //   color: Colors.transparent,
//                     //       //   height: size.width * 0.7,
//                     //       //   width: size.width * 0.7,
//                     //       //   child: Lottie.asset('assets/images/1.json'),
//                     //       // ),
//                     //       SizedBox(height: size.width * 0.7),
//                     //       SizedBox(height: size.height * 0.02),
//                     //       // SizedBox(
//                     //       //   height: size.width * 0.32,
//                     //       //   child: customText.kText(
//                     //       //     "Our Solutions empowers agricultural operators, reduces operation costs, improve crop quality, and increases yield rate",
//                     //       //     20,
//                     //       //     FontWeight.w700,
//                     //       //     const Color(0xffFDC200),
//                     //       //     TextAlign.center),
//                     //       // )
//                     //       Stack(
//                     //         children: [
//                     //           SizedBox(
//                     //             height: size.width * 0.25,
//                     //             child: customText.kHeadingText("DFCP", 75,
//                     //                 FontWeight.w800, Colors.white, TextAlign.center),
//                     //           ),
//                     //           Positioned(
//                     //             top: -1,
//                     //             left: -1,
//                     //             child: SizedBox(
//                     //               height: size.width * 0.25,
//                     //               child: customText.kHeadingText(
//                     //                   "DFCP",
//                     //                   75,
//                     //                   FontWeight.w800,
//                     //                   Color(0xff01720f),
//                     //                   TextAlign.center),
//                     //             ),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     ],
//                     //   ),
//
//                 SizedBox(height: size.height * 0.15),
//
//                 // Dots indicator
//                 // DotsIndicator(
//                 //   dotsCount: 2,
//                 //   position: introPage,
//                 //   decorator: DotsDecorator(
//                 //       size: const Size.square(12.0),
//                 //       activeSize: const Size(24.0, 12.0),
//                 //       activeShape: RoundedRectangleBorder(
//                 //           borderRadius: BorderRadius.circular(6.0)),
//                 //       color: Colors.black,
//                 //       activeColor: const Color(0xffFDC200)),
//                 // )
//
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// // Container(
// //   color: Colors.transparent,
// //   height: size.width * 0.7,
// //   width: size.width * 0.7,
// //   child: videoController.value.isInitialized
// //       ? AspectRatio(
// //           aspectRatio: videoController.value.aspectRatio,
// //           child: VideoPlayer(videoController),
// //         )
// //       : Container(),
// // ),
