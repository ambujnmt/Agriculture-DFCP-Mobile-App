import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class ServicesViewScreen extends StatefulWidget {
  const ServicesViewScreen({super.key});

  @override
  State<ServicesViewScreen> createState() => _ServicesViewScreenState();
}

class _ServicesViewScreenState extends State<ServicesViewScreen> {
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
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText.kText(
                TextConstants.services,
                30,
                FontWeight.w700,
                ColorConstants.kTextGreen,
                TextAlign.center,
              ),
              const DividerWidget(),
              const SizedBox(height: 20),
              containerAndText(),
              const SizedBox(height: 20),
              textAndContainer(),
              const SizedBox(height: 20),
              containerAndText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerAndText() {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          height: 180,
          width: 180,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/services_image.png'),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: customText.kText('Lorem Ipsum', 20, FontWeight.w700, ColorConstants.kTextGreen, TextAlign.center),
            ),
            const DividerWidget(),
            Container(
              width: width * .3,
              margin: const EdgeInsets.only(top: 10),
              child: customText.kText('Why do we use it ?', 20, FontWeight.w400, Colors.black, TextAlign.start),
            ),
          ],
        ),
      ],
    );
  }

  Widget textAndContainer() {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: customText.kText('Lorem Ipsum', 20, FontWeight.w700, ColorConstants.kTextGreen, TextAlign.start),
              ),
              const DividerWidget(),
              Container(
                width: width * .3,
                margin: const EdgeInsets.only(top: 10),
                child: customText.kText('Why do we use it ?', 20, FontWeight.w400, Colors.black, TextAlign.start),
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          width: 180,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/services_image.png'),
            ),
          ),
        ),
      ],
    );
  }

}
