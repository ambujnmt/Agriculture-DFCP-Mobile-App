import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class AdvertiseNews extends StatefulWidget {
  const AdvertiseNews({super.key});

  @override
  State<AdvertiseNews> createState() => _AdvertiseNewsState();
}

class _AdvertiseNewsState extends State<AdvertiseNews> {

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/regulation_back.png',
              fit: BoxFit.cover,
            ),
          ),

          // Top Header with Navigation
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorConstants.kPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 25,
                        child: Image.asset('assets/images/send_image1.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 80),
                customText.kHeadingText(
                  TextConstants.appTitle,
                  45,
                  FontWeight.w800,
                  ColorConstants.kPrimary,
                  TextAlign.center,
                ),
              ],
            ),
          ),

          // Scrollable Content
          Positioned(
            top: 120,
            left: 15,
            right: 15,
            bottom: 0, // Ensure it stretches to the bottom
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const CustomTitle(title: TextConstants.advertiseAndNews,),

                  // Regulation Image
                  Container(
                    height: 140,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.kPrimary, width: 2.5),
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://s3-alpha-sig.figma.com/img/e141/2441/4319fc64fc810d1b9fe95ba3c6d15f55?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=e3riDCgnFmfoYepAU134OeiVFngX-llBvGhilzVkuf1kc0YX~U~mMq6kLTXalSx8cM9sxOwa5-Qg~zoRVDQ7cPvv2LwyMCUd01xqU6hwAFai0JzspH1rLbsjWOC6s0QeAmkOlVEkyQDzgVKj5GkdiiZU3LFgQCqxk3xwiaNnr08GXpMxI0wmEGjWE28f-Z0Q3LpUMVK6~M-XVwe3aqyr1hu~flKz-jheXHPU78DYJ6BuHips0Usaum0SKAj8NZOYp4n~JEGM33WQ2FucnTVGq6O3i8ZsjTGyTtRbf9PMM1jAA070zyLoLjs6IX0L1bR9ip9jLL2y-wvjdf0crE4W5Q__")
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Regulation Text
                  customText.kText(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      22,
                      FontWeight.w400,
                      Colors.black,
                      TextAlign.start,
                      TextOverflow.visible,
                      2000
                  ),

                  const SizedBox(height: 10),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
