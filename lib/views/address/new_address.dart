import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/address/add_newAddress.dart';
import 'package:dfcp/views/auth/login_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';

class NewAddress extends StatefulWidget {
  final String? comingFrom;
  const NewAddress({super.key, this.comingFrom});

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {

  bool isApiCalling = false, isAddressDeleting = false;
  dynamic height, width;
  int deleteIndex = 0;
  final customText = CustomText(), helper = Helper(), api = API();
  List addressesList = [], statesList = [], managedStates = [], citiesList = [],
  managedCities = [];

  LoginController loginController = Get.put(LoginController());
  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  getAddress() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getAddress();

    if(response["status"] == 1) {
      setState(() {
        addressesList = response["addresses"];
      });
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

    log("addresses list in address list :- $addressesList");

    for(int i = 0; i < addressesList.length; i++){
      await manageStateCity(addressesList[i]);
    }

    setState(() {
      isApiCalling = false;
    });

  }

  manageStateCity(Map<String, dynamic> address) async {

    final statesResponse = await api.getStates();

    if(statesResponse["status"] == 1) {
      setState(() {
        statesList = statesResponse["result"];
      });
      for(int i = 0; i < statesList.length; i++) {
        if(address["state_id"] == statesList[i]["id"]){
          managedStates.add(statesList[i]["name"]);
        }
      }
    }
    
    final citiesResponse = await api.getCities(address["state_id"]);

    if(citiesResponse["status"] == 1) {
      setState(() {
        citiesList = citiesResponse["result"];
      });
      for(int i = 0; i < citiesList.length; i++) {
        if(address["city_id"] == citiesList[i]["id"]){
          managedCities.add(citiesList[i]["name"]);
        }
      }
    }

    log("managed Cities & managed States :- $managedCities $managedStates");

  }
  
  deleteAddress(String addressId) async {
    
    setState(() {
      isAddressDeleting = true;
    });
    
    final response = await api.deleteAddress(addressId);

    setState(() {
      isAddressDeleting = false;
    });

    if(response["status"] == 1) {
      helper.successDialog(response["message"]);
      getAddress();
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
    
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: ColorConstants.kPrimary, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                height: 25,
                child: Image.asset('assets/images/send_image1.png'),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
           // Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmerDashboard() ));
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        // color: Colors.yellow.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: isApiCalling
          ? const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomProgressIndicator(),
              )
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const CustomTitle(title: TextConstants.simpleAddress,),

                for(int i = 0; i < addressesList.length ; i++)
                Card(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.6,
                              // color: Colors.blue.shade300,
                              child: Row(
                                children: [

                                  addressesList[i]["address_type"] == "Home"
                                  ? const Icon(Icons.home, size: 30)
                                  : addressesList[i]["address_type"] == "Work"
                                    ? const Icon(Icons.work, size: 30)
                                    : const Icon(Icons.apartment, size: 30),

                                  SizedBox(width: width * 0.02),
                                  customText.kText(
                                    addressesList[i]["address_type"],
                                    18,
                                    FontWeight.w800,
                                    Colors.black,
                                    TextAlign.start,
                                  ),
                                ],
                              )
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  child: const Icon(Icons.edit, size: 30,),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewAddress(addressData: addressesList[i]) ));
                                  },
                                ),
                                SizedBox(width: width * 0.02,),
                                 GestureDetector(
                                    child: i == deleteIndex
                                     ?isAddressDeleting
                                        ? const Center(
                                            child: CustomProgressIndicator(),
                                          )
                                        : const Icon(Icons.delete, size: 30)
                                     : const Icon(Icons.delete, size: 30),
                                    onTap: () {
                                      setState(() {
                                        deleteIndex = i;
                                      });
                                      helper.alertDialog(context, TextConstants.deleteAlert,
                                        TextConstants.deleteAlertConfirmation,
                                          () { ScaffoldMessenger.of(context).removeCurrentSnackBar(); },
                                          () {
                                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                            deleteAddress(addressesList[i]["id"]);
                                          },
                                      );
                                    },
                                  )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: height * .010),
                        customText.kText(
                          addressesList[i]["name"],
                          16,
                          FontWeight.w400,
                          Colors.black,
                          TextAlign.start,
                        ),
                        SizedBox(height: height * .010),
                        customText.kText(
                          addressesList[i]["phone"],
                          16,
                          FontWeight.w400,
                          Colors.black,
                          TextAlign.start,
                        ),
                        SizedBox(height: height * .010),
                        customText.kText(
                          addressesList[i]["email"],
                          16,
                          FontWeight.w400,
                          Colors.black,
                          TextAlign.start,
                        ),
                        SizedBox(height: height * .010),
                        customText.kText(
                          "${addressesList[i]["address"]}, ${addressesList[i]["area"]}, ${managedCities[i]}, ${managedStates[i]}, ${addressesList[i]["zipcode"]}",
                          16,
                          FontWeight.w400,
                          Colors.black,
                          TextAlign.start,
                          TextOverflow.ellipsis,
                          5
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  child: SizedBox(
                    height: height * 0.05,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Center(
                        child: customText.kText(TextConstants.addAddress, 22, FontWeight.w600, Colors.black, TextAlign.center),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewAddress() ));
                    // openAddressDialog();
                  },
                )
              ],
            ),

        ),
      ),
    );
  }
}


