import 'package:get/get.dart';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  String? userId, userType, accessToken, userName, userProfileImg;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {

    String? id = box.read("userId");

    if(id != null) {
      userId = id;
      userType = box.read("userType");
      accessToken = box.read("accessToken");
      userName = box.read("userName");
      userProfileImg = box.read("userProfileImg");
    }

  }

  clearDataLogout() {
    userId = null;
    userType = null;
    accessToken = null;
    userName = null;

    box.remove("userId");
    box.remove("userType");
    box.remove("accessToken");
    box.remove("userName");
  }

  bool isUserLoggedIn() {

    log("userId :- $userId");

    if(userId != null) {
      return true;
    } else {
      return false;
    }
  }

}