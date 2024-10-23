import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AdvisorTabView extends StatefulWidget {
  const AdvisorTabView({super.key});

  @override
  State<AdvisorTabView> createState() => _AdvisorTabViewState();
}

class _AdvisorTabViewState extends State<AdvisorTabView> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) => SizedBox(
          height: 75,
          width: double.infinity,
          child: GestureDetector(
            child: Container(
              // color: Colors.grey,
              padding: EdgeInsets.symmetric(vertical: width * 0.01),
              margin: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width * 0.03),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 4, color: ColorConstants.kYellow),
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/girl_image.png'),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: height * 0.035,
                            width: width * 0.59,
                            // color: Colors.red,
                            child: customText.kEllipseText(
                                "Hannah",
                                18,
                                FontWeight.w400,
                                Colors.black,
                                TextAlign.start,
                                TextOverflow.ellipsis,
                                1),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // height: height * 0.045,
                            width: width * 0.65,
                            // color: Colors.yellow,
                            child: customText.kEllipseText(
                                "A good example of a contains paragraph a topic sentence, details and a conclusion. ",
                                12,
                                FontWeight.w400,
                                ColorConstants.chatColor,
                                TextAlign.start,
                                TextOverflow.ellipsis,
                                2),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
          ),
        ),
      ),
    ));
  }
}
