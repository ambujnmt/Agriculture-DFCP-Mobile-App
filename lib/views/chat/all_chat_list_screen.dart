import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:textfield_search/textfield_search.dart';

class AllChatListScreen extends StatefulWidget {
  const AllChatListScreen({super.key});

  @override
  State<AllChatListScreen> createState() => _AllChatListScreenState();
}

class _AllChatListScreenState extends State<AllChatListScreen> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/add_image.png'))),
        ),
      ),
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
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            customText.kText(
              TextConstants.allChats,
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
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: height * .020),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(left: 20),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 206, 201, 201),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      color: ColorConstants.searchColor,
                      fontSize: 18,
                      fontFamily: "Red Rose"),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .020),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) => Container(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4, color: ColorConstants.kYellow),
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/girl_image.png'),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText.kText(
                              "Hannah",
                              22,
                              FontWeight.w400,
                              Colors.black,
                              TextAlign.center,
                            ),
                            Container(
                              height: 30,
                              width: width * .550,
                              child: customText.kText(
                                "A good example of a contains paragraph a topic sentence, details and a conclusion.",
                                12,
                                FontWeight.w400,
                                ColorConstants.chatColor,
                                TextAlign.start,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customText.kText(
                              "Just Now",
                              12,
                              FontWeight.w500,
                              Colors.black,
                              TextAlign.center,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: ColorConstants.kTextGreen,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: customText.kText(
                                  "${index + 1}",
                                  12,
                                  FontWeight.w500,
                                  ColorConstants.kYellow,
                                  TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}