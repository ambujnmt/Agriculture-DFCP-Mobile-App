import 'dart:developer';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/meetings/all_usersListing.dart';
import 'package:dfcp/views/products/products_view_screen.dart';
import 'package:flutter/material.dart';

class MarketProfileHome extends StatefulWidget {
  const MarketProfileHome({super.key});

  @override
  State<MarketProfileHome> createState() => _MarketProfileHomeState();
}

class _MarketProfileHomeState extends State<MarketProfileHome> {

  dynamic size;
  bool isApiCalling = false;
  List dataList = [];
  List<String> imageList = [];
  final customText = CustomText(), api = API(), helper = Helper();

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  getProductList() async {

    setState(() {
      isApiCalling = true;
    });

    final response = await api.getProductsList();

    setState(() {
      isApiCalling = false;
    });

    if(response["status"] == 1) {

      List tempList = response["result"];
      for(int i = 0; i < 4; i++) {
        setState(() {
          dataList.add(tempList[i]);
          imageList.add(tempList[i]["image_1"]);
        });
      }

    } else {
      helper.errorDialog(response["message"]);
    }

    log("image list in product listing :- $imageList, $dataList");
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: ColorConstants.kPrimary, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                height: 25,
                child: Image.asset('assets/images/send_image1.png'),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: customText.kHeadingText(TextConstants.appTitle,
            45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          // color: Colors.yellow.shade200,
          // margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.only(top: 3),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: const CustomTitle(title: TextConstants.intro,),
                ),

                Container(
                  height: size.height * 0.25,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.kSecondary,
                        Color(0xffffdb64)
                      ]
                    )
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [

                      Positioned(
                        top: -20,
                        right: 15,
                        child: Container(
                          height: 35,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            color: ColorConstants.kPrimary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black38,
                                blurRadius: 4
                              ),
                              BoxShadow(
                                offset: Offset(0, -2),
                                color: Colors.black38,
                                blurRadius: 4
                              ),
                            ]
                          ),
                          child: Center(
                            child: customText.kText(TextConstants.products, 20, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          for(int i = 0; i < dataList.length; i++)

                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [

                                Container(
                                  height: 90,
                                  // width: 80,
                                  margin: const EdgeInsets.only(top: 25),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(imageList[i]),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),

                                const SizedBox(height: 10,),

                                customText.kText(dataList[i]["product_name"], 14, FontWeight.w400, Colors.black, TextAlign.center),

                                const SizedBox(height: 5,),

                                customText.kText("${TextConstants.rupeeSymbol} ${dataList[i]["selling_price"]}", 14, FontWeight.w400, Colors.black, TextAlign.center),

                              ],
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  // height: size.height * 0.25,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorConstants.kPrimary,
                    borderRadius: BorderRadius.circular(size.width * 0.06)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      customText.kText(TextConstants.marketPlace, 22, FontWeight.w700, ColorConstants.kSecondary, TextAlign.start),

                      customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                        14, FontWeight.w500, Colors.white, TextAlign.start, TextOverflow.ellipsis, 7),

                      GestureDetector(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 35,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                color: ColorConstants.kSecondary,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 2),
                                      color: Colors.black38,
                                      blurRadius: 4
                                  ),
                                  BoxShadow(
                                      offset: Offset(0, -2),
                                      color: Colors.black38,
                                      blurRadius: 4
                                  ),
                                ]
                            ),
                            child: Center(
                              child: customText.kText(TextConstants.goToMarket, 20, FontWeight.w700, ColorConstants.kPrimary, TextAlign.center),
                            ),
                          ),
                        ),
                        onTap: () {
                          log("go to market place tap ");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsViewScreen() ));
                        },
                      ),
                      
                    ],
                  ),
                ),

                Container(
                  // height: size.height * 0.25,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorConstants.kSecondary,
                    borderRadius: BorderRadius.circular(size.width * 0.06)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      customText.kText(TextConstants.existingProfile, 22, FontWeight.w700, ColorConstants.kPrimary, TextAlign.start),

                      customText.kText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          14, FontWeight.w500, Colors.black, TextAlign.start, TextOverflow.ellipsis, 7),

                      GestureDetector(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 35,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                color: ColorConstants.kPrimary,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 2),
                                      color: Colors.black38,
                                      blurRadius: 4
                                  ),
                                  BoxShadow(
                                      offset: Offset(0, -2),
                                      color: Colors.black38,
                                      blurRadius: 4
                                  ),
                                ]
                            ),
                            child: Center(
                              child: customText.kText(TextConstants.goToProfile, 20, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                            ),
                          ),
                        ),
                        onTap: () {
                          log("go to profiles");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllUsersListing() ));
                        },
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      )
    );
  }
}
