import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_textField.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dfcp/views/meetings/meetings_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleMeeting extends StatefulWidget {
  const ScheduleMeeting({super.key});

  @override
  State<ScheduleMeeting> createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {
  dynamic size;
  final customText = CustomText();
  String meetingDate = "",
      meetingTime = "",
      tempPickedDate = "",
      currentDate = "";

  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

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
              MaterialPageRoute(builder: (context) => const MeetingsScreen()),
            );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kTextGreen, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
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
              Container(
                height: size.height * 0.065,
                width: size.width * 0.95,
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                    color: ColorConstants.kTextFieldColor,
                    borderRadius: BorderRadius.circular(size.width * 0.04)),
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
                            child: const Icon(
                              Icons.calendar_month,
                              size: 35,
                              color: ColorConstants.kYellow,
                            ),
                            onTap: () async {
                              DateTime? pickedDate;
                              // pickedDate = await showDatePicker(
                              //   context: context,
                              //   initialDate: DateTime.now(),
                              //   firstDate: DateTime(1950),
                              //   lastDate: DateTime(2200),
                              // );

                              currentDate = DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now());
                              log("current Date :- $currentDate, ${currentDate.runtimeType}");
                              tempPickedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate!);
                              log("temp picked Date :- $tempPickedDate");

                              if (pickedDate.isAfter(DateTime.now()) ||
                                  tempPickedDate == currentDate) {
                                // meetingDate = DateFormat('dd/MM/yyyy hh:mm:ss').format(pickedDate);
                                // 2024-05-29
                                meetingDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                log("meeting Date :- $meetingDate");
                                setState(() {});
                              } else {
                                // helper.errorDialog(context, "Please select valid date");
                              }
                            },
                          )
                        : GestureDetector(
                            child: const Icon(Icons.delete,
                                size: 35, color: Colors.white),
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
                // color: Colors.red,
                height: size.height * .45,
                width: double.infinity,
                child: SfCalendar(
                  onSelectionChanged: (value) {
                    print("Date is: ${value.date}");
                  },
                  view: CalendarView.month,
                  monthViewSettings: const MonthViewSettings(),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                  height: size.height * 0.065,
                  width: size.width * 0.95,
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: size.width * 0.05),
                  decoration: BoxDecoration(
                      color: ColorConstants.kTextFieldColor,
                      borderRadius: BorderRadius.circular(size.width * 0.04)),
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
                              child: const Icon(
                                Icons.schedule,
                                size: 35,
                                color: ColorConstants.kYellow,
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
                              child: Icon(Icons.delete,
                                  size: 35, color: Colors.white),
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
                    color: ColorConstants.kTextFieldColor,
                    borderRadius: BorderRadius.circular(size.width * 0.04)),
                child: TextField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  style: customText.kTextStyle(
                      18, FontWeight.w600, ColorConstants.kYellow),
                  // maxLines: 10,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: TextConstants.description,
                    hintStyle: customText.kTextStyle(
                        18, FontWeight.w600, ColorConstants.kYellow),
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
