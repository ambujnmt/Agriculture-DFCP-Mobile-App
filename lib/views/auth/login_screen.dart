import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/auth/forgot_password.dart';
import 'package:dfcp/views/auth/registeration_screen.dart';
import 'package:dfcp/views/bottom_navigation/bottom_navigation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isPassHidden = true, isApiCalling = false;
  final customText = CustomText(), helper = Helper(),
    box = GetStorage(), api = API();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController  loginController = Get.put(LoginController());

  login() async {

    if(EmailValidator.validate(emailController.text)) {
      if(passwordController.text.length >= 8) {

        setState(() {
          isApiCalling = true;
        });

        final response = await api.login(emailController.text, passwordController.text);

        setState(() {
          isApiCalling = false;
        });

        if(response["status"] == 1) {

          box.write("userId", response["result"]["user_id"]);
          box.write("userType", helper.getUserType(response["result"]["user_type"]));
          box.write("accessToken", response["result"]["access_token"]);
          box.write("userName", response["result"]["name"]);
          box.write("userProfileImg", response["result"]["profile_img"]);
          loginController.userId = response["result"]["user_id"];
          loginController.userType = helper.getUserType(response["result"]["user_type"]);
          loginController.accessToken = response["result"]["access_token"];
          loginController.userName = response["result"]["name"];

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigation() ));

          // if(loginController.userType == TextConstants.superAdmin){
          //
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminDashboard() ));
          // } else if(loginController.userType == TextConstants.advisor) {
          //
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdvisorDashboard() ));
          // } else if(loginController.userType == TextConstants.farmer) {
          //
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FarmerDashboard() ));
          // } else if(loginController.userType == TextConstants.student) {
          //
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StudentDashboard() ));
          // } else {
          //
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserDashboard() ));
          // }
        } else {
          helper.errorDialog(response["message"]);
        }

      } else {
        helper.errorDialog(TextConstants.validPassword);
      }
    } else {
      helper.errorDialog(TextConstants.validEmail);
    }

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      // onWillPop: () => helper.alertDialog(context, TextConstants.exitFromApp,
      //   TextConstants.exitAppDesc,
      //   () { ScaffoldMessenger.of(context).removeCurrentSnackBar();},
      //   () { SystemNavigator.pop();}
      // ),
      child: Scaffold(
        body: Stack(
          children: [

            Background(),

            Positioned(
              // top: height * 0.46,
              top: height * .14,
              left: width * 0.18,
              child: Stack(
                children: [
                  SizedBox(
                    height: width * 0.25,
                    child: customText.kHeadingText(TextConstants.appTitle, 75,
                        FontWeight.w800, Colors.white, TextAlign.center),
                  ),
                  Positioned(
                    top: -1,
                    left: -1,
                    child: SizedBox(
                      height: width * 0.25,
                      child: customText.kHeadingText(
                          TextConstants.appTitle,
                          75,
                          FontWeight.w800,
                          ColorConstants.kPrimary,
                          TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(height: height * 0.26),
                    customText.kText(TextConstants.login, 32, FontWeight.w700,
                        ColorConstants.kSecondary, TextAlign.center),

                    SizedBox(height: height * 0.01),
                    customText.kText(TextConstants.loginDesc, 16, FontWeight.w400,
                        ColorConstants.kSecondary, TextAlign.center),

                    SizedBox(height: height * 0.050),
                    CustomTextField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hint: TextConstants.email,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: passwordController,
                      obsecureText: isPassHidden,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hint: TextConstants.password,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      isSuffixIcon: true,
                      suffixIcon: Icon(
                        isPassHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          isPassHidden = !isPassHidden;
                        });
                      },
                    ),

                    SizedBox(height: height * 0.01),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: customText.kText(
                            TextConstants.forgotPassword,
                            16,
                            FontWeight.w400,
                            ColorConstants.kSecondary,
                            TextAlign.center),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()));
                        },
                      ),
                    ),

                    SizedBox(height: height * 0.2),
                    CustomButton(
                      buttonText: TextConstants.login,
                      loader: isApiCalling,
                      onpress: () {
                        log("login button pressed");
                        login();
                      },
                    ),

                    SizedBox(height: height * 0.02),
                    CustomButton(
                      buttonText: TextConstants.createAccount,
                      onpress: () {
                        emailController.clear();
                        passwordController.clear();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()));
                      },
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// Positioned(
//   top: height * 0.45,
//   child: Stack(
//     children: [
//       SizedBox(
//         height: width * 0.25,
//         child: customText.kHeadingText(TextConstants.appTitle, 75,
//             FontWeight.w800, Colors.white, TextAlign.center),
//       ),
//       Positioned(
//         top: -1,
//         left: -1,
//         child: SizedBox(
//           height: width * 0.25,
//           child: customText.kHeadingText(
//               TextConstants.appTitle,
//               75,
//               FontWeight.w800,
//               ColorConstants.kTextGreen,
//               TextAlign.center),
//         ),
//       ),
//     ],
//   ),
// ),


// if(emailController.text == "admin@gmail.com"){
//   box.write("userId", "1");
//   box.write("userType", "admin");
//   loginController.userId = "1";
//   loginController.userType = "admin";
//   helper.successDialog("User logged in successfully");
//   Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard() ));
// } else if(emailController.text == "advisor@gmail.com") {
//   box.write("userId", "2");
//   box.write("userType", "advisor");
//   loginController.userId = "2";
//   loginController.userType = "advisor";
//   helper.successDialog("User logged in successfully");
//   Navigator.push(context, MaterialPageRoute(builder: (context) => const AdvisorDashboard() ));
// } else if(emailController.text == "farmer@gmail.com") {
//   box.write("userId", "3");
//   box.write("userType", "farmer");
//   loginController.userId = "3";
//   loginController.userType = "farmer";
//   helper.successDialog("User logged in successfully");
//   Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmerDashboard() ));
// } else if(emailController.text == "student@gmail.com") {
//   box.write("userId", "4");
//   box.write("userType", "student");
//   loginController.userId = "4";
//   loginController.userType = "student";
//   helper.successDialog("User logged in successfully");
//   Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentDashboard() ));
// } else if(emailController.text == "user@gmail.com") {
//   box.write("userId", "5");
//   box.write("userType", "user");
//   loginController.userId = "5";
//   loginController.userType = "user";
//   helper.successDialog("User logged in successfully");
//   Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDashboard() ));
// }
