import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductReview extends StatefulWidget {
  const ProductReview({super.key});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: customText.kHeadingText(TextConstants.appTitle, 45,
            FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
      ),
      body: SafeArea(
        child: Container(
          width: width,
          // color: Colors.yellow.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.ratingReview),

              Expanded(
                child: Container(
                  // color: Colors.blue.shade200,
                  margin: EdgeInsets.only(bottom: height * 0.01),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.07,
                          width: width,
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              GestureDetector(
                                child: SizedBox(
                                  height: height * 0.035,
                                  width: width,
                                  child: Row(
                                    children: [

                                      RatingBar.builder(
                                        itemSize: 20,
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                        },
                                      ),

                                      SizedBox(width: width * 0.07),

                                      customText.kText("4 out of 5", 20, FontWeight.w400, Colors.black, TextAlign.center),

                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductReview() ));
                                },
                              ),

                              customText.kText("1200 ${TextConstants.ratingReview}", 18, FontWeight.w100, Colors.black, TextAlign.center)

                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: height * 0.21,
                            width: width * 0.8,
                            margin: EdgeInsets.symmetric(vertical: height * 0.02),
                            padding: EdgeInsets.all(width * 0.02),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorConstants.lightGreyColor),
                              borderRadius: BorderRadius.circular(width * 0.02)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText.kText("5", 20, FontWeight.w600, Colors.black, TextAlign.start),

                                    const Icon(Icons.star, size: 20, color: Colors.amber,),

                                    Container(
                                      height: height * 0.01,
                                      width: width * 0.5,
                                      color: Colors.blue.shade200,
                                      child: LinearProgressIndicator(
                                        value: 400/500,
                                        color: ColorConstants.kPrimary,
                                        backgroundColor: ColorConstants.kGrey,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                      ),
                                    ),
                                    
                                    customText.kText("400", 16, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start)
                                    
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText.kText("4", 20, FontWeight.w600, Colors.black, TextAlign.start),

                                    const Icon(Icons.star, size: 20, color: Colors.amber,),

                                    Container(
                                      height: height * 0.01,
                                      width: width * 0.5,
                                      color: Colors.blue.shade200,
                                      child: LinearProgressIndicator(
                                        value: 450/500,
                                        color: ColorConstants.kPrimary,
                                        backgroundColor: ColorConstants.kGrey,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                      ),
                                    ),

                                    customText.kText("450", 16, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start)

                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText.kText("3", 20, FontWeight.w600, Colors.black, TextAlign.start),

                                    const Icon(Icons.star, size: 20, color: Colors.amber,),

                                    Container(
                                      height: height * 0.01,
                                      width: width * 0.5,
                                      color: Colors.blue.shade200,
                                      child: LinearProgressIndicator(
                                        value: 350/500,
                                        color: ColorConstants.kPrimary,
                                        backgroundColor: ColorConstants.kGrey,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                      ),
                                    ),

                                    customText.kText("350", 16, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start)

                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText.kText("2", 20, FontWeight.w600, Colors.black, TextAlign.start),

                                    const Icon(Icons.star, size: 20, color: Colors.amber,),

                                    Container(
                                      height: height * 0.01,
                                      width: width * 0.5,
                                      color: Colors.blue.shade200,
                                      child: LinearProgressIndicator(
                                        value: 200/500,
                                        color: ColorConstants.kPrimary,
                                        backgroundColor: ColorConstants.kGrey,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                      ),
                                    ),

                                    customText.kText("200", 16, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start)

                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText.kText("1", 20, FontWeight.w600, Colors.black, TextAlign.start),

                                    const Icon(Icons.star, size: 20, color: Colors.amber,),

                                    Container(
                                      height: height * 0.01,
                                      width: width * 0.5,
                                      color: Colors.blue.shade200,
                                      child: LinearProgressIndicator(
                                        value: 40/500,
                                        color: ColorConstants.kPrimary,
                                        backgroundColor: ColorConstants.kGrey,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                      ),
                                    ),

                                    customText.kText("40", 16, FontWeight.w400, ColorConstants.kTextGrey, TextAlign.start)

                                  ],
                                ),
                                
                              ],
                            ),
                          ),
                        ),

                        const Divider(color: ColorConstants.kTextGrey,),

                        SizedBox(height: height * 0.02,),

                        for(int i = 0; i < 4; i++)
                        Container(
                          width: width,
                          // color: Colors.blue.shade200,
                          margin: EdgeInsets.only(bottom: height * 0.02),
                          child: Column(
                            children: [

                              Row(
                                children: [

                                  Container(
                                    height: height * 0.09,
                                    width: width * 0.18,
                                    margin: EdgeInsets.only(right: width * 0.02),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade200,
                                      shape: BoxShape.circle,
                                      image: const DecorationImage(
                                        image: AssetImage("assets/images/girl_image.png")
                                      )
                                    ),
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText.kText("Poonam Singh", 20, FontWeight.w700, Colors.black, TextAlign.start),

                                      RatingBar.builder(
                                        itemSize: 20,
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                        },
                                      ),
                                    ],
                                  )


                                ],
                              ),

                              customText.kText(
                                "The vibrant red color, with a slightly uneven texture, indicates a well-ripened fruit that bursts with a sweet, balanced acidity on the palate.",
                                16, FontWeight.w400, Colors.black, TextAlign.start, TextOverflow.visible, 10)

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
