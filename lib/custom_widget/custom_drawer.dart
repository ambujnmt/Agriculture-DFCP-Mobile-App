import 'package:dfcp/admin/affiliate/affiliate_members.dart';
import 'package:dfcp/admin/members/members_listing.dart';
import 'package:dfcp/admin/orders%20history/order_history.dart';
import 'package:dfcp/admin/products/products_listing.dart';
import 'package:dfcp/admin/reports/reports.dart';
import 'package:dfcp/admin/services/services_listing.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/address/new_address.dart';
import 'package:dfcp/views/advertise_news/advertise_news.dart';
import 'package:dfcp/views/auth/login_screen.dart';
import 'package:dfcp/views/cart/view_cart.dart';
import 'package:dfcp/views/chat/all_chat_list_screen.dart';
import 'package:dfcp/views/delivery_distance/delivery_distance.dart';
import 'package:dfcp/views/meetings/meetings_screen.dart';
import 'package:dfcp/views/orders/orders_dashboard_screen.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:dfcp/views/profile/profile_screen.dart';
import 'package:dfcp/views/profile/subscribe_screen.dart';
import 'package:dfcp/views/queries/queries_members.dart';
import 'package:dfcp/views/referral/referral_screen.dart';
import 'package:dfcp/views/services/services_view_screen.dart';
import 'package:dfcp/views/static_content/advertising_news.dart';
import 'package:dfcp/views/static_content/engagement_agreement_screen.dart';
import 'package:dfcp/views/static_content/general_information.dart';
import 'package:dfcp/views/static_content/regulations_screen.dart';
import 'package:dfcp/views/wallet/wallet_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final customText = CustomText(), helper = Helper();
  LoginController loginController = Get.put(LoginController());

  logOut() {
    loginController.clearDataLogout();
    helper.successDialog(TextConstants.logoutSuccess);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const ProductsViewScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: ColorConstants.kPrimary,
      child: loginController.isUserLoggedIn()
      ?ListView(
        physics: const NeverScrollableScrollPhysics(),
          children: [

            DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorConstants.kPrimary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        width: width * 0.43,
                        padding: const EdgeInsets.only(left: 10),
                        child: customText.kText(
                          loginController.userName!,
                          22,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 2),
                      child: customText.kText(
                        TextConstants.profile.toUpperCase(),
                        22,
                        FontWeight.w700,
                        ColorConstants.kSecondary,
                        TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                  ),
                ],
              ),
            ),

            if(loginController.userType == TextConstants.superAdmin)
              Container(
              height: height * 0.75,
              padding: EdgeInsets.only(bottom: height * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Dashboard
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.home.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Advisors
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MembersListing(from: 1) ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.advisors.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Farmers
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MembersListing(from: 2) ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.farmers.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Student
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MembersListing(from: 3) ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.students.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // User
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MembersListing(from: 4) ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.users.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Services
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(
                        //     builder: (context) => const ServicesViewScreen()),
                        // );
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ServicesListing() ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.services.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Products
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) => const ProductsViewScreen()),
                        // );
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const ProductsListing()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.products.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Order History
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistory() ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.orders.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Chat list
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
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.chat.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Meeting list
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeetingsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.meetings.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Advertising News
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdvertisingNews(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.advertiseAndNews.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Affiliate
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AffiliateMembers(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.manageAffiliate.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                    ),

                    // Receipt Invoice
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
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.receiptInvoice.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                    // Reports
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Reports() ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.reports.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                    // Logout
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: height * 0.05,
                        child: customText.kText(
                          TextConstants.logout.toUpperCase(),
                          20,
                          FontWeight.w700,
                          ColorConstants.kSecondary,
                          TextAlign.start,
                        ),
                      ),
                      onTap: () {
                        logOut();
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                      },
                    ),
                  ],
                ),
              ),
            ),

            if(loginController.userType == TextConstants.advisor)
              Container(
                height: height * 0.75,
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dashboard
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.home.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      //Own membership
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const SubscribeScreen() ));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AddToCart(),
                          //   ),
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.ownMembership.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Meeting list
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MeetingsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.meetings.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // manage order
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => const OrderHistory(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.manageOrders.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Wallet
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WalletDashboard(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.wallet.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Regulations
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegulationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.regulation.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Engagement Agreement
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EngagementAgreementScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.08,
                          child: customText.kText(
                            TextConstants.engagementAgreement.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // General Info
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GeneralInformation(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.generalInfo.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Advertising News
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdvertisingNews(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.advertiseAndNews.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Affiliate
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AffiliateMembers(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.manageAffiliate.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Logout
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.logout.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                        onTap: () {
                          logOut();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                        },
                      ),

                    ],
                  ),
                )
              ),

            if(loginController.userType == TextConstants.farmer)
              Container(
                height: height * 0.75,
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Dashboard
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(left: 20),
                      //     height: height * 0.05,
                      //     child: customText.kText(
                      //       TextConstants.home.toUpperCase(),
                      //       20,
                      //       FontWeight.w700,
                      //       ColorConstants.drawerTextColor,
                      //       TextAlign.start,
                      //     ),
                      //   ),
                      // ),

                      //Own membership
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(
                      //         builder: (context) => const SubscribeScreen() ));
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(left: 20),
                      //     height: height * 0.05,
                      //     child: customText.kText(
                      //       TextConstants.ownMembership.toUpperCase(),
                      //       20,
                      //       FontWeight.w700,
                      //       ColorConstants.drawerTextColor,
                      //       TextAlign.start,
                      //     ),
                      //   ),
                      // ),

                      // Meeting list
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MeetingsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.meetings.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Products
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ProductsListing()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.products.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Add to cart
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => const ViewCartScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.cartText.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // own order
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => const OrderHistory(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.ownOrders.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // manage order
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => const OrdersDashboardScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.manageOrders.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Chat list
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
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.chat.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Regulations
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegulationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.regulation.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Engagement Agreement
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EngagementAgreementScreen(),
                            ),
                          );
                        },
                        child: Container(
                          // color: Colors.white,
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.08,
                          child: customText.kText(
                            TextConstants.engagementAgreement.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // General Info
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GeneralInformation(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.generalInfo.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Advertising News
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdvertisingNews(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.advertiseAndNews.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // affiliate
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const AffiliateMembers(),
                      //       ),
                      //     );
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(left: 20),
                      //     height: height * 0.05,
                      //     child: customText.kText(
                      //       TextConstants.affiliate.toUpperCase(),
                      //       20,
                      //       FontWeight.w700,
                      //       ColorConstants.drawerTextColor,
                      //       TextAlign.start,
                      //     ),
                      //   ),
                      // ),

                      // referral link
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReferralScreen() ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.referralLink.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Wallet
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WalletDashboard(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.wallet.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // delivery distance
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryDistance() ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.deliveryDistance.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const QueriesMembers() ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.queries.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Address
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewAddress() ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.simpleAddress.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Logout
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.logout.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                        onTap: () {
                          logOut();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                        },
                      ),

                    ],
                  ),
                ),
              ),

            if(loginController.userType == TextConstants.student)
              Container(
                height: height * 0.75,
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Dashboard
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.home.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      //Own membership
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const SubscribeScreen() ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.ownMembership.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Wallet
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WalletDashboard(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.wallet.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Meeting list
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MeetingsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.meetings.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Chat list
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
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.chat.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Regulations
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegulationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.regulation.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Engagement Agreement
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EngagementAgreementScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.08,
                          child: customText.kText(
                            TextConstants.engagementAgreement.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // General Info
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GeneralInformation(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.generalInfo.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Advertising News
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdvertisingNews(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.advertiseAndNews.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Affiliate
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AffiliateMembers(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.manageAffiliate.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Logout
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.logout.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                        onTap: () {
                          logOut();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                        },
                      ),
                    ],
                  ),
                ),
              ),

            if(loginController.userType == TextConstants.user)
              Container(
                height: height * 0.75,
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dashboard
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.home.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Products
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Add to cart
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewCartScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.cartText.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Meeting list
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MeetingsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.meetings.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Regulations
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegulationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.regulation.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Engagement Agreement
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EngagementAgreementScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.08,
                          child: customText.kText(
                            TextConstants.engagementAgreement.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // General Info
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GeneralInformation(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.generalInfo.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Advertising News
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdvertisingNews(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.advertiseAndNews.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      //Own membership
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const SubscribeScreen() ));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const AddToCart(),
                          //   ),
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.ownMembership.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Wallet
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WalletDashboard(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.wallet.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Affiliate
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AffiliateMembers(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.manageAffiliate.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                      ),

                      // Logout
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: height * 0.05,
                          child: customText.kText(
                            TextConstants.logout.toUpperCase(),
                            20,
                            FontWeight.w700,
                            ColorConstants.kSecondary,
                            TextAlign.start,
                          ),
                        ),
                        onTap: () {
                          logOut();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                        },
                      ),

                    ],
                  ),
                ),
              )

          ],
        )
      : ListView(
        children: [

          // App Title
          DrawerHeader(
            child: customText.kHeadingText(TextConstants.appTitle, 45, FontWeight.w800, Colors.white, TextAlign.center),
          ),

          // Products
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),

          // Services
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicesViewScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.services.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),

          // Regulation
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegulationScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.regulation.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),

          // Engage Agreement
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EngagementAgreementScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.08,
              child: customText.kText(
                TextConstants.engagementAgreement.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),

          // General Info
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneralInformation(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.generalInfo.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),

          // Advertise News
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvertiseNews(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.advertiseAndNews.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),

          // Login Screen
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: height * 0.05,
              child: customText.kText(
                TextConstants.login.toUpperCase(),
                20,
                FontWeight.w700,
                ColorConstants.kSecondary,
                TextAlign.start,
              ),
            ),
          ),


        ],
      )
    );
  }
}





// loginController.userType == TextConstants.superAdmin
// ? TextConstants.superAdmin
// : loginController.userType == TextConstants.advisor
//   ? TextConstants.advisor
//   : loginController.userType == TextConstants.farmer
//     ? TextConstants.farmer
//     : loginController.userType == TextConstants.student
//       ? TextConstants.student
//       : TextConstants.user,

// Referral Link
// GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ReferralScreen(),
//       ),
//     );
//   },
//   child: Container(
//     margin: const EdgeInsets.only(left: 20),
//     height: height * 0.05,
//     child: customText.kText(
//       TextConstants.referralLink.toUpperCase(),
//       20,
//       FontWeight.w700,
//       ColorConstants.drawerTextColor,
//       TextAlign.start,
//     ),
//   ),
// ),

// Add Address
// GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const NewAddress(),
//       ),
//     );
//   },
//   child: Container(
//     margin: const EdgeInsets.only(left: 20),
//     height: height * 0.05,
//     child: customText.kText(
//       TextConstants.addAddress.toUpperCase(),
//       20,
//       FontWeight.w700,
//       ColorConstants.drawerTextColor,
//       TextAlign.start,
//     ),
//   ),
// ),