// child: Material(
//   borderRadius: BorderRadius.circular(width * 0.1),
// child: Form(
//   key: addressController.formkey,
//   child: SingleChildScrollView(
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16.h),
//             CustomText(
//               text: "Add New Address".tr,
//               size: 22.sp,
//               weight: FontWeight.w700,
//             ),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "Full Name".tr),
//             SizedBox(height: 4.h),
//             CustomFormField(
//               controller: nameController,
//               validator: (name) =>
//                   ValidationRules().common(name),
//             ),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "Email".tr),
//             SizedBox(height: 4.h),
//             CustomFormField(
//               allowWhitespace: false,
//               controller: emailController,
//               validator: (email) =>
//                   ValidationRules().email(email),
//               // validator: (value) {
//               //   RegExp regExp = RegExp(regularExpressionEmail);
//               //   if (value!.isNotEmpty) {
//               //     if (!regExp.hasMatch(value)) {
//               //       return 'Enter Valid Email Address'.tr;
//               //     }
//               //   }
//               //   return null;
//               // },
//             ),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "Phone".tr),
//             SizedBox(height: 4.h),
//             CustomPhoneFormField(
//               phoneController: phoneController,
//               validator: (phone) =>
//                   ValidationRules().phone(phone),
//             ),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "COUNTRY".tr),
//             SizedBox(height: 4.h),
//             Obx(
//                   () => addressController
//                   .countryListMap.isNotEmpty
//                   ? PopupMenuButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.r),
//                   ),
//                 ),
//                 position: PopupMenuPosition.under,
//                 itemBuilder: (ctx) => List.generate(
//                     addressController
//                         .countryListModel!.data!.length,
//                         (index) => PopupMenuItem(
//                       height: 32.h,
//                       onTap: () async {
//                         countryController.text =
//                             addressController
//                                 .countryListModel!
//                                 .data![index]
//                                 .name
//                                 .toString();
//                         addressController
//                             .fetchStates(
//                             countryName:
//                             countryController
//                                 .text);
//                         stateController.clear();
//                         cityController.clear();
//                         addressController
//                             .stateListMap
//                             .clear();
//                         addressController
//                             .cityListMap
//                             .clear();
//                         setState(() {});
//                       },
//                       child: Text(
//                         addressController
//                             .countryListModel!
//                             .data![index]
//                             .name
//                             .toString(),
//                         style: GoogleFonts.urbanist(
//                           // color: AppColor.textColor,
//                             color: Colors.black,
//                             fontWeight:
//                             FontWeight.w500,
//                             fontSize: 16.sp),
//                       ),
//                     )),
//                 child: IgnorePointer(
//                   child: CustomFormField(
//                     controller: countryController,
//                     // validator: (country) => ValidationRules().normal(country),
//                     suffixIcon: Padding(
//                       padding: EdgeInsets.all(12.r),
//                       child: SvgPicture.asset(
//                           SvgIcon.down),
//                     ),
//                     isSuffixIcon: true,
//                     enabled: false,
//                   ),
//                 ),
//               )
//                   : CustomFormField(
//                 controller: countryController,
//                 // validator: (country) =>
//                 //     ValidationRules().normal(country),
//                 suffixIcon: Padding(
//                   padding: EdgeInsets.all(12.r),
//                   child: SvgPicture.asset(SvgIcon.down),
//                 ),
//                 isSuffixIcon: true,
//                 enabled: false,
//               ),
//             ),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "STATE".tr),
//             SizedBox(height: 4.h),
//             Obx(() => addressController
//                 .stateListMap.isNotEmpty
//                 ? PopupMenuButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.r),
//                 ),
//               ),
//               position: PopupMenuPosition.under,
//               itemBuilder: (ctx) => List.generate(
//                   addressController
//                       .stateListModel!.data!.length,
//                       (index) => PopupMenuItem(
//                     height: 32.h,
//                     onTap: () async {
//                       stateController.text =
//                           addressController
//                               .stateListModel!
//                               .data![index]
//                               .name
//                               .toString();
//                       addressController.fetchCities(
//                           stateName:
//                           stateController.text);
//                       addressController
//                           .cityController
//                           .clear();
//                       addressController.cityListMap
//                           .clear();
//                       setState(() {});
//                     },
//                     child: Text(
//                       addressController
//                           .stateListModel!
//                           .data![index]
//                           .name
//                           .toString(),
//                       style: GoogleFonts.urbanist(
//                           color: AppColor.textColor,
//                           fontWeight:
//                           FontWeight.w500,
//                           fontSize: 16.sp),
//                     ),
//                   )),
//               child: IgnorePointer(
//                 child: CustomFormField(
//                   controller: stateController,
//                   suffixIcon: Padding(
//                     padding: EdgeInsets.all(12.r),
//                     child:
//                     SvgPicture.asset(SvgIcon.down),
//                   ),
//                   isSuffixIcon: true,
//                   enabled: false,
//                 ),
//               ),
//             )
//                 : CustomFormField(
//               controller: stateController,
//               suffixIcon: Padding(
//                 padding: EdgeInsets.all(12.r),
//                 child: SvgPicture.asset(SvgIcon.down),
//               ),
//               isSuffixIcon: true,
//               enabled: false,
//             )),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "CITY".tr),
//             SizedBox(height: 4.h),
//             Obx(() => addressController.cityListMap.isNotEmpty
//                 ? PopupMenuButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.r),
//                 ),
//               ),
//               position: PopupMenuPosition.under,
//               itemBuilder: (ctx) => List.generate(
//                   addressController
//                       .cityListModel!.data!.length,
//                       (index) => PopupMenuItem(
//                     height: 32.h,
//                     onTap: () async {
//                       cityController.text =
//                           addressController
//                               .cityListModel!
//                               .data![index]
//                               .name
//                               .toString();
//                       setState(() {});
//                     },
//                     child: Text(
//                       addressController
//                           .cityListModel!
//                           .data![index]
//                           .name
//                           .toString(),
//                       style: GoogleFonts.urbanist(
//                           color: AppColor.textColor,
//                           fontWeight:
//                           FontWeight.w500,
//                           fontSize: 16.sp),
//                     ),
//                   )),
//               child: IgnorePointer(
//                 child: CustomFormField(
//                   controller: cityController,
//                   suffixIcon: Padding(
//                     padding: EdgeInsets.all(12.r),
//                     child:
//                     SvgPicture.asset(SvgIcon.down),
//                   ),
//                   isSuffixIcon: true,
//                   enabled: false,
//                 ),
//               ),
//             )
//                 : CustomFormField(
//               controller: cityController,
//               suffixIcon: Padding(
//                 padding: EdgeInsets.all(12.r),
//                 child: SvgPicture.asset(SvgIcon.down),
//               ),
//               isSuffixIcon: true,
//               enabled: false,
//             )),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "Zip Code".tr),
//             SizedBox(height: 4.h),
//             CustomFormField(
//               maxLength: 5,
//               counterText: "",
//               keyboardType: TextInputType.number,
//               controller: zipCodeController,
//               validator: (address) =>
//                   ValidationRules().numeric(address!),
//             ),
//             SizedBox(height: 10.h),
//             FormFieldTitle(title: "Street Address".tr),
//             SizedBox(height: 4.h),
//             CustomFormField(
//               controller: streetAddressController,
//               validator: (address) =>
//                   ValidationRules().common(address),
//             ),
//             SizedBox(height: 24.h),
//             Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//               children: [
//                 SecondaryButton2(
//                     height: 48.h,
//                     width: 158.w,
//                     text: "Add Address".tr,
//                     buttonColor: AppColor.primaryColor,
//                     textColor: AppColor.whiteColor,
//                     onTap: () async {
//                       log("add address button pressed");
//                       if (addressController
//                           .formkey.currentState!
//                           .validate()) {
//                         log("country controller :- ${countryController.text}");
//
//                         addAddress();
//
//                         // if (box.read("token") != null) {
//                         //   await addressController.submitAddress();
//                         //   await showAddressController.showAdresses();
//                         //   profile.getAddress();
//                         // } else {
//                         //   Get.off(() => const SignInScreen());
//                         // }
//                       }
//                     }),
//                 SecondaryButton2(
//                   height: 48.h,
//                   width: 114.w,
//                   text: "Cancel".tr,
//                   buttonColor: AppColor.cartColor,
//                   textColor: AppColor.textColor,
//                   onTap: () {
//                     Get.back();
//                   },
//                 )
//               ],
//             ),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     ),
//   ),
// ),
// ),
