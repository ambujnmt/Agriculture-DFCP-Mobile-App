import 'package:dfcp/constants/color_constants.dart';
import 'package:dfcp/constants/text_constants.dart';
import 'package:dfcp/custom_widget/custom_title.dart';
import 'package:dfcp/custom_widget/divider_widget.dart';
import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {

  final customText = CustomText();
  late List<ChartData> todayData, weeklyData, monthlyData;

  @override
  void initState() {
    super.initState();
    todayData = [
      ChartData(1, 235, 240),
    ];

    weeklyData = [
      ChartData(1, 235, 240),
      ChartData(2, 242, 250),
      ChartData(3, 320, 280),
      ChartData(4, 360, 355),
      ChartData(5, 270, 245),
      ChartData(6, 270, 245),
      ChartData(7, 270, 245),
    ];

    monthlyData = [
      ChartData(1, 235, 240),
      ChartData(2, 242, 250),
      ChartData(3, 320, 280),
      ChartData(4, 360, 355),
      ChartData(5, 270, 245),
      ChartData(6, 270, 245),
      ChartData(7, 270, 245),
      ChartData(8, 270, 245),
      ChartData(9, 270, 245),
      ChartData(10, 270, 245),
      ChartData(11, 270, 245),
      ChartData(12, 270, 245),
    ];
  }

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
        title: customText.kHeadingText(TextConstants.appTitle, 45,
          FontWeight.w800, ColorConstants.kPrimary, TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CustomTitle(title: TextConstants.salesReport,),

              customText.kText("Today Sales", 20, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
          
              Container(
                height: height * 0.4,
                width: width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorConstants.lightGreyColor),
                  borderRadius: BorderRadius.circular(width * 0.05),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: Colors.black26
                    )
                  ]
                ),
                child:  SfCartesianChart(
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                    ),
                    primaryXAxis: const CategoryAxis(
                      autoScrollingDelta: 10,
                      autoScrollingMode: AutoScrollingMode.start,
                    ),
                    // primaryXAxis: DateTimeAxis(interval: 1),
                    primaryYAxis: const NumericAxis(),
                    series: <CartesianSeries<ChartData, double>>[
                      // Renders column chart
                      ColumnSeries<ChartData, double>(
                          color: ColorConstants.kPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.05),
                            topRight: Radius.circular(width * 0.05),
                          ),
                          spacing: 0.2,
                          dataSource: todayData,
                          xValueMapper: (ChartData data, int index) => data.x,
                          yValueMapper: (ChartData data, int index) => data.y
                      ),
                      ColumnSeries<ChartData, double>(
                          color: ColorConstants.kSecondary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.05),
                            topRight: Radius.circular(width * 0.05),
                          ),
                          spacing: 0.2,
                          dataSource: todayData,
                          xValueMapper: (ChartData data, int index) => data.x,
                          yValueMapper: (ChartData data, int index) => data.y1
                      ),
                    ]
                )
              ),
          
              customText.kText("Weekly Sales", 20, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),
          
              Container(
                // height: height * 0.2,
                  width: width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorConstants.lightGreyColor),
                      borderRadius: BorderRadius.circular(width * 0.05),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            color: Colors.black26
                        )
                      ]
                  ),
                  child:  SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                      ),
                      primaryXAxis: const CategoryAxis(
                        autoScrollingDelta: 10,
                        autoScrollingMode: AutoScrollingMode.start,
                      ),
                      // primaryXAxis: DateTimeAxis(interval: 1),
                      primaryYAxis: const NumericAxis(),
                      series: <CartesianSeries<ChartData, double>>[
                        // Renders column chart
                        ColumnSeries<ChartData, double>(
                            color: ColorConstants.kPrimary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.05),
                              topRight: Radius.circular(width * 0.05),
                            ),
                            spacing: 0.2,
                            dataSource: weeklyData,
                            xValueMapper: (ChartData data, int index) => data.x,
                            yValueMapper: (ChartData data, int index) => data.y
                        ),
                        ColumnSeries<ChartData, double>(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.05),
                              topRight: Radius.circular(width * 0.05),
                            ),
                            spacing: 0.2,
                            dataSource: weeklyData,
                            xValueMapper: (ChartData data, int index) => data.x,
                            yValueMapper: (ChartData data, int index) => data.y1
                        ),
                      ]
                  )
              ),

              customText.kText("Monthly Sales", 20, FontWeight.w600, ColorConstants.kSecondary, TextAlign.start),

              Container(
                // height: height * 0.2,
                  width: width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorConstants.lightGreyColor),
                      borderRadius: BorderRadius.circular(width * 0.05),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            color: Colors.black26
                        )
                      ]
                  ),
                  child:  SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                      ),
                      primaryXAxis: const CategoryAxis(
                        autoScrollingDelta: 10,
                        autoScrollingMode: AutoScrollingMode.start,
                      ),
                      // primaryXAxis: DateTimeAxis(interval: 1),
                      primaryYAxis: const NumericAxis(),
                      series: <CartesianSeries<ChartData, double>>[
                        // Renders column chart
                        ColumnSeries<ChartData, double>(
                            color: ColorConstants.kPrimary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.05),
                              topRight: Radius.circular(width * 0.05),
                            ),
                            spacing: 0.2,
                            dataSource: monthlyData,
                            xValueMapper: (ChartData data, int index) => data.x,
                            yValueMapper: (ChartData data, int index) => data.y
                        ),
                        ColumnSeries<ChartData, double>(
                            color: ColorConstants.kSecondary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.05),
                              topRight: Radius.circular(width * 0.05),
                            ),
                            spacing: 0.2,
                            dataSource: monthlyData,
                            xValueMapper: (ChartData data, int index) => data.x,
                            yValueMapper: (ChartData data, int index) => data.y1
                        ),
                      ]
                  )
              ),

            ],
          ),
        ),
      )
    );
  }
}

class ChartData{
  ChartData(this.x, this.y, this.y1);
  final double x;
  final double y;
  final double y1;
}
