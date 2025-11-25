import 'package:dfcp/admin/products/add_product.dart';
import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/controllers/login_controller.dart';
import 'package:dfcp/custom_widget/custom_drawer.dart';
import 'package:dfcp/custom_widget/custom_progressIndicator.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/services/api_services.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/utils/helper.dart';
import 'package:dfcp/views/cart/view_cart.dart';
import 'package:dfcp/views/dashboard/farmer_dashboard.dart';
import 'package:dfcp/views/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'dart:developer';


class ProductsListing extends StatefulWidget {
  final String? comingFrom;
  const ProductsListing({super.key, this.comingFrom});

  @override
  State<ProductsListing> createState() => _ProductsListingState();
}

class _ProductsListingState extends State<ProductsListing> {

  final GlobalKey<ScaffoldState> key = GlobalKey();
  final customText = CustomText(), api = API(), helper = Helper();
  bool isApiCalling = false;
  List imageList = [], dataList = [];

  LoginController loginController = Get.put(LoginController());

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
      onWillPop: () {
        if(widget.comingFrom == "confirmOrder" || widget.comingFrom == "addToCart"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmerDashboard() ));
        } else if(widget.comingFrom == null) {
          Navigator.pop(context);
        }
        return Future<bool>.value(true);
      },
      child: Scaffold(
        key: key,
        drawer: const CustomDrawer(),
        appBar: loginController.isUserLoggedIn()
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
              if(widget.comingFrom == "confirmOrder" || widget.comingFrom == "addToCart"){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmerDashboard() ));
              } else if(widget.comingFrom == null) {
                Navigator.pop(context);
              }
            },
          ),
          title: customText.kAppTitle(),
          actions: [
            // GestureDetector(
            //   child: Icon(Icons.shopping_cart, ),
            // )
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.015, right: width * 0.02),
                child: const Icon(Icons.shopping_cart, size: 30, color: ColorConstants.kPrimary,),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const ViewCartScreen() ));
              },
            )
          ],
        )
            : AppBar(
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset("assets/images/dashboard_icon.png"),
            ),
            onTap: () {
              key.currentState!.openDrawer();
            },
          ),
          title: customText.kAppTitle(),
        ),
        body: SizedBox(
          // margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle(title: TextConstants.products,),
                  ],
                ),
              ),

              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [

                    isApiCalling
                    ? Container(
                        margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02, top: height * 0.02),
                        padding: EdgeInsets.only(bottom: height * 0.03),
                        width: double.infinity,
                        child: const Center(
                          child: CustomProgressIndicator(),
                        ),
                      )
                    : imageList.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02, bottom: height * 0.05),
                          padding: EdgeInsets.only(bottom: height * 0.03),
                          width: double.infinity,
                          child: GridView.custom(
                            gridDelegate: SliverWovenGridDelegate.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 12,
                              pattern: const [
                                WovenGridTile(
                                  5 / 5.5,
                                ),
                                WovenGridTile(
                                  5 / 7,
                                ),
                              ],
                            ),
                            childrenDelegate: SliverChildBuilderDelegate(
                              childCount: imageList.length,
                                  (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(productId: dataList[index]["product_id"]),
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.black38)
                                    ]
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      '${imageList[index]}',
                                      fit: BoxFit.fill,
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
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02, top: height * 0.02),
                          padding: EdgeInsets.only(bottom: height * 0.03),
                          width: double.infinity,
                          child: Center(
                            child: customText.kText(TextConstants.noProductsYet, 24, FontWeight.w600, ColorConstants.kPrimary, TextAlign.center),
                          ),
                        ),

                    Container(
                      height: 55,
                      width: width,
                      decoration: BoxDecoration(
                          color: ColorConstants.kPrimary,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, -4),
                              blurRadius: 7.5,
                              color: Colors.black54
                            )
                          ]
                      ),

                    ),

                    Positioned(
                      bottom: 20,
                      child: GestureDetector(
                        child: Container(
                          height: 75,
                          width: width,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle,
                          ),
                          child: Image.asset('assets/images/add_image.png'),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct() ));
                        },
                      ),
                    ),
                  ],
                )
              ),

            ],
          ),
        ),
      ),
    );
  }

}
