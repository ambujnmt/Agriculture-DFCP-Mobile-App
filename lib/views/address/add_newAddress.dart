import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_appBar.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/address/new_address.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';

class AddNewAddress extends StatefulWidget {
  final Map<String, dynamic>? addressData;
  const AddNewAddress({super.key, this.addressData});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {

  final customText = CustomText(), helper = Helper(), api = API();
  dynamic height, width;
  bool fetchingCities = false, isApiCalling = false;
  String countryValue = "", address = "", addressType = "", stateId = "", cityId = "";
  String? stateValue, cityValue;
  List statesList = [], citiesList = [];
  List<String> statesName = [], citiesName = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    getStateList();
  }

  getStateList() async {

    final response = await api.getStates();

    if(response["status"] == 1) {
      setState(() {
        statesList = response["result"];
      });
      for(int i = 0; i < statesList.length; i++) {
        statesName.add(statesList[i]["name"]);
      }
    }

    log("states list in new address :- $statesList");
    if(widget.addressData != null){
      await manageData();
    }

  }

  manageData() async {

    log("widget.addressData :- ${widget.addressData}");

    Map<String, dynamic> data = widget.addressData!;

    nameController.text = data["name"];
    emailController.text = data["email"];
    phoneController.text = data["phone"];
    addressController.text = data["address"];
    areaController.text = data["area"];
    zipController.text = data["zipcode"];
    addressType = data["address_type"];

    for(int i = 0; i < statesList.length; i++) {
      if(statesList[i]["id"] == data["state_id"]) {
        setState(() {
          stateValue = statesList[i]["name"];
        });
      }
    }

    final citiesResponse = await api.getCities(data["state_id"]);

    if(citiesResponse["status"] == 1) {
      setState(() {
        citiesList = citiesResponse["result"];
      });
      for(int i = 0; i < citiesList.length; i++) {
        citiesName.add(citiesList[i]["name"]);
        if(data["city_id"] == citiesList[i]["id"]){
          setState(() {
            cityValue = citiesList[i]["name"];
          });
        }
      }
    }

  }

  getCityList() async {

    setState(() {
      fetchingCities = true;
    });

    String stateId = "";

    for(int i = 0; i < statesList.length; i++) {
      if(statesList[i]["name"] == stateValue){
        setState(() {
          stateId = statesList[i]["id"];
        });
      }
    }

    log("stateId before getting cities list :- $stateId, ${stateId.runtimeType}");

    final response = await api.getCities(stateId);

    if(response["status"] == 1) {
      citiesList.clear();
      citiesName.clear();
      cityValue = null;
      setState(() {
        citiesList = response["result"];
      });
      for(int i = 0; i <citiesList.length; i++) {
        citiesName.add(citiesList[i]["name"]);
      }
      setState(() {});
    }

    setState(() {
      fetchingCities = false;
    });

    log("cities list in new address :- $citiesList, $citiesName");

  }

