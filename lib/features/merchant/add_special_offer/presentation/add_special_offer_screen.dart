import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class AddSpecialOfferScreen extends StatefulWidget {
  const AddSpecialOfferScreen({super.key});

  @override
  State<AddSpecialOfferScreen> createState() => _AddSpecialOfferScreenState();
}

class _AddSpecialOfferScreenState extends State<AddSpecialOfferScreen> {
  bool isSelected = false;
  TimeOfDay fromTime = const TimeOfDay(hour: 12, minute: 0); // Default time
  TimeOfDay toTime = const TimeOfDay(hour: 13, minute: 0);
  DateTime selectedDate = DateTime.now(); // Default time

  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

  // Future<void> _selectDate(BuildContext context, bool isStart) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  String formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: "Add Special Offers",
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.h),
              decoration: ShapeDecoration(
                color: AppColors.c282828,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      hintText: "Event Name*",
                      controller: _eventNameController,
                    ),
                    UIHelper.verticalSpace(8.w),
                    GestureDetector(
                      onTap: () async {
                        log("Click");
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (selectedDate != null) {
                          // Format and set the date in the controller
                          _eventDateController.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomFormField(
                          isRead: true,
                          hintText: "Event Date*",
                          controller: _eventDateController,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: SvgPicture.asset(Assets.icons.calendar),
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    CustomFormField(
                      hintText: "Price",
                      controller: _priceController,
                    ),
                    UIHelper.verticalSpace(8.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.cFFFFFF,
                          width: 0.5.w,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start*",
                                style: TextFontStyle
                                    .headline10w400c6B6B6BPoppins
                                    .copyWith(
                                  color: AppColors.c999999,
                                  fontSize: 16.sp,
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
                                    border:
                                        Border.all(color: AppColors.c535353),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatClockTime(fromTime),
                                        style: TextFontStyle
                                            .headline10w400c6B6B6BPoppins
                                            .copyWith(
                                                color: AppColors.cFF6F6F6F,
                                                fontSize: 16.sp),
                                      ),
                                      const Icon(Icons.access_time,
                                          color: Colors.white),
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
                                style: TextFontStyle
                                    .headline10w400c6B6B6BPoppins
                                    .copyWith(
                                        color: AppColors.c999999,
                                        fontSize: 16.sp),
                              ),
                              UIHelper.verticalSpace(8.h),
                              GestureDetector(
                                onTap: () => _selectTime(context, false),
                                child: Container(
                                  height: 40.h,
                                  width: 100.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.c535353),
                                    color: AppColors.c282828,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatClockTime(toTime),
                                        style: TextFontStyle
                                            .headline10w400c6B6B6BPoppins
                                            .copyWith(
                                                color: AppColors.cFF6F6F6F,
                                                fontSize: 16.sp),
                                      ),
                                      const Icon(Icons.access_time,
                                          color: Colors.white),
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
                    Column(
                      children: [
                        CustomFormField(
                          controller: _descController,
                          maxline: 3,
                          hintText: "Describe the offer",
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            UIHelper.verticalSpace(143.h),
            CustomButton(
              onTap: () {
                log("date ${formatClockTime(fromTime)}");
                if (_formKey.currentState!.validate()) {
                  // log("date $toTime");
                  addSpecialEventRx
                      .addSpecialEvent(
                        type: "special",
                        price: _priceController.text.trim(),
                        name: _eventNameController.text.trim(),
                        startDate: _eventDateController.text.trim(),
                        startTime: formatClockTime(fromTime),
                        endTime: formatClockTime(toTime),
                        description: _descController.text.trim(),
                      )
                      .waitingForSucess()
                      .then((success) async {
                    if (success) {
                      await getSpecialOfferRx.getSpecialOffer();
                      NavigationService.goBack;
                    }
                  });
                }
              },
              btnName: "Save",
              textStaus: false,
            )
          ],
        ),
      ),
    );
  }
}
