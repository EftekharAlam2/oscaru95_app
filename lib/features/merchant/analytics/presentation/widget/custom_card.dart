import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/rating_model_response.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class RatingsScreen extends StatelessWidget {
  const RatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isbool = true;
    return Scaffold(
      backgroundColor: const Color(0xFF282828),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isbool
              ? Column(
                  children: [
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          initialRating: 4.0,
                          minRating: 1,
                          itemSize: 30,
                          itemCount: 5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '10.0',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Review count
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '52 Reviews',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '360 Views',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )
              // ignore: dead_code
              : const Text("dahnd")
          // Bar chart header
        ],
      ),
    );
  }
}

class RatingBarChart extends StatefulWidget {
  const RatingBarChart({super.key});

  @override
  State<RatingBarChart> createState() => _RatingBarChartState();
}

class _RatingBarChartState extends State<RatingBarChart> {
  @override
  void initState() {
    ratingRxObj.getRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ratingRxObj.getBusniessProfileStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            RatingSummaryModel model = snapshot.data;
            var ratingData = model.data?.ratingSummary;
            var totalReview = ratingData?.totalReviews;
            var average = ratingData?.averageRating;
            var allReview = ratingData?.reviewData;

            return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF282828),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150.h,
                                child: ListView.builder(
                                  itemCount: allReview!.length,
                                  itemBuilder: (context, index) {
                                    int star = allReview[index].star ?? 0;
                                    int count = allReview[index].count ?? 0;
                                    return _buildRatingRow(star, count, '');
                                  },
                                ),
                              )
                              // 1 star, 1 review
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              average.toString(),
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.cFFFFFF,
                                      fontSize: 40.sp),
                            ),
                            RatingBar.builder(
                              initialRating: 4.1,
                              minRating: 1,
                              itemSize: 20,
                              itemCount: 5,
                              allowHalfRating: true,
                              onRatingUpdate: (rating) {},
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: AppColors.cFE5401,
                              ),
                            ),
                            Text(
                              "$totalReview Reviews",
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.c969696,
                                      fontSize: 14.sp),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ));
          }
          return const SizedBox.shrink();
        });
  }

  Widget _buildRatingRow(int stars, int count, String rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                stars.toString(),
                style: TextFontStyle.headline10w400c6B6B6BPoppins
                    .copyWith(fontSize: 16.sp, color: AppColors.cFFFFFF),
              ),
              UIHelper.horizontalSpace(8.w),
              const Icon(
                Icons.star,
                color: AppColors.cFE5401,
                size: 20,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 12.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.transparent,
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: count / 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.r),
                        color: AppColors.cFE5401,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Analytics Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(label: '12,490', subLabel: 'Sales'),
                StatCard(label: '1,820', subLabel: 'Revenue'),
                StatCard(label: '1,520', subLabel: 'New Users'),
                StatCard(label: '4.6/5', subLabel: 'Rating'),
              ],
            ),
            const SizedBox(height: 20),

            // Bar Chart for Top Performing Deals
            // AspectRatio(
            //   aspectRatio: 1.5,
            //   child: BarChart(
            //     BarChartData(
            //       borderData: FlBorderData(show: false),
            //       barGroups: [
            //         BarChartGroupData(x: 0, barsSpace: 4, barRods: [
            //           BarChartRodData(toY: 10, color: Colors.orange)
            //         ]),
            //         BarChartGroupData(x: 1, barsSpace: 4, barRods: [
            //           BarChartRodData(toY: 8, color: Colors.orange)
            //         ]),
            //         BarChartGroupData(x: 2, barsSpace: 4, barRods: [
            //           BarChartRodData(toY: 6, color: Colors.orange)
            //         ]),
            //         BarChartGroupData(x: 3, barsSpace: 4, barRods: [
            //           BarChartRodData(toY: 4, color: Colors.orange)
            //         ]),
            //         BarChartGroupData(x: 4, barsSpace: 4, barRods: [
            //           BarChartRodData(toY: 5, color: Colors.orange)
            //         ]),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 20),

            const Text("Ratings & Reviews",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 4.0,
                  minRating: 1,
                  itemSize: 20,
                  itemCount: 5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(width: 10),
                const Text('4.0',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),

            // Review list
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const ReviewCard(
                    reviewerName: "Courtney Sunny",
                    reviewText: "Great work! This is exactly what I needed.",
                    rating: 4.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildContainer() {
  //   return Container(
  //       width: 364,
  //       padding: const EdgeInsets.all(16),
  //       decoration: ShapeDecoration(
  //         color: const Color(0xFF282828),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       ),
  //       child: Column(
  //         children: [SvgPicture.asset(Assets.icons.crown)],
  //       ));
  // }
}

class StatCard extends StatelessWidget {
  final String label;
  final String subLabel;

  const StatCard({super.key, required this.label, required this.subLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(subLabel,
            style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final String reviewText;
  final double rating;

  const ReviewCard(
      {super.key,
      required this.reviewerName,
      required this.reviewText,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(reviewerName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              itemSize: 16,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 5),
            Text(reviewText,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
