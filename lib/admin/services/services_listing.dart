import 'package:dfcp/admin/services/add_update_services.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class ServicesListing extends StatefulWidget {
  const ServicesListing({super.key});

  @override
  State<ServicesListing> createState() => _ServicesListingState();
}

class _ServicesListingState extends State<ServicesListing> {


  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
        title: customText.kHeadingText(TextConstants.appTitle,
            45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),

      body: SafeArea(
        bottom: false,
        child: SizedBox(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitle(title: TextConstants.services,),
                    ],
                  )
              ),

              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [

                    ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return index % 2 == 0
                              ? containerAndText()
                              : textAndContainer();
                        }
                    ),

                    Container(
                      height: 55,
                      width: width,
                      decoration: BoxDecoration(
                          color: ColorConstants.kPrimary,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, -4),
                                blurRadius: 7.5,
                                color: Colors.black54
                            )
                          ]
                      ),
                    ),

                    Positioned(
                      bottom: 25,
                      child: GestureDetector(
                        child: Container(
                          height: 75,
                          width: width,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle,
                          ),
                          child: Image.asset('assets/images/add_image.png'),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUpdateServices() ));
                        },
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget containerAndText() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.15,
            width: width * 0.32,
            margin: EdgeInsets.only(right: width * 0.02),
            decoration: BoxDecoration(
              // image: const DecorationImage(
              //   image: AssetImage('assets/images/services_image.png'),
              // ),
                border: Border.all(color: ColorConstants.kPrimary, width: 1.5),
                borderRadius: BorderRadius.circular(width * 0.04)
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.6,
                margin: const EdgeInsets.only(bottom: 5),
                child: customText.kText('Lorem Ipsum', 20, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start, TextOverflow.ellipsis),
              ),
              const DividerWidget(),
              Container(
                width: width * 0.6,
                margin: const EdgeInsets.only(top: 5),
                child: customText.kText('Why do we use it ?', 18, FontWeight.w400, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textAndContainer() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.6,
                margin: const EdgeInsets.only(bottom: 5),
                child: customText.kText('Lorem Ipsum', 20, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start, TextOverflow.ellipsis),
              ),
              const DividerWidget(),
              Container(
                width: width * 0.6,
                margin: const EdgeInsets.only(top: 5),
                child: customText.kText('Why do we use it ?', 20, FontWeight.w400, Colors.black, TextAlign.start, TextOverflow.ellipsis, 3),
              ),
            ],
          ),
          Container(
            height: height * 0.15,
            width: width * 0.32,
            margin: EdgeInsets.only(left: width * 0.02),
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/services_image.png'),
              // ),
                border: Border.all(color: ColorConstants.kPrimary, width: 1.5),
                borderRadius: BorderRadius.circular(width * 0.04)
            ),
          ),
        ],
      ),
    );
  }

}
