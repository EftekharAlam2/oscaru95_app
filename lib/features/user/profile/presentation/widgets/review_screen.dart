import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    var messageCnt = TextEditingController();
    double? rat;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            NavigationService.goBack;
          },
          child: const Icon(
            Icons.close,
            color: AppColors.cFFFFFF,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How was your experience?",
              style: TextFontStyle.headline28w600Poppins
                  .copyWith(color: AppColors.cFFFFFF, fontSize: 18.sp),
            ),
            UIHelper.verticalSpace(4.h),
            Text(
              "Tell us about your experience with the app.",
              style: TextFontStyle.headline10w400c6B6B6BPoppins
                  .copyWith(color: AppColors.c6B6B6B, fontSize: 14.sp),
            ),
            UIHelper.verticalSpace(32.h),
            RatingBar.builder(
              initialRating: 4.1,
              minRating: 1,
              itemSize: 40,
              itemCount: 5,
              allowHalfRating: true,
              onRatingUpdate: (rating) {
                rat = rating;
              },
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: AppColors.cFE5401,
              ),
            ),
            UIHelper.verticalSpace(32.h),
            Text("Your experience can guide others—share it",
                style: TextFontStyle.headline10w400c6B6B6BPoppins
                    .copyWith(color: AppColors.c6B6B6B, fontSize: 14.sp)),
            UIHelper.verticalSpace(4.h),
            Container(
                height: 200.h,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: messageCnt,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  style: TextFontStyle.headline10w400c6B6B6BPoppins,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write Comment",
                      hintStyle: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.c6B6B6B, fontSize: 14.sp)),
                )),
            const Spacer(),
            CustomButton(
              onTap: () {
                // int ratingData = rat!.toInt();
                log("this is rating data :${rat?.toInt()}");
                comment(rat?.toInt()??1, messageCnt.text.trim().toString());
              },
              btnName: "Submit",
              textStaus: false,
            )
          ],
        ),
      ),
    );
  }

  void comment(int rating, String comment) async {
    await feedBackRxObj
        .feedBack(rating: rating, comment: comment)
        .waitingForSucess()
        .then((success) {
      NavigationService.navigateToReplacement(Routes.userNavigationScreen);
    });
  }
}
