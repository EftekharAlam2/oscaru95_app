// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/rating_model_response.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/top_deals_model.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/widget/custom_card.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/widget/raviewCard.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    ratingRxObj.getRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        title: Text(
          "Analytics",
          style: TextFontStyle.headline24w400cFFFFFFPoppins,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.sp),
        child: StreamBuilder(
            stream: ratingRxObj.getBusniessProfileStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                RatingSummaryModel model = snapshot.data;
                var totalMetrics = model.data?.totalMetrics;
                var totalClick = totalMetrics?.totalClicks;
                var totalView = totalMetrics?.totalViews;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RevenueCard(
                            subtitle: "from last week",
                            title: "Total Clicks",
                            amount: "\$ ${totalClick.toString()}",
                            percentage: "+1.25%"),
                        const SizedBox(width: 16),
                        RevenueCard(
                            subtitle: "from last week",
                            title: "Total Clicksr",
                            amount: totalView.toString(),
                            percentage: "+1.25%"),
                      ],
                    ),
                    UIHelper.verticalSpace(10.h),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RevenueCard(
                            subtitle: "from last week",
                            title: "Deals\n Redeemed",
                            amount: "\$100k",
                            percentage: "+1.25%"),
                        SizedBox(width: 16),
                        RevenueCard(
                            subtitle: "from last week",
                            title: "TAverage\n Rating",
                            amount: "590",
                            percentage: "+1.25%"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const MonthlySalesChart(),
                    UIHelper.verticalSpace(31.h),
                    const Text(
                      "Ratings & Reviews",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const RatingBarChart(),
                    const SizedBox(height: 20),
                    const CustomReviewCard()
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  Widget _buildCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextFontStyle.headline10w400c6B6B6BPoppins
                .copyWith(color: AppColors.cFFFFFF),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class RevenueCard extends StatelessWidget {
  final String title;
  final String amount;
  final String percentage;
  final String subtitle;

  const RevenueCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.percentage,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.c282828,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextFontStyle.headline10w400c6B6B6BPoppins
                      .copyWith(color: AppColors.cFFFFFF, fontSize: 12.sp),
                ),
                Text(
                  percentage,
                  style: TextFontStyle.headline10w400c6B6B6BPoppins.copyWith(
                      fontSize: 8.sp, color: AppColors.allPrimaryColor),
                ),
              ],
            ),

            /// Amount & Growth Percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(amount,
                    style: TextFontStyle.headline10w400c6B6B6BPoppins.copyWith(
                        color: AppColors.allPrimaryColor, fontSize: 20.sp)),
                Row(
                  children: [
                    Text(subtitle,
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(
                                color: AppColors.c999999, fontSize: 8.sp)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  /// Line Chart Widget
}

class MonthlySalesChart extends StatefulWidget {
  const MonthlySalesChart({super.key});

  @override
  State<MonthlySalesChart> createState() => _MonthlySalesChartState();
}

class _MonthlySalesChartState extends State<MonthlySalesChart> {
  MonthItem? selectedMonth = MonthItem(id: 1, name: "January");

  final List<MonthItem> months = [
    MonthItem(id: 1, name: 'January'),
    MonthItem(id: 2, name: 'February'),
    MonthItem(id: 3, name: 'March'),
    MonthItem(id: 4, name: 'April'),
    MonthItem(id: 5, name: 'May'),
    MonthItem(id: 6, name: 'June'),
    MonthItem(id: 7, name: 'July'),
    MonthItem(id: 8, name: 'August'),
    MonthItem(id: 9, name: 'September'),
    MonthItem(id: 10, name: 'October'),
    MonthItem(id: 11, name: 'November'),
    MonthItem(id: 12, name: 'December'),
  ];

  @override
  void initState() {
    super.initState();
    if (selectedMonth != null) {
      anlayticsRx.getTopDeals(selectedMonth!.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: anlayticsRx.getBusniessProfileStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          TopDealsModel model = snapshot.data;
          var data = model.data;

          return data!.isNotEmpty
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.c282828,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HEADER - Title + Dropdown
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top-Performing Deals",
                            style: TextFontStyle.headline10w400c6B6B6BPoppins
                                .copyWith(
                                    color: AppColors.cFFFFFF, fontSize: 16.sp),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.c282828,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<MonthItem>(
                                value: selectedMonth,
                                dropdownColor: AppColors.c282828,
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                items: months.map((MonthItem month) {
                                  return DropdownMenuItem<MonthItem>(
                                    value: month,
                                    child: Text(
                                      month.name,
                                      style: TextFontStyle
                                          .headline10w400c6B6B6BPoppins
                                          .copyWith(color: AppColors.cFFFFFF),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (MonthItem? newValue) {
                                  if (newValue != null &&
                                      newValue != selectedMonth) {
                                    setState(() {
                                      selectedMonth = newValue;
                                    });
                                    // Fetch deals for the new month
                                    anlayticsRx.getTopDeals(
                                        selectedMonth!.id.toString());
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // BAR CHART
                      SizedBox(
                        height: 250,
                        child: BarChart(
                          BarChartData(
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              horizontalInterval: 20,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: Colors.grey.shade300,
                                strokeWidth: 1,
                              ),
                              drawVerticalLine: false,
                            ),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      "${value.toInt()}k",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    List<String> labels = [
                                      "Happy Hour  ",
                                      "Happy Hour",
                                      "Special Offer",
                                      "Special Event",
                                    ];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0.w, left: 10.w),
                                      child: Text(labels[value.toInt()],
                                          style: TextFontStyle
                                              .headline10w400c6B6B6BPoppins
                                              .copyWith(
                                                  color: AppColors.c999999,
                                                  fontSize: 8.sp)),
                                    );
                                  },
                                  reservedSize: 30,
                                ),
                              ),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            barGroups: _getBarGroups(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.c282828,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<MonthItem>(
                        value: selectedMonth,
                        dropdownColor: AppColors.c282828,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        items: months.map((MonthItem month) {
                          return DropdownMenuItem<MonthItem>(
                            value: month,
                            child: Text(
                              month.name,
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(color: AppColors.cFFFFFF),
                            ),
                          );
                        }).toList(),
                        onChanged: (MonthItem? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedMonth = newValue;
                            });
                            print('Selected Month ID: ${selectedMonth!.id}');
                          }
                        },
                      ),
                    ),
                  ),
                );
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// DATA FOR BARS
  List<BarChartGroupData> _getBarGroups() {
    List<double> salesData = [20, 50, 75, 100]; // Sales values in 'k'
    return salesData.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            width: 30, // Increased bar width
            borderRadius: BorderRadius.circular(6),
            color: AppColors.cFE5401, // Single color for bars
          ),
        ],
      );
    }).toList();
  }
}

class MonthItem {
  final int id;
  final String name;

  MonthItem({required this.id, required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MonthItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
