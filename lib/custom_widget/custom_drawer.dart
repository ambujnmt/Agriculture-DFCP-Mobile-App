import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/chat/all_chat_list_screen.dart';
import 'package:dfcp/views/meetings/meetings_screen.dart';
import 'package:dfcp/views/orders/orders_dashboard_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dfcp/views/referral/referral_screen.dart';
import 'package:dfcp/views/services/services_view_screen.dart';
import 'package:dfcp/views/static_content/engagement_agreement_screen.dart';
import 'package:dfcp/views/static_content/general_information.dart';
import 'package:dfcp/views/static_content/regulations_screen.dart';
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
                  margin: const EdgeInsets.only(left: 2),
                  child: customText.kText(
                    TextConstants.profile.toUpperCase(),
                    22,
                    FontWeight.w700,
                    ColorConstants.drawerTextColor,
                    TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductsViewScreen()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.products.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicesViewScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.services.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersDashboardScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.orders.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllChatListScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.chat.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeetingsScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.scheduleMeeting.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegulationScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.regulation.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneralInformation(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.generalInfo.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EngagementAgreementScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.engagementAgreement.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReferralScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.referralLink.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.drawerTextColor,
                TextAlign.start,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: height * 0.05,
            child: customText.kText(
              TextConstants.wallet.toUpperCase(),
              20,
              FontWeight.w700,
              ColorConstants.drawerTextColor,
              TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: height * 0.05,
            child: customText.kText(
              TextConstants.logout.toUpperCase(),
              20,
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