  addUpdateAddress() async {

    for(int i = 0; i < statesList.length; i++) {
      if(stateValue == statesList[i]["name"]) {
        setState(() {
          stateId = statesList[i]["id"];
        });
      }
    }

    for(int i = 0; i < citiesList.length; i++) {
      if(cityValue == citiesList[i]["name"]) {
        setState(() {
          cityId = citiesList[i]["id"];
        });
      }
    }

    log("state id and city id :- $stateId, $cityId");

    if(nameController.text.length > 3 && !nameController.text.startsWith(" ")){
      if(phoneController.text.length == 10) {
        if(EmailValidator.validate(emailController.text)) {
          if(addressController.text.isNotEmpty && !addressController.text.startsWith(" ")){
            if(areaController.text.isNotEmpty && !areaController.text.startsWith(" ")) {
              if(stateValue != null) {
                if(cityValue != null) {
                  if(zipController.text.length == 6 && !zipController.text.startsWith(" ")) {
                    if(addressType != "") {

                      setState(() {
                        isApiCalling = true;
                      });

                      final response;

                      if(widget.addressData != null) {

                        response = await api.updateAddress(nameController.text,
                          emailController.text, phoneController.text, addressController.text,
                          areaController.text, cityId, stateId, zipController.text,
                          addressType, widget.addressData!["id"]);

                      } else {
                        response = await api.addAddress(nameController.text,
                          emailController.text, phoneController.text, addressController.text,
                          areaController.text, cityId, stateId, zipController.text, addressType);
                      }

                      setState(() {
                        isApiCalling = false;
                      });

                      if(response["status"] == 1) {
                        helper.successDialog(response["message"]);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NewAddress() ));
                      } else {
                        helper.errorDialog(response["message"]);
                        if(response["message"] == TextConstants.invalidToken) {
                          loginController.clearDataLogout();
                          helper.successDialog(TextConstants.logoutSuccess);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ProductsViewScreen()),
                          );
                        }
                      }

                    } else {
                      helper.errorDialog(TextConstants.selectAddressType);
                    }
                  } else {
                    helper.errorDialog(TextConstants.validZipCode);
                  }
                } else {
                  helper.errorDialog(TextConstants.selectCity);
                }
              } else {
                helper.errorDialog(TextConstants.selectState);
              }
            } else {
              helper.errorDialog(TextConstants.enterArea);
            }
          } else {
            helper.errorDialog(TextConstants.enterAddress);
          }
        } else {
          helper.errorDialog(TextConstants.validEmail);
        }
      } else {
        helper.errorDialog(TextConstants.validPhoneNo);
      }
    } else {
      helper.errorDialog(TextConstants.validUserName);
    }

  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomBar().appBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.addAddress,),

              // name
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.name, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              SizedBox(
                child: TextFormField(
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  cursorColor: ColorConstants.kPrimary,
                  style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: TextConstants.name,
                    hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              // phone
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.phone, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              SizedBox(
                child: TextFormField(
                  controller: phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  cursorColor: ColorConstants.kPrimary,
                  style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: TextConstants.phone,
                    hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              // email
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.email, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              SizedBox(
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: ColorConstants.kPrimary,
                  style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: TextConstants.email,
                    hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              // address
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.simpleAddress, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              SizedBox(
                child: TextFormField(
                  controller: addressController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  cursorColor: ColorConstants.kPrimary,
                  style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: TextConstants.simpleAddress,
                    hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              // area
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.area, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              SizedBox(
                child: TextFormField(
                  controller: areaController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  cursorColor: ColorConstants.kPrimary,
                  style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: TextConstants.area,
                    hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              // state
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.state, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    TextConstants.state,
                    overflow: TextOverflow.ellipsis,
                    style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kTextGrey),
                  ),
                  items: statesName
                      .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: customText.kTextStyle(20, FontWeight.w400, Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: stateValue,
                  onChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                    getCityList();
                  },
                  buttonStyleData: ButtonStyleData(
                    height: height * 0.06,
                    width: width * 0.95,
                    padding: const EdgeInsets.only(left:5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      border: Border.all(color: ColorConstants.kGrey),
                      // color: ColorConstants.kPrimary,
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 40,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: width * 0.92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      // color: ColorConstants.kPrimary,
                    ),
                    offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),

              // city
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.city, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              fetchingCities
              ? Container(
                  height: height * 0.06,
                  width: width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    border: Border.all(color: ColorConstants.kGrey),
                    // color: ColorConstants.kPrimary,
                  ),
                  child: const Center(
                    child: CustomProgressIndicator(),
                  ),
                )
              : DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    TextConstants.city,
                    overflow: TextOverflow.ellipsis,
                    style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kTextGrey),
                  ),
                  items: citiesName
                      .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: customText.kTextStyle(20, FontWeight.w400, Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: cityValue,
                  onChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: height * 0.06,
                    width: width * 0.95,
                    padding: const EdgeInsets.only(left:5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      border: Border.all(color: ColorConstants.kGrey),
                      // color: ColorConstants.kPrimary,
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 40,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: width * 0.92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      // color: ColorConstants.kPrimary,
                    ),
                    offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),

              // zipCode
              SizedBox(height: height * 0.02,),
              customText.kText(TextConstants.zipCode, 18, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.center),
              SizedBox(
                child: TextFormField(
                  controller: zipController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  cursorColor: ColorConstants.kPrimary,
                  style: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: TextConstants.zipCode,
                    hintStyle: customText.kTextStyle(18, FontWeight.w500, Colors.black),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorConstants.kGrey),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    child: Container(
                      height: height * 0.05,
                      // width: width * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: addressType == TextConstants.home ? ColorConstants.kPrimary : Colors.white,
                        border: Border.all(color: ColorConstants.kPrimary, width: 2),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.home, size: 20, color: addressType == TextConstants.home ? Colors.white : Colors.black,),
                          customText.kText(TextConstants.home, 18, FontWeight.w900, addressType == TextConstants.home ? Colors.white : Colors.black, TextAlign.center)
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        addressType = TextConstants.home;
                      });
                    },
                  ),

                  GestureDetector(
                    child: Container(
                      height: height * 0.05,
                      // width: width * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: addressType == TextConstants.work ? ColorConstants.kPrimary : Colors.white,
                        border: Border.all(color: ColorConstants.kPrimary, width: 2),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.work, size: 20, color: addressType == TextConstants.work ? Colors.white : Colors.black,),
                          customText.kText(TextConstants.work, 18, FontWeight.w900, addressType == TextConstants.work ? Colors.white : Colors.black, TextAlign.center)
                        ],
                      ),
                    ),
                    onTap: () {
                      log("select address type work is pressed");
                      setState(() {
                        addressType = TextConstants.work;
                      });
                    },
                  ),

                  GestureDetector(
                    child: Container(
                      height: height * 0.05,
                      // width: width * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: addressType == TextConstants.other ? ColorConstants.kPrimary : Colors.white,
                        border: Border.all(color: ColorConstants.kPrimary, width: 2),
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.apartment, size: 20, color: addressType == TextConstants.other ? Colors.white : Colors.black,),
                          customText.kText(TextConstants.other, 18, FontWeight.w900, addressType == TextConstants.other ? Colors.white : Colors.black, TextAlign.center)
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        addressType = TextConstants.other;
                      });
                    },
                  ),

                ],
              ),

              SizedBox(height: height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width * 0.35,
                    child: CustomButton(
                      buttonText: TextConstants.cancel,
                      onpress: () {
                        log("cancel pressed");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.35,
                    child: CustomButton(
                      buttonText: widget.addressData != null? TextConstants.update : TextConstants.buttonText,
                      loader: isApiCalling,
                      onpress: () {
                        addUpdateAddress();
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

            ],
          ),
        ),
      ),
    );
  }
}

