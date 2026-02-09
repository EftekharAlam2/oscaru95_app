import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/common_widget/title.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/widget/custom_togle_butotn.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key});

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  bool isSelected = false;
  TimeOfDay fromTime = const TimeOfDay(hour: 12, minute: 0); // Default time
  TimeOfDay toTime = const TimeOfDay(hour: 13, minute: 0);
  DateTime selectedDate = DateTime.now(); // Default time

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFromTime ? fromTime : toTime,
    );

    if (picked != null) {
      setState(() {
        if (isFromTime) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
      });
    }
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date); // Example: 03/18/2025
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OfferProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 31.w),
            child: Text(
              "Skip",
              style: TextFontStyle.headline10w400c6B6B6BPoppins
                  .copyWith(color: AppColors.allPrimaryColor, fontSize: 18.sp),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TitleWidget(
                title:
                    "Do you want to add a Seasonal\n           Offer or Special Event?",
                titleFontSize: 18.sp,
                subtitle:
                    "        Upgrade to Premium to unlock Seasonal Offers & Special\n                                                         Events!",
                subTitleFontSize: 11.sp,
              ),
            ),
            UIHelper.verticalSpace(22.h),
            CustomToggleSwitch(),
            UIHelper.verticalSpace(20.h),
            provider.isSeasonalOffer
                ? _buildEvent(context)
                : _buildOffer(context),
            UIHelper.verticalSpace(48.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: CustomButton(
                onTap: () {
                  NavigationService.navigateToReplacement(Routes.premiumScreen);
                },
                btnName: "Upgrade Now",
                textStaus: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: ShapeDecoration(
        color: AppColors.c282828,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Column(
        children: [
          const CustomFormField(
            hintText: "Seasonal Offer Name*",
          ),
          UIHelper.verticalSpace(8.w),
          const Row(
            children: [
              Expanded(
                child: CustomFormField(
                  hintText: "Discount",
                ),
              ),
              SizedBox(width: 10), // Space between fields
              Expanded(
                child: CustomFormField(
                  hintText: "On Offer",
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.cFFFFFF, width: 0.5.w)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start*",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.c999999, fontSize: 16.sp),
                    ),
                    UIHelper.verticalSpace(8.h),
                    GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        // width: 100.w,
                        // height: 40.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.c282828,
                          border: Border.all(color: AppColors.c535353),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDate(selectedDate),
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.cFF6F6F6F,
                                      fontSize: 12.sp),
                            ),
                            UIHelper.horizontalSpace(4.w),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Container(
                        height: 40.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: AppColors.c282828,
                          border: Border.all(color: AppColors.c535353),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(fromTime),
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.cFF6F6F6F,
                                      fontSize: 16.sp),
                            ),
                            const Icon(Icons.access_time, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.horizontalSpace(4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "End*",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.c999999, fontSize: 16.sp),
                    ),
                    UIHelper.verticalSpace(8.h),
                    GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          // width: 100.w,
                          // height: 40.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.c282828,
                            border: Border.all(color: AppColors.c535353),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDate(selectedDate),
                                style: TextFontStyle
                                    .headline10w400c6B6B6BPoppins
                                    .copyWith(
                                        color: AppColors.cFF6F6F6F,
                                        fontSize: 12.sp),
                              ),
                              UIHelper.horizontalSpace(4.w),
                              Icon(
                                Icons.calendar_today,
                                size: 18.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )),
                    UIHelper.verticalSpace(8.h),
                    GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Container(
                        height: 40.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.c535353),
                          color: AppColors.c282828,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(toTime),
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.cFF6F6F6F,
                                      fontSize: 16.sp),
                            ),
                            const Icon(Icons.access_time, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(8.h),
          const Column(
            children: [
              CustomFormField(
                hintText: "Event Description",
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEvent(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: ShapeDecoration(
        color: AppColors.c282828,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Column(
        children: [
          const CustomFormField(
            hintText: "Event Name*",
          ),
          UIHelper.verticalSpace(8.w),
          GestureDetector(
            onTap: () => _selectDate(context, true),
            child: Container(
              width: double.infinity,
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.c282828,
                border: Border.all(color: AppColors.c535353),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDate(selectedDate),
                    style: TextFontStyle.headline10w400c6B6B6BPoppins
                        .copyWith(color: AppColors.cFF6F6F6F, fontSize: 12.sp),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.white),
                ],
              ),
            ),
          ),
          UIHelper.verticalSpace(8.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.cFFFFFF, width: 0.5.w)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start*",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.c999999, fontSize: 16.sp),
                    ),
                    UIHelper.verticalSpace(8.h),
                    UIHelper.verticalSpace(8.h),
                    GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Container(
                        height: 40.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: AppColors.c282828,
                          border: Border.all(color: AppColors.c535353),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(fromTime),
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.cFF6F6F6F,
                                      fontSize: 16.sp),
                            ),
                            const Icon(Icons.access_time, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "End*",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.c999999, fontSize: 16.sp),
                    ),
                    UIHelper.verticalSpace(8.h),
                    UIHelper.verticalSpace(8.h),
                    GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Container(
                        height: 40.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.c535353),
                          color: AppColors.c282828,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(toTime),
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.cFF6F6F6F,
                                      fontSize: 16.sp),
                            ),
                            const Icon(Icons.access_time, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(8.h),
          const Column(
            children: [
              CustomFormField(
                hintText: "Event Description",
              )
            ],
          )
        ],
      ),
    );
  }
}
