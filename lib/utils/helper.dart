import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {

  final customText = CustomText();

  bool isAlphanumeric(String input) {
    RegExp regExp = RegExp(r'^[ a-zA-Z0-9]+$');
    // /^[-_ a-zA-Z0-9]+$/
    return regExp.hasMatch(input);
  }

  bool isLocation(String input) {
    RegExp regExp = RegExp(r'^[,. a-zA-Z0-9]+$');
    return regExp.hasMatch(input);
  }

  errorDialog(message) {
    return Get.snackbar(
        TextConstants.error,
        message,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error, size: 35, color: Colors.redAccent,)
    );
  }

  successDialog(message) {
    return Get.snackbar(
      TextConstants.success,
      message,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.check_circle, size: 35, color: Colors.lightGreen,)
    );
  }

  alertMessage(message) {
    return Get.snackbar(
        TextConstants.alert,
        message,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.priority_high, size: 35, color: Colors.deepOrangeAccent,)
    );
  }

  permissionDialog(message) {
    return Get.snackbar(
        TextConstants.requiredPermission,
        message,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.priority_high, size: 35, color: Colors.deepOrangeAccent,)
    );
  }

  alertDialog(context, String title, String message, Function() cancel, Function() done) {
    final size = MediaQuery.of(context).size;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.fromLTRB(size.width * 0.03, 0, size.width * 0.03, size.height * 0.3),
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.black87,
        padding: EdgeInsets.all(size.width * 0.02),
        content: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber, size: 35, color: Colors.deepOrangeAccent),
                  SizedBox(width: size.width * 0.02,),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                        width: size.width * 0.75,
                        child: customText.kText(title, 20, FontWeight.w800, Colors.white, TextAlign.center),
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: customText.kText(message, 16, FontWeight.w400, Colors.white, TextAlign.start),
                      )
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: cancel,
                    child: SizedBox(
                      width: size.width * 0.4,
                      child: customText.kText(TextConstants.no, 18, FontWeight.w600, ColorConstants.kSecondary, TextAlign.center),
                    ),
                  ),

                  GestureDetector(
                    onTap: done,
                    child: SizedBox(
                      width: size.width * 0.4,
                      child: customText.kText(TextConstants.yes, 18, FontWeight.w600, ColorConstants.kPrimary, TextAlign.center),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  getUserType(value) {

    String output = "";

    switch(value.toString()) {
      case TextConstants.superAdmin:
        output = "1";
      case TextConstants.advisor:
        output = "2";
      case TextConstants.farmer:
        output = "3";
      case TextConstants.student:
        output = "4";
      case TextConstants.user:
        output = "5";
      case "1":
        output = TextConstants.superAdmin;
      case "2":
        output = TextConstants.advisor;
      case "3":
        output = TextConstants.farmer;
      case "4":
        output = TextConstants.student;
      case "5":
        output = TextConstants.user;
    }

    return output;

  }

}