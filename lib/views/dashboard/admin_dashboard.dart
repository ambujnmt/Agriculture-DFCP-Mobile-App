import 'package:carousel_slider/carousel_slider.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_box.dart';
import 'package:dfcp/custom_widget/custom_drawer.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final customText = CustomText(), helper = Helper();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => helper.alertDialog(context, TextConstants.exitFromApp,
          TextConstants.exitAppDesc,
              () { ScaffoldMessenger.of(context).removeCurrentSnackBar();},
              () { SystemNavigator.pop();}
      ),
      child: Scaffold(
        key: _key,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset("assets/images/dashboard_icon.png"),
            ),
            onTap: () {
              _key.currentState!.openDrawer();
            },
          ),
          title: customText.kHeadingText(TextConstants.appTitle,
              45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const CustomTitle(title: TextConstants.dashboard,),

                  CarouselSlider(
                    items: [
                      Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/slider_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/slider_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/slider_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                  ),
                  Center(
                    child: DotsIndicator(
                      dotsCount: 3,
                      position: currentIndex,
                      decorator: const DotsDecorator(
                        color: ColorConstants.kSecondary, // Inactive color
                        activeColor: ColorConstants.kPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomBox(
                          textFontSize: 26,
                          countFontSize: 26,
                          textColor: ColorConstants.kSecondary,
                          height: height * 0.2,
                          count: "20",
                          text: TextConstants.meetings,
                          boxColor: ColorConstants.kPrimary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: CustomBox(
                          textFontSize: 26,
                          countFontSize: 26,
                          height: height * 0.2,
                          count: "50",
                          text: TextConstants.farmers,
                          boxColor: ColorConstants.kSecondary,
                          textColor: ColorConstants.kPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomBox(
                          textFontSize: 26,
                          countFontSize: 26,
                          textColor: ColorConstants.kPrimary,
                          height: height * 0.2,
                          count: "20",
                          text: TextConstants.orders,
                          boxColor: ColorConstants.kSecondary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: CustomBox(
                          textFontSize: 26,
                          countFontSize: 26,
                          height: height * 0.2,
                          count: "50",
                          text: TextConstants.products,
                          boxColor: ColorConstants.kPrimary,
                          textColor: ColorConstants.kSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomBox(
                    textFontSize: 26,
                    countFontSize: 26,
                    text: TextConstants.userQueries,
                    count: "80",
                    textColor: ColorConstants.kSecondary,
                    height: height * .170,
                    width: double.infinity,
                    boxColor: ColorConstants.kPrimary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
