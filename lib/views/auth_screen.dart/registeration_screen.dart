import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/auth_screen.dart/success_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final customText = CustomText();
  bool isPassHidden = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  final List<String> items = [
    TextConstants.advisor,
    TextConstants.farmer,
    TextConstants.student,
    TextConstants.user
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.18),
                  customText.kText(TextConstants.registration, 32, FontWeight.w700, ColorConstants.kYellow, TextAlign.center),
                  SizedBox(height: height * 0.01),
                  customText.kText(TextConstants.registrationDesc, 16, FontWeight.w400, ColorConstants.kYellow, TextAlign.center),
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
                              style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kYellow),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
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
                  SizedBox(height: height * 0.1),
                  CustomButton(
                    buttonText: 'Register',
                    onpress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen() ));
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
