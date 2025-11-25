import 'package:dfcp/utils/helper.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'dart:developer';

class LocationController extends GetxController {

  final helper = Helper();
  late LocationData locationData;
  late loc.Location location;
  late bool serviceEnabled;
  PermissionStatus permissionGranted = PermissionStatus.denied;

  @override
  void onInit() {
    super.onInit();
    location = loc.Location();
  }

  locationPermission() async {

    serviceEnabled = await location.serviceEnabled();
    log("check location service enables or not :- $serviceEnabled");

    if(!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    log("check location permission :- $permissionGranted");

    if(permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      log("location permission after requesting :- $permissionGranted");
      if(permissionGranted != PermissionStatus.granted){
        helper.permissionDialog("Required location permission. Please go to app settings and allow location permission.");
      }
    }

    log("check permission status after request :- $permissionGranted");

    return permissionGranted;

  }

  getLocation() async {

    locationData = await location.getLocation();
    return locationData;
    log("location data in location controller :- $locationData");

  }

}