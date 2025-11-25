import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:flutter/material.dart';


class Queries extends StatefulWidget {
  const Queries({super.key});

  @override
  State<Queries> createState() => _QueriesState();
}

class _QueriesState extends State<Queries> {

  final customText = CustomText(), api = API(), helper= Helper();

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

              const CustomTitle(title: TextConstants.queries),

              Expanded(
                child: Container(
                  width: width,
                  // color: Colors.blue.shade200,
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        for(int i = 0; i < 3; i++)
                        Container(
                          // height: height * 0.2,
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                          margin: EdgeInsets.only(bottom: height * 0.02),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorConstants.lightGreyColor),
                            borderRadius: BorderRadius.circular(width * 0.05)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              customText.kText("Hanna", 22, FontWeight.w400, Colors.black, TextAlign.center),

                              SizedBox(height: height * 0.01,),

                              customText.kText(
                                "A good example of a contains paragraph a topic sentence, details and a conclusion. "
                                "A good example of a contains paragraph a topic sentence, details and a conclusion. "
                                "A good example of a contains paragraph a topic sentence, details and a conclusion. "
                                "A good example of a contains paragraph a topic sentence, details and a conclusion.",
                                15, FontWeight.w400, ColorConstants.kGrey, TextAlign.start, TextOverflow.visible, 10)

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                )
              )


            ],
          ),
        ),
      ),

    );
  }
}
