import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/queries/queries.dart';
import 'package:flutter/material.dart';


class InputQuery extends StatefulWidget {
  const InputQuery({super.key});

  @override
  State<InputQuery> createState() => _InputQueryState();
}

class _InputQueryState extends State<InputQuery> {

  final customText = CustomText(), api = API(), helper = Helper();

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
            Navigator.pop(context);
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      ),

      body: SafeArea(
        child: Container(
          width: width,
          // color: Colors.yellow.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.query),

              Expanded(
                child: Container(
                  width: width,
                  // color: Colors.blue.shade200,
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        customText.kText(TextConstants.enterQuery, 20, FontWeight.w400, ColorConstants.kSecondary, TextAlign.start),

                        SizedBox(height: height * 0.01),

                        customText.kText(TextConstants.queryInputDesc, 15, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start),

                        SizedBox(height: height * 0.02),

                        SizedBox(
                          child: TextFormField(
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            // controller: longDesController,
                            // validator: validator,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.multiline,
                            cursorColor: ColorConstants.kPrimary,
                            style: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: TextConstants.enterQueryHere,
                              hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                              contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorConstants.lightGreyColor),
                                borderRadius: BorderRadius.circular(width * 0.02),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorConstants.lightGreyColor),
                                borderRadius: BorderRadius.circular(width * 0.02),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorConstants.lightGreyColor),
                                borderRadius: BorderRadius.circular(width * 0.02),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.23),

                        CustomButton(
                          buttonText: TextConstants.submit,
                          onpress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Queries() ));
                          },
                        )

                      ],
                    )
                  ),
                ),
              )
            ],
          )
        ),
      )

    );
  }
}
