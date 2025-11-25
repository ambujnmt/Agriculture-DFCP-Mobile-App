import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({super.key});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  final customText = CustomText();
  bool isChecked = false;
  final List<String> monthItems = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ];

  List<String> yearItems = [
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
  ];
  String? selectedValueMonth;
  String? selectedValueYear;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const DashboardScreen()),
            // );
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(title: TextConstants.completeYourPayment,),
            SizedBox(height: height * .030),
            customText.kText(TextConstants.enterAmount, 20, FontWeight.w400,
                ColorConstants.kPrimary, TextAlign.start),
            SizedBox(height: height * .010),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.currency_rupee_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .020),
            customText.kText(TextConstants.cardNumber, 20, FontWeight.w400,
                ColorConstants.kPrimary, TextAlign.start),
            SizedBox(height: height * .010),
            Container(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .010),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: customText.kText("Month", 20, FontWeight.w400,
                            ColorConstants.kPrimary, TextAlign.start),
                      ),
                      Container(
                        width: width * .25,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Expanded(
                              child: Text(
                                TextConstants.mm,
                                overflow: TextOverflow.ellipsis,
                                style: customText.kTextStyle(
                                  20,
                                  FontWeight.w400,
                                  Colors.black,
                                ),
                              ),
                            ),
                            items: monthItems
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: customText.kTextStyle(
                                            20, FontWeight.w400, Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValueMonth,
                            onChanged: (value) {
                              setState(() {
                                selectedValueMonth = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: height * 0.065,
                              width: width * 0.95,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius:
                                    BorderRadius.circular(width * 0.04),
                                color: Colors.white,
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                // color: ColorConstants.kPrimary,
                              ),
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width * .2),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: customText.kText("Year", 20, FontWeight.w400,
                            ColorConstants.kPrimary, TextAlign.start),
                      ),
                      Container(
                        width: width * .25,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Expanded(
                              child: Text(
                                TextConstants.yy,
                                overflow: TextOverflow.ellipsis,
                                style: customText.kTextStyle(
                                  20,
                                  FontWeight.w400,
                                  Colors.black,
                                ),
                              ),
                            ),
                            items: yearItems
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: customText.kTextStyle(
                                            20, FontWeight.w400, Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValueYear,
                            onChanged: (value) {
                              setState(() {
                                selectedValueYear = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: height * 0.065,
                              width: width * 0.95,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius:
                                    BorderRadius.circular(width * 0.04),
                                color: Colors.white,
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                // color: ColorConstants.kPrimary,
                              ),
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .010),
            Container(
              child: customText.kText("CVV", 20, FontWeight.w400,
                  ColorConstants.kPrimary, TextAlign.start),
            ),
            Container(
              height: 50,
              width: width * .25,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .010,
            ),
            Container(
              child: customText.kText(
                TextConstants.masterCard,
                20,
                FontWeight.w400,
                ColorConstants.kPrimary,
                TextAlign.start,
              ),
            ),
            SizedBox(
              height: height * .010,
            ),
            // check box
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: ColorConstants.kPrimary,
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                SizedBox(
                  width: width * .05,
                ),
                Container(
                  width: width * .75,
                  child: customText.kText(
                    TextConstants.checkText,
                    20,
                    FontWeight.w400,
                    ColorConstants.kPrimary,
                    TextAlign.start,
                  ),
                )
              ],
            ),

            SizedBox(width: width * .2),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  buttonText: TextConstants.payNow,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
