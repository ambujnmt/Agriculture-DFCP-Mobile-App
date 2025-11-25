import 'package:dfcp/admin/products/add_product.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/bottom_nav_controller.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_drawer.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/bottom_navigation/bottom_navigation.dart';
import 'package:dfcp/views/cart/view_cart.dart';
import 'package:dfcp/views/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class ProductsViewScreen extends StatefulWidget {
  const ProductsViewScreen({super.key});

  @override
  State<ProductsViewScreen> createState() => _ProductsViewScreenState();
}

class _ProductsViewScreenState extends State<ProductsViewScreen> {

  bool isApiCalling = false, fetchingCategories = false;
  List dataList = [], categoriesList = [],
    categoriesNames = [
      TextConstants.upcoming,
      TextConstants.existing
    ];
  List<String> imageList = [];
  int selectedIndex = -1;
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final customText = CustomText(), helper = Helper(), api = API(), box = GetStorage();
  LoginController loginController = Get.put(LoginController());
  TextEditingController searchController = TextEditingController();
  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  void initState() {
    super.initState();
    getCategories();
    getProductList();
  }

  getCategories() async {

    setState(() {
      fetchingCategories = true;
    });

    final response = await api.getCategories();

    setState(() {
      fetchingCategories = false;
    });

    if(response["status"] == 1) {
      categoriesList = response["result"];
      for(int i = 0; i < categoriesList.length; i++) {
        categoriesNames.add(categoriesList[i]["category_name"]);
      }
      setState(() {});
    }

    log("categories list in add product :- $categoriesList");
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

      dataList = response["result"];
      for(int i = 0; i < dataList.length; i++) {
        setState(() {
          imageList.add(dataList[i]["image_1"]);
        });
      }

    } else {
      helper.errorDialog(response["message"]);
    }

