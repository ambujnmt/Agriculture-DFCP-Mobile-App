import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
              child: Image.asset('assets/images/send_image.png'),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: Image.asset("assets/images/dfcp_image.png"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     GestureDetector(
              //       child: Container(
              //         height: 45,
              //         width: 45,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: ColorConstants.kTextGreen,
              //           image: DecorationImage(
              //             image: AssetImage('assets/images/send_image.png'),
              //           ),
              //         ),
              //       ),
              //       onTap: () {
              //         // _key.currentState!.openDrawer();
              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const DashboardScreen()),
              //         );
              //       },
              //     ),
              //     SizedBox(
              //       width: width * .3,
              //     ),
              //     Container(
              //       height: 40,
              //       width: width * .23,
              //       decoration: const BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage('assets/images/dfcp_image.png'),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 10),
              customText.kText(
                TextConstants.services,
                30,
                FontWeight.w700,
                ColorConstants.kTextGreen,
                TextAlign.center,
              ),
              Container(
                height: 5,
                width: width * .2,
                decoration: BoxDecoration(
                    color: ColorConstants.kYellow,
                    borderRadius: BorderRadius.circular(12)),
              ),
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
    return Container(
      child: Row(
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
                margin: EdgeInsets.only(top: 20),
                child: const Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                      color: ColorConstants.kTextGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Raleway"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 5,
                width: width * .2,
                decoration: BoxDecoration(
                    color: ColorConstants.kYellow,
                    borderRadius: BorderRadius.circular(12)),
              ),
              Container(
                width: width * .3,
                child: const Text(
                  'Why do we use it ?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Raleway"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textAndContainer() {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: const Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                        color: ColorConstants.kTextGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Raleway"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 5,
                  width: width * .2,
                  decoration: BoxDecoration(
                      color: ColorConstants.kYellow,
                      borderRadius: BorderRadius.circular(12)),
                ),
                Container(
                  width: width * .3,
                  child: const Text(
                    'Why do we use it ?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Raleway"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(right: 20),
            height: 180,
            width: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/services_image.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
