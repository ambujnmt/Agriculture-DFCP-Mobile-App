import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/meetings/meetings_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleMeeting extends StatefulWidget {
  final Map<String, dynamic>? userDetails;
  const ScheduleMeeting({super.key, this.userDetails});

  @override
  State<ScheduleMeeting> createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {

  dynamic size;
  bool isApiCalling = false;
  final customText = CustomText(), api = API(), helper = Helper();
  String meetingDate = "",
      meetingTime = "",
      tempPickedDate = "",
      currentDate = "";
  Map<String, dynamic> userDetails = {};

  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    userDetails = widget.userDetails!;
  }

  createMeeting() async {
    
    
    if(meetingDate != "") {
      if(meetingTime != "") {
        if(purposeController.text.isNotEmpty && !purposeController.text.startsWith(" ")) {
          if(descController.text.isNotEmpty && !descController.text.startsWith(" ")) {

            setState(() {
              isApiCalling = true;
            });

            final response = await api.createMeeting(userDetails["user_id"], meetingDate, meetingTime, purposeController.text, descController.text);

            setState(() {
              isApiCalling = false;
            });

            if(response["status"] == 1) {

              helper.successDialog(response["message"]);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MeetingsScreen() ));

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
            helper.errorDialog(TextConstants.validMeetingDesc);
          }
        } else {
          helper.errorDialog(TextConstants.validMeetingPurpose);
        }
      } else {
        helper.errorDialog(TextConstants.selectValidTime);
      }
    } else {
      helper.errorDialog(TextConstants.selectValidDate);
    }

    // setState(() {
    //   isApiCalling = true;
    // });

    // {user_id: 7, name: Kissan, mobile: 8588008108, email: farmer@getnada.com, user_type: 3, status: 1, profile_img: }

    // final response = await api.createMeeting(meetingUserId, date, time, purpose, description);

    // setState(() {
    //   isApiCalling = false;
    // });

  }

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
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              const CustomTitle(title: TextConstants.meetings,),
          
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.065,
                width: size.width * 0.95,
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                    color: ColorConstants.kPrimary,
                    borderRadius: BorderRadius.circular(size.width * 0.04)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText.kText(
                        meetingDate == "" ? TextConstants.date : meetingDate,
                        18,
                        FontWeight.w600,
                        ColorConstants.kSecondary,
                        TextAlign.start),
                    meetingDate == ""
                        ? GestureDetector(
                            child: const Icon(
                              Icons.calendar_month,
                              size: 35,
                              color: ColorConstants.kSecondary,
                            ),
                            onTap: () async {
                              DateTime? pickedDate;
                              pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2200),
                              );
          
                              currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                              log("current Date :- $currentDate, ${currentDate.runtimeType}");
          
                              tempPickedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
                              log("temp picked Date :- $tempPickedDate");
          
                              if (pickedDate.isAfter(DateTime.now()) || tempPickedDate == currentDate) {
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
                            child: const Icon(Icons.delete,
                                size: 25, color: Colors.white),
                            onTap: () {
                              setState(() {
                                meetingDate = "";
                              });
                            },
                          ),
                  ],
                ),
              ),
          
              // SizedBox(height: size.height * 0.02),
              // Container(
              //   // color: Colors.red,
              //   height: size.height * .45,
              //   width: double.infinity,
              //   child: SfCalendar(
              //     onSelectionChanged: (value) {
              //       print("Date is: ${value.date}");
              //     },
              //     view: CalendarView.month,
              //     monthViewSettings: const MonthViewSettings(),
              //   ),
              // ),
          
              SizedBox(height: size.height * 0.02),
              Container(
                  height: size.height * 0.065,
                  width: size.width * 0.95,
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: size.width * 0.05),
                  decoration: BoxDecoration(
                      color: ColorConstants.kPrimary,
                      borderRadius: BorderRadius.circular(size.width * 0.04)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText.kText(
                          meetingTime == "" ? TextConstants.time : meetingTime,
                          18,
                          FontWeight.w600,
                          ColorConstants.kSecondary,
                          TextAlign.start),
                      meetingTime == ""
                          ? GestureDetector(
                              child: const Icon(
                                Icons.schedule,
                                size: 35,
                                color: ColorConstants.kSecondary,
                              ),
                              onTap: () async {
                                TimeOfDay initialTime = TimeOfDay.now();
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: initialTime,
                                );
          
                                if (pickedTime != null) {
                                  if (tempPickedDate == currentDate) {
                                    if (pickedTime.hour > DateTime.now().hour) {
                                      meetingTime = pickedTime.format(context);
                                    } else if (pickedTime.hour ==
                                        DateTime.now().hour) {
                                      if (pickedTime.minute >
                                          DateTime.now().minute) {
                                        meetingTime =
                                            pickedTime.format(context);
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
                              child: const Icon(Icons.delete,
                                  size: 25, color: Colors.white),
                              onTap: () {
                                setState(() {
                                  meetingTime = "";
                                });
                              },
                            )
                    ],
                  )),
          
              SizedBox(height: size.height * 0.02),
              CustomTextField(
                controller: purposeController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hint: TextConstants.purpose,
                horizontalPadding: 20,
              ),
          
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.25,
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    color: ColorConstants.kPrimary,
                    borderRadius: BorderRadius.circular(size.width * 0.04)),
                child: TextField(
                  maxLines: null,
                  controller: descController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  style: customText.kTextStyle(
                      18, FontWeight.w600, ColorConstants.kSecondary),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: TextConstants.description,
                    hintStyle: customText.kTextStyle(
                        18, FontWeight.w600, ColorConstants.kSecondary),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.1,),
          
              CustomButton(
                buttonText: TextConstants.submit,
                loader: isApiCalling,
                onpress: () {
                  createMeeting();
                },
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
