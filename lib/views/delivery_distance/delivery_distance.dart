import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';

class DeliveryDistance extends StatefulWidget {
  const DeliveryDistance({super.key});

  @override
  State<DeliveryDistance> createState() => _DeliveryDistanceState();
}

class _DeliveryDistanceState extends State<DeliveryDistance> {

  final customText = CustomText();
  double _currentSliderValue = 20;

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

              const CustomTitle(title: TextConstants.deliveryDistance),

              Expanded(
                child: Container(
                  // color: Colors.white,
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      customText.kText(TextConstants.distanceRange, 20, FontWeight.w400, ColorConstants.kSecondary, TextAlign.start),

                      SizedBox(height: height * 0.02),

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            left: (_currentSliderValue / 100) * (MediaQuery.of(context).size.width - 100),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConstants.kSecondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${_currentSliderValue.round().toString()} km",
                                style: const TextStyle(color: ColorConstants.kPrimary, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // The Slider
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Slider(
                              value: _currentSliderValue,
                              min: 0,
                              max: 100,
                              // divisions: 10,
                              activeColor: ColorConstants.kPrimary,
                              inactiveColor: ColorConstants.kSecondary,
                              onChanged: (value) {
                                setState(() {
                                  _currentSliderValue = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),

                      customText.kText(TextConstants.distanceToLocation, 20, FontWeight.w400, ColorConstants.kPrimary, TextAlign.start),

                      SizedBox(height: height * 0.02),

                      Wrap(
                        direction: Axis.horizontal,
                        children: [

                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: width * 0.03, bottom: height * 0.02),
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.003),
                              decoration: BoxDecoration(
                                color: ColorConstants.kSecondary,
                                border: Border.all(color: ColorConstants.kPrimary),
                                borderRadius: BorderRadius.circular(width * 0.06),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0,1),
                                    blurRadius: 4,
                                    color: Colors.black26
                                  )
                                ]
                              ),
                              child: customText.kText("Less then 5 Km", 16, FontWeight.w400, ColorConstants.kPrimary, TextAlign.center),
                            ),
                            onTap: () {
                              setState(() {
                                _currentSliderValue = 5;
                              });
                            },
                          ),

                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: width * 0.03, bottom: height * 0.02),
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.003),
                              decoration: BoxDecoration(
                                  color: ColorConstants.kSecondary,
                                  border: Border.all(color: ColorConstants.kPrimary),
                                  borderRadius: BorderRadius.circular(width * 0.06),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0,1),
                                        blurRadius: 4,
                                        color: Colors.black26
                                    )
                                  ]
                              ),
                              child: customText.kText("Less then 8 Km", 16, FontWeight.w400, ColorConstants.kPrimary, TextAlign.center),
                            ),
                            onTap: () {
                              setState(() {
                                _currentSliderValue = 8;
                              });
                            },
                          ),

                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: width * 0.03, bottom: height * 0.02),
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.003),
                              decoration: BoxDecoration(
                                  color: ColorConstants.kSecondary,
                                  border: Border.all(color: ColorConstants.kPrimary),
                                  borderRadius: BorderRadius.circular(width * 0.06),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0,1),
                                        blurRadius: 4,
                                        color: Colors.black26
                                    )
                                  ]
                              ),
                              child: customText.kText("Less then 16 Km", 16, FontWeight.w400, ColorConstants.kPrimary, TextAlign.center),
                            ),
                            onTap: () {
                              setState(() {
                                _currentSliderValue = 16;
                              });
                            },
                          ),


                        ],
                      ),

                      const Spacer(),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          buttonText: TextConstants.submit,
                          onpress: () {},
                        ),
                      )

                    ],
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


// class CustomThumbShape extends SliderComponentShape {
//   final List<ui.Image> svg;
//   CustomThumbShape(this.svg);
//
//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return const Size(50, 50);
//   }
//
//   @override
//   void paint(PaintingContext context, Offset center,
//       {required Animation<double> activationAnimation,
//         required Animation<double> enableAnimation,
//         required bool isDiscrete,
//         required TextPainter labelPainter,
//         required RenderBox parentBox,
//         required SliderThemeData sliderTheme,
//         required TextDirection textDirection,
//         required double value,
//         required double textScaleFactor,
//         required Size sizeWithOverflow}) {
//     TextSpan span = TextSpan(style: TextStyle(color: Colors.white), text:value.toStringAsFixed(1));
//     TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
//     tp.layout();
//     context.canvas.drawImage(value == 0 ? svg.last : svg[2], ui.Offset(center.dx - 30, -66), Paint());
//     tp.paint(context.canvas, ui.Offset(center.dx - 12, -60));
//     context.canvas.drawImage(value == 0 ? svg.first : svg[1], ui.Offset(center.dx - 12, -27), Paint());
//   }
// }