    log("image list in product listing :- $imageList");
  }



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
        key: key,
        drawer: const CustomDrawer(),

        // appBar:

        appBar: loginController.userId == null
          ? AppBar(
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
            )
          : AppBar(
              leading: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset("assets/images/dashboard_icon.png"),
                ),
                onTap: () {
                  bottomNavController.selectedIndex.value = 0;
                  bottomNavController.pageController.jumpToPage(0);
                },
              ),
              title: customText.kHeadingText(TextConstants.appTitle,
                  45, FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
              centerTitle: true,
              actions: [
                GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.shopping_cart_outlined, size: 30),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewCartScreen() ));
                  },
                )
              ],
            ),

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CustomTitle(title: TextConstants.products,),
              ),

              Container(
                height: 50,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: ColorConstants.kGrey,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: width * 0.75,
                      child: TextField(
                        controller: searchController,
                        style: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                        )
                      ),
                    ),

                    const SizedBox(width: 5,),

                    GestureDetector(
                      child: const Center(child: Icon(Icons.search, size: 30,)),
                      onTap: () {
                        log("search button pressed");
                      },
                    )

                  ],
                ),
              ),

              // const SizedBox(height: 10,),

             Container(
               height: 50,
               width: width,
               padding: const EdgeInsets.symmetric(horizontal: 10),
               // color: Colors.yellow.shade200,
               child: SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                              
                     // GestureDetector(
                     //   child: Container(
                     //     height: 30,
                     //     // width: width * 0.4,
                     //     padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                     //     margin: EdgeInsets.only(right: width * 0.02),
                     //     decoration: BoxDecoration(
                     //         color: ColorConstants.kSecondary,
                     //         borderRadius: BorderRadius.circular(width * 0.02),
                     //         boxShadow: const [
                     //           BoxShadow(
                     //               offset: Offset(0, 2),
                     //               color: Colors.black38,
                     //               blurRadius: 4
                     //           ),
                     //           BoxShadow(
                     //               offset: Offset(0, -2),
                     //               color: Colors.black38,
                     //               blurRadius: 4
                     //           ),
                     //         ]
                     //     ),
                     //     child: Center(
                     //       child: customText.kText(TextConstants.upcoming, 16, FontWeight.w700, ColorConstants.kPrimary, TextAlign.center),
                     //     ),
                     //   ),
                     //   onTap: () {
                     //     log("upcoming products");
                     //   },
                     // ),
                     //
                     // GestureDetector(
                     //   child: Container(
                     //     height: 30,
                     //     // width: width * 0.4,
                     //     padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                     //     margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                     //     decoration: BoxDecoration(
                     //         color: ColorConstants.kPrimary,
                     //         borderRadius: BorderRadius.circular(width * 0.02),
                     //         boxShadow: const [
                     //           BoxShadow(
                     //               offset: Offset(0, 2),
                     //               color: Colors.black38,
                     //               blurRadius: 4
                     //           ),
                     //           BoxShadow(
                     //               offset: Offset(0, -2),
                     //               color: Colors.black38,
                     //               blurRadius: 4
                     //           ),
                     //         ]
                     //     ),
                     //     child: Center(
                     //       child: customText.kText(TextConstants.existing, 16, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
                     //     ),
                     //   ),
                     //   onTap: () {
                     //     log("existing products");
                     //   },
                     // ),

                     for(int i = 0; i <categoriesList.length; i++)
                       GestureDetector(
                         child: Container(
                           height: 30,
                           // width: width * 0.4,
                           padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                           margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                           decoration: BoxDecoration(
                             color: selectedIndex == i ? ColorConstants.kSecondary : ColorConstants.kPrimary,
                             borderRadius: BorderRadius.circular(width * 0.02),
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
                             child: customText.kText(categoriesNames[i], 16, FontWeight.w700,
                               selectedIndex == i ? ColorConstants.kPrimary : ColorConstants.kSecondary,
                               TextAlign.center),
                           ),
                         ),
                         onTap: () {
                           // log("existing products");
                           setState(() {
                             selectedIndex = i;
                           });
                         },
                       ),
                              
                   ],
                 ),
               ),
             ),

              // Container(
              //   color: Colors.yellow,
              //   child: Row(
              //
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //
              //       GestureDetector(
              //         child: Align(
              //           alignment: Alignment.bottomRight,
              //           child: Container(
              //             height: 30,
              //             // width: width * 0.4,
              //              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              //             decoration: BoxDecoration(
              //                 color: ColorConstants.kSecondary,
              //                 borderRadius: BorderRadius.circular(width * 0.02),
              //                 boxShadow: const [
              //                   BoxShadow(
              //                     offset: Offset(0, 2),
              //                     color: Colors.black38,
              //                     blurRadius: 4
              //                   ),
              //                   BoxShadow(
              //                     offset: Offset(0, -2),
              //                     color: Colors.black38,
              //                     blurRadius: 4
              //                   ),
              //                 ]
              //             ),
              //             child: Center(
              //               child: customText.kText(TextConstants.upcoming, 16, FontWeight.w700, ColorConstants.kPrimary, TextAlign.center),
              //             ),
              //           ),
              //         ),
              //         onTap: () {
              //           log("upcoming products");
              //         },
              //       ),
              //
              //       GestureDetector(
              //         child: Container(
              //           height: 45,
              //           width: width * 0.4,
              //           decoration: BoxDecoration(
              //               color: ColorConstants.kPrimary,
              //               borderRadius: BorderRadius.circular(width * 0.04),
              //               boxShadow: const [
              //                 BoxShadow(
              //                   offset: Offset(0, 2),
              //                   color: Colors.black38,
              //                   blurRadius: 4
              //                 ),
              //                 BoxShadow(
              //                   offset: Offset(0, -2),
              //                   color: Colors.black38,
              //                   blurRadius: 4
              //                 ),
              //               ]
              //           ),
              //           child: Center(
              //             child: customText.kText(TextConstants.existing, 20, FontWeight.w700, ColorConstants.kSecondary, TextAlign.center),
              //           ),
              //         ),
              //         onTap: () {
              //           log("existing products");
              //         },
              //       ),
              //
              //     ],
              //   ),
              // ),

              Expanded(
                child: isApiCalling
                  ? Container(
                      margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02, top: height * 0.01),
                      padding: EdgeInsets.only(bottom: height * 0.03),
                      width: double.infinity,
                      child: const Center(
                        child: CustomProgressIndicator(),
                      ),
                    )
                  : imageList.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03, top: height * 0.01),
                      // padding: EdgeInsets.only(bottom: height * 0.03),
                      width: double.infinity,
                      child: GridView.custom(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1/1.3
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: imageList.length,
                              (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(productId: dataList[index]["product_id"]),
                              ));
                            },
                            child: Column(
                              children: [

                                SizedBox(
                                  height: height * 0.2,
                                  width: width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageList[index],
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CustomProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                              : null,
                                          ),
                                        );
                                      },
                                    )
                                  ),
                                ),

                                const SizedBox(height: 3,),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Expanded(
                                      child: Container(
                                        child: customText.kText(dataList[index]["product_name"], 16, FontWeight.w500, Colors.black, TextAlign.start),
                                      ),
                                    ),

                                    Container(
                                      height: 20,
                                      width: width * 0.12,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.kPrimary,
                                        borderRadius: BorderRadius.circular(width * 0.01)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          customText.kText(dataList[index]["average_rating"].toString(), 12, FontWeight.w500, Colors.white, TextAlign.start),
                                          const Icon(Icons.star, color: ColorConstants.kSecondary, size: 14,)
                                        ],
                                      )
                                    )

                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                    margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02, top: height * 0.01),
                    padding: EdgeInsets.only(bottom: height * 0.03),
                    width: double.infinity,
                    child: Center(
                      child: customText.kText(TextConstants.noProductsYet, 24, FontWeight.w600, ColorConstants.kPrimary, TextAlign.center),
                    ),
                  ),
                )

            ],
          ),
        ),


        // floatingActionButton: box.read("userId") != null
        // ? GestureDetector(
        //   child: Container(
        //     height: 55,
        //     width: 55,
        //     padding: const EdgeInsets.all(5),
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       border: Border.all(color: ColorConstants.kSecondary, width: 3),
        //       shape: BoxShape.circle
        //     ),
        //     child: Center(
        //       child: Image.asset("assets/images/add_image.png"),
        //     ),
        //   ),
        //   onTap: () {
        //     log("box.read :- ${box.read("userId")}");
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct() ));
        //   },
        // )
        //     : const SizedBox(),

      ),
    );
  }

}


// Expanded(
//   child: Container(
//     margin: EdgeInsets.symmetric(vertical: height * 0.01),
//     child: GridView.custom(
//       gridDelegate: SliverWovenGridDelegate.count(
//         crossAxisCount: 2,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 12,
//         pattern: const [
//           WovenGridTile(
//             5 / 5.5,
//           ),
//           WovenGridTile(
//             5 / 7,
//           ),
//         ],
//       ),
//       childrenDelegate: SliverChildBuilderDelegate(
//         childCount: imageList.length,
//         (context, index) => GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ProductDetailScreen(),
//               ),
//             );
//           },
//           child: Container(
//             height: 300,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               borderRadius: BorderRadius.circular(12),
//               image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: AssetImage('${imageList[index]}'),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),

// appBar: AppBar(
//   leading: GestureDetector(
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: Image.asset("assets/images/dashboard_icon.png"),
//     ),
//     onTap: () {
//       key.currentState!.openDrawer();
//     },
//   ),
//   title: customText.kAppTitle(),
// ),