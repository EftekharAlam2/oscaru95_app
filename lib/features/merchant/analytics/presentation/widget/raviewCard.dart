import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/rating_model_response.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class CustomReviewCard extends StatefulWidget {
  const CustomReviewCard({super.key});

  @override
  State<CustomReviewCard> createState() => _CustomReviewCardState();
}

class _CustomReviewCardState extends State<CustomReviewCard> {
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
            var topPerForming = model.data?.topPerformingReviews ?? [];
            return topPerForming.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: topPerForming
                        .length, // This can be dynamic depending on the number of reviews
                    itemBuilder: (context, index) {
                      var name = topPerForming[index].userName ?? "";
                      var time = topPerForming[index].createdAt ?? "";
                      var category = topPerForming[index].categoryName ?? "";
                      var image = topPerForming[index].userAvatar ?? "";
                      var comment = topPerForming[index].comment ?? "";
                      var rating = topPerForming[index].rating ?? "";
                      return ReviewCard(
                        profileImage: image,
                        reviewerName: name,
                        reviewTime: time,
                        reviewCategory: category,
                        reviewText: comment,
                        rating: rating.toString(),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Reviews is Not Found....!",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.cFFFFFF, fontSize: 16.sp),
                    ),
                  );
          }
          return const SizedBox.shrink();
        });
  }
}

class ReviewCard extends StatelessWidget {
  final String profileImage;
  final String reviewerName;
  final String reviewTime;
  final String reviewCategory;
  final String reviewText;
  final String rating;

  const ReviewCard({
    super.key,
    required this.profileImage,
    required this.reviewerName,
    required this.reviewTime,
    required this.reviewCategory,
    required this.reviewText,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    double ratingDoble = double.parse(rating);
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Card(
        color: const Color(0xFF3C3C3C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Profile Image
                  ClipOval(
                    child: Image.network(
                      profileImage, // Replace with your asset or network image
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Reviewer Name and Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reviewer Name
                      Text(
                        reviewerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: ratingDoble,
                            minRating: 1,
                            itemSize: 20,
                            itemCount: 5,
                            allowHalfRating: true,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: AppColors.cFE5401,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          Text(
                            reviewTime,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(8.h),
                    ],
                  ),
                  UIHelper.verticalSpace(8.h),

                  // Rating Section
                ],
              ),
              UIHelper.verticalSpace(10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: ShapeDecoration(
                  color: AppColors.c484848,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r)),
                ),
                child: Text(
                  reviewCategory,
                  style: TextFontStyle.headline12w600cBABABAPoppins
                      .copyWith(color: AppColors.cFFFFFF, fontSize: 10.w),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Text(
                reviewText,
                style: TextFontStyle.headline10w400c6B6B6BPoppins
                    .copyWith(color: AppColors.c6B6B6B, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
