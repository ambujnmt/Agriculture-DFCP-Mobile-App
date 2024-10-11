import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_drawer.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:dfcp/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsViewScreen extends StatefulWidget {
  const ProductsViewScreen({super.key});

  @override
  State<ProductsViewScreen> createState() => _ProductsViewScreenState();
}

class _ProductsViewScreenState extends State<ProductsViewScreen> {
  final customText = CustomText();
  List<String> imageList = [
    'assets/images/veg_image.png',
    'assets/images/wheat.png',
    'assets/images/tamato.png',
    'assets/images/veg_image.png',
    'assets/images/wheat.png',
    'assets/images/tamato.png',
    'assets/images/veg_image.png',
    'assets/images/wheat.png',
    'assets/images/tamato.png',
    'assets/images/veg_image.png',
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset('assets/images/send_image.png'),
          ),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: Image.asset("assets/images/dfcp_image.png"),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              customText.kText(
                TextConstants.products,
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
                    borderRadius: BorderRadius.circular(12)),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: GridView.custom(
                    gridDelegate: SliverWovenGridDelegate.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      pattern: [
                        WovenGridTile(1),
                        const WovenGridTile(
                          5 / 7,
                          crossAxisRatio: 0.9,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      childCount: imageList.length,
                      (context, index) => Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('${imageList[index]}'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}