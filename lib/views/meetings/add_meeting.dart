import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class AddMeeting extends StatefulWidget {
  const AddMeeting({super.key});

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {

  dynamic size;
  final customText = CustomText();
  String meetingDate = "", meetingTime = "", tempPickedDate = "", currentDate = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();

  final List<String> items = [
    TextConstants.advisor,
    TextConstants.farmer,
    TextConstants.student,
    TextConstants.user
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: ColorConstants.kTextGreen, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                height: 25,
                child: Image.asset('assets/images/send_image1.png'),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle,
            45, FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              customText.kText(
                TextConstants.meetings,
                30,
                FontWeight.w700,
                ColorConstants.kTextGreen,
                TextAlign.center,
              ),
              const DividerWidget(),
              SizedBox(height: size.height * 0.02),
              CustomTextField(
                controller: nameController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hint: TextConstants.name,
                prefixIcon: const Icon(
                  Icons.person_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.065,
                width: size.width * 0.95,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                    color: ColorConstants.kTextFieldColor,
                    borderRadius: BorderRadius.circular(size.width * 0.04)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText.kText(
                        meetingDate == "" ? TextConstants.date : meetingDate,
                        18,
                        FontWeight.w600,
                        ColorConstants.kYellow,
                        TextAlign.start),
          
                    meetingDate == ""
                        ? GestureDetector(
                            child: const Icon(Icons.calendar_month, size: 35, color: Colors.white,),
                            onTap: () async {
          
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2200));
          
                              currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                              log("current Date :- $currentDate, ${currentDate.runtimeType}");
                              tempPickedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
                              log("temp picked Date :- $tempPickedDate");
          
                              if(pickedDate.isAfter(DateTime.now()) || tempPickedDate == currentDate) {
          
                                // meetingDate = DateFormat('dd/MM/yyyy hh:mm:ss').format(pickedDate);
                                // 2024-05-29
                                meetingDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                log("meeting Date :- $meetingDate");
                                setState(() {});
          
                              } else {
                                // helper.errorDialog(context, "Please select valid date");
                              }
          
                            },
                          )
                        : GestureDetector(
                            child: const Icon(Icons.delete, size: 35, color: Colors.white),
                            onTap: () {
                              setState(() {
                                meetingDate = "";
                              });
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                  height: size.height * 0.065,
                  width: size.width * 0.95,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.05),
                  decoration: BoxDecoration(
                      color: ColorConstants.kTextFieldColor,
                      borderRadius: BorderRadius.circular(size.width * 0.04)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText.kText(
                          meetingTime == "" ? TextConstants.time : meetingTime,
                          18,
                          FontWeight.w600,
                          ColorConstants.kYellow,
                          TextAlign.start),
          
                      meetingTime == ""
                          ? GestureDetector(
                        child: const Icon(Icons.schedule, size: 35, color: Colors.white),
                        onTap: () async {
          
                          TimeOfDay initialTime = TimeOfDay.now();
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: initialTime,
                          );
          
                          if (pickedTime != null ) {
          
                            if(tempPickedDate == currentDate) {
          
                              if(pickedTime.hour > DateTime.now().hour) {
                                meetingTime = pickedTime.format(context);
                              } else if(pickedTime.hour == DateTime.now().hour) {
                                if(pickedTime.minute > DateTime.now().minute) {
                                  meetingTime = pickedTime.format(context);
                                } else {
                                  // helper.successDialog(context, "Please select future time");
                                }
                              }
          
                            } else {
                              meetingTime = pickedTime.format(context);
                            }
          
                            setState(() {});
          
                          } else {
                            // helper.errorDialog(context, "Time is not picked");
                          }
          
                        },
                      )
                          : GestureDetector(
                        child: Icon(Icons.delete, size: 35, color: Colors.white),
                        onTap: () {
                          setState(() {
                            meetingTime = "";
                          });
                        },
                      )
                    ],
                  )
              ),
              SizedBox(height: size.height * 0.02),
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
                    height: size.height * 0.065,
                    width: size.width * 0.95,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.04),
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
                    width: size.width * 0.94,
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
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.25,
                width: size.width,
                padding: EdgeInsets.all(size.width * 0.02),
                decoration: BoxDecoration(
                    color: ColorConstants.kTextFieldColor,
                    borderRadius: BorderRadius.circular(size.width * 0.04)
                ),
                child: TextField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  style: customText.kTextStyle(18, FontWeight.w600, ColorConstants.kYellow),
                  maxLines: 10,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: TextConstants.description,
                    hintStyle: customText.kTextStyle(18, FontWeight.w600, ColorConstants.kYellow),
          
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              CustomButton(
                buttonText: TextConstants.submit,
                onpress: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
