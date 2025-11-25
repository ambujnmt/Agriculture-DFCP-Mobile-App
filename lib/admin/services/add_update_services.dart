import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/background.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AddUpdateServices extends StatefulWidget {
  const AddUpdateServices({super.key});

  @override
  State<AddUpdateServices> createState() => _AddUpdateServicesState();
}

class _AddUpdateServicesState extends State<AddUpdateServices> {

  final customText = CustomText();
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();

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
                  SizedBox(height: height * 0.08),
                  GestureDetector(
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.white,)
                    ),
                    onTap: () {
                      log("on back pressed");
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: height * 0.05),
                  customText.kText(TextConstants.addService, 32, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    hint: TextConstants.name,
                    prefixIcon: const Icon(Icons.home_repair_service_outlined, color: Colors.white,),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                  width: width * 0.95,
                  decoration: BoxDecoration(
                      color: ColorConstants.kPrimary,
                      borderRadius: BorderRadius.circular(width * 0.04)),
                  child: TextField(
                    maxLines: 12,
                    controller: desController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    style: customText.kTextStyle(20, FontWeight.w400, ColorConstants.kSecondary),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: TextConstants.description,
                        hintStyle: customText.kTextStyle(
                            20, FontWeight.w400, ColorConstants.kSecondary),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: height * 0.39),
                          child: const Icon(Icons.description_outlined, color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  CustomButton(
                    buttonText: TextConstants.add,
                    onpress: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen(from: "registration") ));
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
