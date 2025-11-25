import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/auth/otp_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:developer';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  OverlayEntry? overlayEntry;
  final customText = CustomText(), helper = Helper(), api = API();
  bool isPassHidden = true, isApiCalling = false, isConditionsChecked = false;
  String? selectedValue;
  String userType = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  final List<String> items = [
    TextConstants.advisor,
    TextConstants.farmer,
    TextConstants.student,
    TextConstants.user
  ];


  register() async {

    if(nameController.text.length > 3 && !nameController.text.startsWith(" ")){
      if(phoneNoController.text.length == 10) {
        if(EmailValidator.validate(emailController.text)) {
          if(passwordController.text.length >= 8) {
            if(userType != "") {

              setState(() {
                isApiCalling = true;
              });

              final response = await api.registerAccount(nameController.text,
                phoneNoController.text, emailController.text,
                passwordController.text, userType, referralController.text);

              setState(() {
                isApiCalling = false;
              });

              if(response["status"] == 1) {
                log("user register successfully");
                Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(email: emailController.text) ));
              } else {
                helper.errorDialog(response["message"]);
              }

            } else {
              helper.errorDialog(TextConstants.validSelectUser);
            }
          } else {
            helper.errorDialog(TextConstants.validPassword);
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

  checkTermsConditions() {

    final size = MediaQuery.of(context).size;
    OverlayState overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black26,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.08),
          child: Container(
            height: size.height * 0.75,
            width: size.width * 0.75,
            padding: EdgeInsets.all(size.width * 0.03),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(size.width * 0.02)
            ),
            child: Column(
              children: [
                customText.kText(TextConstants.termsCondition, 25, FontWeight.w800, Colors.black, TextAlign.center),
                Container(
                  height: size.height * 0.7,
                  width: size.width,
                  margin: EdgeInsets.symmetric(vertical: size.width * 0.02),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText.kText("Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque cupiditate cum provident at! Dolorum fuga, deserunt est atque excepturi voluptas architecto exercitationem cumque delectus iste facilis quaerat in minima totam.", 16, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.visible, 10000),
                        ],
                      )
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        color: ColorConstants.kSecondary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.black38,
                              blurRadius: 4
                          ),
                          BoxShadow(
                              offset: Offset(0, -2),
                              color: Colors.black38,
                              blurRadius: 4
                          ),
                        ]
                    ),
                    child: Center(
                      child: customText.kText(TextConstants.accept, 20, FontWeight.w700, ColorConstants.kPrimary, TextAlign.center),
                    ),
                  ),
                  onTap: () {
                    overlayEntry?.remove();
                    setState(() {
                      isConditionsChecked = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry!);

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.18),
                  customText.kText(TextConstants.registration, 32, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                  SizedBox(height: height * 0.01),
                  customText.kText(TextConstants.registrationDesc, 16, FontWeight.w400, ColorConstants.kSecondary, TextAlign.center),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    hint: TextConstants.name,
                    prefixIcon: const Icon(Icons.person_outlined, color: Colors.white,),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: phoneNoController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    hint: TextConstants.phone,
                    prefixIcon: const Icon(Icons.contact_phone_outlined, color: Colors.white,),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hint: TextConstants.email,
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.white,),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: passwordController,
                    obsecureText: isPassHidden,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hint: TextConstants.password,
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.white,),
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
                  SizedBox(height: height * 0.02),
              
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          const Icon(
                            Icons.list,
                            size: 22,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              TextConstants.userType,
                              overflow: TextOverflow.ellipsis,
                              style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kSecondary),
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        selectedValue = value;
                        userType = helper.getUserType(value);
                        setState(() {});
                      },
                      buttonStyleData: ButtonStyleData(
                        height: height * 0.065,
                        width: width * 0.95,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          color: ColorConstants.kPrimary,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 22,
                        iconEnabledColor: Colors.white,
                        // iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: width * 0.94,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: ColorConstants.kPrimary,
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
              
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: referralController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hint: TextConstants.refer,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Image.asset("assets/images/refer.png", color: Colors.white),
                    )
                  ),

                  SizedBox(height: height * 0.05),

                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Checkbox(
                          activeColor: Colors.black,
                          value: isConditionsChecked,
                          onChanged: (bool? newValue) {
                            helper.alertMessage(TextConstants.readTerms);
                          },
                        ),

                        customText.kText(TextConstants.termsCondition, 18, FontWeight.w700, Colors.black, TextAlign.start)
                      ],
                    ),
                    onTap: () {
                      checkTermsConditions();
                    },
                  ),

                  CustomButton(
                    buttonText: TextConstants.register,
                    loader: isApiCalling,
                    onpress: () {
                      register();
                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
