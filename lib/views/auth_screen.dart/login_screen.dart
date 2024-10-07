import 'package:dfcp/constants/color_constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: ColorConstants.kPrimary,
            ),
            SizedBox(
              height: height,
              width: width,
              child: Image.asset('assets/images/login_background.png'),
            ),
            Positioned(
              child: Image.asset('assets/images/top_curve.png'),
            ),
            Positioned(
              top: height * 0.4,
              left: -55,
              child: SizedBox(
                height: height * 0.5,
                width: width * 0.5,
                child: Image.asset("assets/images/left_curve.png"),
              ),
            ),
            Positioned(
              top: height * 0.5,
              left: width * 0.65,
              child: SizedBox(
                height: height * 0.5,
                width: width * 0.5,
                child: Image.asset("assets/images/right_curve.png"),
              ),
            )

          ],
        ),
      )
      // body: Container(
      //   padding: EdgeInsets.all(15),
      //   decoration: const BoxDecoration(
      //       image: DecorationImage(
      //           image: AssetImage('assets/images/login_background.png'))),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       CustomButton(
      //         buttonText: 'Login',
      //         onpress: () {
      //           print('This is login butotn');
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       CustomButton(
      //         buttonText: 'Create Account',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
