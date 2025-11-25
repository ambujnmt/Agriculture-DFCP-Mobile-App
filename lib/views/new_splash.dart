// import 'package:dfcp/constants/color_constants.dart';
// import 'package:dfcp/constants/text_constants.dart';
// import 'package:dfcp/utils/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// import 'auth_screen.dart/login_screen.dart';
//
// class NewSplashScreen extends StatefulWidget {
//   const NewSplashScreen({super.key});
//
//   @override
//   State<NewSplashScreen> createState() => _NewSplashScreenState();
// }
//
// class _NewSplashScreenState extends State<NewSplashScreen>  with TickerProviderStateMixin {
//
//   dynamic size;
//   final customText = CustomText();
//   late Animation<double> cloudAnimation, logoAnimation;
//   late AnimationController cloudController, logoController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     logoController = AnimationController(
//         duration: const Duration(seconds: 1000), vsync: this);
//     logoController.forward();
//
//     cloudController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 10));
//     cloudAnimation = Tween<double>(begin: -2, end: 2).animate(cloudController)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           cloudController.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           cloudController.forward();
//         }
//       });
//     // cloudController.forward();
//
//     // Future.delayed(
//     //     const Duration(seconds: 5),
//     //     () => Navigator.pushReplacement(context,
//     //         MaterialPageRoute(builder: (context) => const LoginScreen())));
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
//             image: AssetImage("assets/images/simple_bgImage.png"),
//             fit: BoxFit.cover),
//         ),
//         child: Stack(
//           children: [
//
//             Positioned(
//               top: size.height * 0.71,
//               left: size.width * 0.75,
//               child: SizedBox(
//                 height: size.height * 0.2,
//                 width: size.width * 0.2,
//                 child: Lottie.asset("assets/images/slowWind.json"),
//               ),
//             ),
//
//             Opacity(
//               opacity: 0.8,
//               child: Align(
//                 alignment: Alignment(cloudAnimation.value, 0.6),
//                 child: SizedBox(
//                   height: size.width * 1.0,
//                   width: size.width,
//                   child: Lottie.asset('assets/images/cloud animation.json'),
//                 ),
//               ),
//             ),
//
//             Center(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: size.height * 0.15,
//                   ),
//                   Stack(
//                     children: [
//                       RotationTransition(
//                         turns: Tween(begin: 0.0, end: 10.0).animate(logoController),
//                         child: SizedBox(
//                           height: size.height * 0.2,
//                           child: Image.asset("assets/images/logo base.png"),
//                         ),
//                       ),
//                       SizedBox(
//                           height: size.height * 0.2,
//                           child: Image.asset("assets/images/logo top.png"))
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.1,
//                   ),
//                   Stack(
//                     children: [
//                       SizedBox(
//                         height: size.width * 0.25,
//                         child: customText.kHeadingText(TextConstants.appTitle, 75,
//                             FontWeight.w800, Colors.white, TextAlign.center),
//                       ),
//                       Positioned(
//                         top: -1,
//                         left: -1,
//                         child: SizedBox(
//                           height: size.width * 0.25,
//                           child: customText.kHeadingText(
//                               TextConstants.appTitle,
//                               75,
//                               FontWeight.w800,
//                               ColorConstants.kTextGreen,
//                               TextAlign.center),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
// }
