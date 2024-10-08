import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: ColorConstants.kTextGreen,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorConstants.kTextGreen,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/beautiful-blooming-flowers-spring-season_23-2150790288.jpg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 30),
                      child: customText.kText(
                        "Pradeep",
                        30,
                        FontWeight.w700,
                        ColorConstants.drawerTextColor,
                        TextAlign.center,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: customText.kText(
                    "Profile",
                    22,
                    FontWeight.w700,
                    ColorConstants.drawerTextColor,
                    TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Products",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Services",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Orders",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Chat",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Schedule Meeting",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Regulation",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "General Information",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Engagement Agreement",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Refferal link",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Wallet",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: customText.kText(
              "Logout",
              25,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
