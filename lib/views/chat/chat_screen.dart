import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'dart:developer';

import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  dynamic size;
  final customText = CustomText();

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List messageList = [
    "Hello",
    "Hi",
    "How are you ?",
    "I am good what about you man"
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [

            // background, profile image and name
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.22,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.08),
                      Expanded(
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: ColorConstants.buttonTextColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width * 0.08))
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: size.height,
                  width: size.width * 0.78,
                  padding: EdgeInsets.all(size.width * 0.03),
                  decoration: BoxDecoration(
                    color: ColorConstants.buttonTextColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width * 0.08))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.01),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.drawerTextColor,
                        ),
                        child: Container(
                          height: size.width * 0.11,
                          width: size.width * 0.11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage("https://s3-alpha-sig.figma.com/img/71d0/e14e/1ffff81188b5ac9981d7e96204f13c3f?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H1E11OX-7lIYPRci78sYbTSeev6r1vX2yqUXMwdj0kWNijWMbslMKd6EnbV7wtIBstHgWpl3toPdz6hubya~qIB4rNTeMK5WZ9BZQxBuHWC4iUxLNw-E8iBBpaExedASzziUenEb6iw~PYuxUcEuiT-TMzsNDuMcTQlqkmdpE4dNGRsH9Bd3Rl7IsMG9plKdOAkNp3Prk6qTcFLjsAqkmLGFd0NlYdZkUArXNgTUAmk-UTtJcesRwbiOkGpp7JPanjEOMt68RUzNBu27oviN9cEvYsYGnbPvIt1ii~4j8pDdcu88gdvMTefB-Pc99Kg-sTrqdvXVyfE9gj45zRzV0w__"),
                                  fit: BoxFit.cover
                              )
                          ),
                        )
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                        width: size.width * 0.55,
                        child: customText.kText("Hannah", 20, FontWeight.w400, ColorConstants.drawerTextColor, TextAlign.start),
                      )
                    ],
                  ),
                )
              ],
            ),

            //back button
            Container(
              height: size.height * 0.08,
              width: size.width * 0.22,
              decoration: BoxDecoration(
                color: ColorConstants.buttonTextColor,
              ),
              child: Container(
                height: 90,
                width: size.width * 0.22,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(size.width * 0.08))
                ),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: ColorConstants.buttonTextColor,
                      child: SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/send_image1.png'),
                      ),
                    ),
                  ),
                  onTap: () {
                    log("back button pressed");
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            // chat messages list
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.025,
              child: SizedBox(
                height: size.height * 0.73,
                width: size.width * 0.95,
                // color: Colors.white60,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    // return msgsList[index]["sender_id"] == driverId
                    return index % 2 == 0
                        ? ChatBubble(
                            clipper: ChatBubbleClipper5(
                                type: BubbleType.sendBubble),
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(top: 20),
                            backGroundColor: Colors.white,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: customText.kText(messageList[index], 14, FontWeight.w600, Colors.black, TextAlign.start)
                            ),
                          )
                        : ChatBubble(
                            clipper: ChatBubbleClipper5(
                                type: BubbleType.receiverBubble),
                            backGroundColor: ColorConstants.kChatMessageColor,
                            margin: const EdgeInsets.only(top: 20),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width * 0.7,
                              ),
                                child: customText.kText(messageList[index], 14, FontWeight.w600, Colors.white, TextAlign.start)
                            ),
                          );
                  },
                ),
              ),
            ),

            // message input or send button
            Positioned(
              bottom: 25,
              left: size.width * 0.025,
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.95,
                padding: EdgeInsets.only(left: size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width)
                ),
                child: Row(
                  children: [
                    // input message field
                    SizedBox(
                      width: size.width * 0.75,
                      child: TextField(
                        controller: messageController,
                        keyboardType: TextInputType.text,
                        style: customText.kTextStyle(16, FontWeight.w600, ColorConstants.kChatInputColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: TextConstants.chatInputPlaceholder,
                          hintStyle: customText.kTextStyle(16, FontWeight.w600, ColorConstants.kChatInputColor)
                        ),
                      ),
                    ),
                    //send button
                    GestureDetector(
                      child: SizedBox(
                        width: size.width * 0.15,
                        child: const Icon(Icons.send, size: 30,),
                      ),
                      onTap: () {
                        log("send button on tap");
                      },
                    )
                  ],
                ),
              ),
            )
        
          ],
        ),
      )
    );
  }
}
