import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsReviews extends StatefulWidget {
  final Map<String, dynamic>? orderDetails;
  const RatingsReviews({super.key, this.orderDetails});

  @override
  State<RatingsReviews> createState() => _RatingsReviewsState();
}

class _RatingsReviewsState extends State<RatingsReviews> {

  final customText = CustomText();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
      body: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Align(
              alignment: Alignment.topLeft,
              child: CustomTitle(title: TextConstants.ratingReview,),
            ),

            Expanded(
              child: Container(
                // height: height * 0.7,
                margin: EdgeInsets.only(bottom: height * 0.02),
                // color: Colors.yellow.shade200,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.20,
                        width: width * 0.40,
                        margin: EdgeInsets.only(top: height * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade200,
                          borderRadius: BorderRadius.circular(width * 0.03),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black45,
                            ),
                            BoxShadow(
                              offset: Offset(0, -2),
                              blurRadius: 4,
                              color: Colors.black45,
                            ),

                          ]
                        ),
                      ),

                      SizedBox(height: height *   0.02),
                      customText.kText("Anamika", 25, FontWeight.w700, ColorConstants.kPrimary, TextAlign.center),

                      SizedBox(height: height *   0.02),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // print(rating);
                        },
                      ),

                      SizedBox(height: height *   0.02),
                      SizedBox(
                        child: TextFormField(
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          // controller: longDesController,
                          // validator: validator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.multiline,
                          cursorColor: ColorConstants.kPrimary,
                          style: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: TextConstants.longDes,
                            hintStyle: customText.kTextStyle(18, FontWeight.w500, ColorConstants.kTextGrey),
                            contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: ColorConstants.kPrimary),
                              borderRadius: BorderRadius.circular(width * 0.02),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: ColorConstants.kPrimary),
                              borderRadius: BorderRadius.circular(width * 0.02),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: ColorConstants.kPrimary),
                              borderRadius: BorderRadius.circular(width * 0.02),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.03),
                      CustomButton(
                        buttonText: TextConstants.submit,
                        onpress: () {},
                      )

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
