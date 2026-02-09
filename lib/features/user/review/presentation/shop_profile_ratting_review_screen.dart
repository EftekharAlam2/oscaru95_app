import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:rating_summary/rating_summary.dart';

class ShopProfileRattingReviewScreen extends StatefulWidget {
  String profileId;
  ShopProfileRattingReviewScreen({super.key, required this.profileId});

  @override
  State<ShopProfileRattingReviewScreen> createState() =>
      _ShopProfileRattingReviewScreenState();
}

class _ShopProfileRattingReviewScreenState
    extends State<ShopProfileRattingReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack,
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.c282828,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24.sp,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                  Text(
                    'Ratings & Reviews',
                    style: TextFontStyle.headline18w600CFFFFFFPoppins,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: AppColors.c282828,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 24.sp,
                      color: AppColors.scaffoldColor,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(25.h),
              Container(
                // color: Colors.amber,
                decoration: BoxDecoration(
                    color: AppColors.c282828,
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: RatingSummary(
                  showAverage: true,
                  labelCounterFiveStars: Row(
                    children: [
                      Text(
                        "5",
                        style: TextFontStyle.headline14w600CFFFFFFPoppins
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      SvgPicture.asset(
                        Assets.icons.star,
                        height: 18.h,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  labelCounterFourStars: Row(
                    children: [
                      Text(
                        "4",
                        style: TextFontStyle.headline14w600CFFFFFFPoppins
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      SvgPicture.asset(
                        Assets.icons.star,
                        height: 18.h,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  labelCounterThreeStars: Row(
                    children: [
                      Text(
                        "3",
                        style: TextFontStyle.headline14w600CFFFFFFPoppins
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      SvgPicture.asset(
                        Assets.icons.star,
                        height: 18.h,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  labelCounterTwoStars: Row(
                    children: [
                      Text(
                        "2",
                        style: TextFontStyle.headline14w600CFFFFFFPoppins
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      SvgPicture.asset(
                        Assets.icons.star,
                        height: 18.h,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  labelCounterOneStars: Row(
                    children: [
                      Text(
                        "1",
                        style: TextFontStyle.headline14w600CFFFFFFPoppins
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      SvgPicture.asset(
                        Assets.icons.star,
                        height: 18.h,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  color: AppColors.cFE5401,
                  starColor: AppColors.cFE5401,
                  averageStyle: TextFontStyle.headline48w700cFFFFFFPoppins
                      .copyWith(fontSize: 40.sp),
                  backgroundColor: AppColors.c282828,
                  label: "52 Reviews",
                  labelStyle: const TextStyle(color: AppColors.cFFFFFF),
                  counter: 13,
                  average: 3.846,
                  counterFiveStars: 5,
                  counterFourStars: 4,
                  counterThreeStars: 2,
                  counterTwoStars: 1,
                  counterOneStars: 1,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Text('Reviews',
                  style: TextFontStyle.headline18w700CFFFFFFPoppins),
              UIHelper.verticalSpace(16.h),
              ListView.separated(
                separatorBuilder: (context, index) =>
                    UIHelper.verticalSpaceSmall,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.sp),
                    decoration: ShapeDecoration(
                      color: AppColors.c282828,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                Assets.images.placeholderImage.path,
                                height: 50.w,
                                width: 50.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Courtney Henry',
                                    style: TextFontStyle
                                        .headline16w400CFFFFFFPoppins),
                                Row(
                                  children: [
                                    RatingStars(
                                      axis: Axis.horizontal,
                                      starCount: 5,
                                      starSize: 14.sp,
                                      maxValue: 5,
                                      starSpacing: 3,
                                      maxValueVisibility: true,
                                      valueLabelVisibility: false,
                                      animationDuration:
                                          const Duration(milliseconds: 1000),
                                      valueLabelPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 8),
                                      valueLabelMargin:
                                          const EdgeInsets.only(right: 8),
                                      starOffColor: const Color(0xffB8C3C4),
                                      starColor: AppColors.cFE5401,
                                      angle: 0,
                                    ),
                                    UIHelper.horizontalSpaceSmall,
                                    Text('2 mins ago',
                                        style: TextFontStyle
                                            .headline12w400c6B6B6BPoppins),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                              textAlign: TextAlign.start,
                              'Consequat velit qui adipisicing sunt do rependerit ad laborum tempor ullamco exercitation. Ullamco tempor adipisicing et voluptate duis sit esse aliqua',
                              style:
                                  TextFontStyle.headline12w400c6B6B6BPoppins),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              UIHelper.verticalSpaceMedium,
              GestureDetector(
                onTap: () {
                  NavigationService.navigateToWithArgs(
                      Routes.shopProfileGiveReviewScreen,
                      {"id": widget.profileId});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.01),
                      end: Alignment(-1, 0.01),
                      colors: [Color(0xFFFFC900), Color(0xFFFE5401)],
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: AppColors.scaffoldColor,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(16.sp),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Write a review',
                          style: TextFontStyle.headline14w600CFF7A01Poppins,
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
