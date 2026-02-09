import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_dropdown_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class ShopProfileGiveReviewScreen extends StatefulWidget {
  String profileId;
  ShopProfileGiveReviewScreen({super.key, required this.profileId});

  @override
  State<ShopProfileGiveReviewScreen> createState() =>
      _ShopProfileGiveReviewScreenState();
}

class _ShopProfileGiveReviewScreenState
    extends State<ShopProfileGiveReviewScreen> {
  double value = 0.0;
  String? selectTitle;

  final reviewCnt = TextEditingController();
  @override
  void initState() {
    getCategoriesRxObj.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    reviewCnt.dispose();
    super.dispose();
  }

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack,
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.c282828,
                      ),
                      child: const Center(child: Icon(Icons.close_rounded)),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              Text('How was your experience?',
                  style: TextFontStyle.headline18w600CFFFFFFPoppins),
              UIHelper.verticalSpaceSmall,
              Text('Share your experience for the bar',
                  style: TextFontStyle.headline16w400CFFFFFFPoppins
                      .copyWith(color: AppColors.c999999)),
              UIHelper.verticalSpace(32.h),
              RatingStars(
                axis: Axis.horizontal,
                starCount: 5,
                starSize: 35.sp,
                maxValue: 5,
                starSpacing: 10,
                value: value,
                onValueChanged: (v) {
                  //
                  setState(() {
                    value = v;
                  });
                },
                maxValueVisibility: true,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffB8C3C4),
                starColor: AppColors.cFE5401,
                angle: 0,
              ),
              UIHelper.verticalSpace(32.h),
              Text('Help others by sharing your Comment',
                  style: TextFontStyle.headline16w400CFFFFFFPoppins.copyWith(
                    color: AppColors.c999999,
                  )),
              UIHelper.verticalSpaceMedium,
              StreamBuilder(
                stream: getCategoriesRxObj.getCategory,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  var model = snapshot.data?.data;

                  if (model == null || model.isEmpty) {
                    return const Text("No categories available");
                  }

                  selectTitle ??=
                      model.isNotEmpty ? model.first.id.toString() : null;

                  List<String> categoryNames = model
                      .map<String>((category) => category.title ?? '')
                      .toList();

                  return CustomDropdownButton(
                    selectedValue: selectTitle,
                    onChanged: (value) {
                      setState(() {
                        selectTitle = model
                            .firstWhere((category) => category.title == value)
                            .id
                            .toString();
                        log("select value this is data:$selectTitle");
                      });
                    },
                    iconColor: AppColors.cFFFFFF,
                    hintText: "Special Title*",
                    borderRadius: 8.r,
                    items: categoryNames,
                    isFilled: true,
                  );
                },
              ),
              UIHelper.verticalSpaceMedium,
              CustomFormField(
                hintText: "comment",
                maxline: 10,
                controller: reviewCnt,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: isKeyboardVisible(context)
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.all(16.sp),
              child: CustomButton(
                onTap: () {
                  writeReview(widget.profileId, selectTitle.toString(),
                      value.toString(), reviewCnt.text.trim().toString());
                },
                btnName: "Done",
                textStaus: false,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void writeReview(
      String ProfileId, String CategorId, String rating, String comment) async {
    await addReviewRx
        .addReview(
            id: ProfileId,
            categoryId: CategorId,
            rating: rating,
            comment: comment)
        .waitingForSucess()
        .then((sucess) {
      ToastUtil.showLongToast("Add Review....!!");
      NavigationService.navigateToReplacement(Routes.userNavigationScreen);
    });
  }
}
