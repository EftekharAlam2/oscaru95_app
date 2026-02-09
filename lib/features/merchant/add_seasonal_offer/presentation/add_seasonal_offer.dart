import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_dropdown_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class AddSeasonalOfferSccren extends StatefulWidget {
  final bool status;
  const AddSeasonalOfferSccren({super.key, required this.status});

  @override
  State<AddSeasonalOfferSccren> createState() => _AddSeasonalOfferSccrenState();
}

class _AddSeasonalOfferSccrenState extends State<AddSeasonalOfferSccren> {
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

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date); // Example: 03/18/2025
  }

  final _formKey = GlobalKey<FormState>();
  final _nameContoller = TextEditingController();
  final _discountController = TextEditingController();
  final _onOfferController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameContoller.dispose();
    _discountController.dispose();
    _onOfferController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectTitle;
    List<String> categoryNames = ['5%', '10%', '15%'];
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppbar(
          titile: widget.status == false
              ? "Add Seasonal Offers"
              : "Edit Seasonal Offers",
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Form(
          key: _formKey,
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
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _nameContoller,
                      hintText: "Seasonal Offer Name*",
                    ),
                    UIHelper.verticalSpace(8.w),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownButton(
                            selectedValue: selectTitle,
                            items: categoryNames,
                            iconColor: Colors.white, // AppColors.cFFFFFF
                            hintText: "Discount",
                            borderRadius: 8.r,
                            isFilled: true,
                            onChanged: (value) {
                              setState(() {
                                selectTitle = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10), // Space between fields
                        Expanded(
                          child: CustomFormField(
                            hintText: "On Offer",
                            controller: _onOfferController,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(8.h),
                    Container(
                      padding: EdgeInsets.all(14.w),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start*",
                                  style: TextFontStyle
                                      .headline10w400c6B6B6BPoppins
                                      .copyWith(
                                          color: AppColors.c999999,
                                          fontSize: 16.sp),
                                ),
                                UIHelper.verticalSpace(8.h),
                                GestureDetector(
                                  onTap: () async {
                                    log("Click");
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );

                                    if (selectedDate != null) {
                                      // Format and set the date in the controller
                                      _startDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: CustomFormField(
                                      isRead: true,
                                      hintFontSize: 12.sp,
                                      hintText: "Start Date*",
                                      controller: _startDateController,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(10.sp),
                                        child: SvgPicture.asset(
                                            Assets.icons.calendar),
                                      ),
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
                                      border:
                                          Border.all(color: AppColors.c535353),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatTime(fromTime),
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
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: Column(
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
                                  onTap: () async {
                                    log("Click");
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );

                                    if (selectedDate != null) {
                                      // Format and set the date in the controller
                                      _endDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: CustomFormField(
                                      isRead: true,
                                      hintFontSize: 12.sp,
                                      hintText: "End Date*",
                                      controller: _endDateController,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(10.sp),
                                        child: SvgPicture.asset(
                                            Assets.icons.calendar),
                                      ),
                                    ),
                                  ),
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
                                          formatTime(toTime),
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
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    const Column(
                      children: [
                        CustomFormField(
                          maxline: 3,
                          hintText: "Describe the offer",
                        )
                      ],
                    )
                  ],
                ),
              ),
              UIHelper.verticalSpace(143.h),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // log("date $toTime");
                    addSessonalEventRx
                        .addSessonalEvent(
                          name: _nameContoller.text.trim(),
                          type: "seasonal",
                          discount: _discountController.text.trim(),
                          onOffer: _onOfferController.text.trim(),
                          startDate: _startDateController.text.trim(),
                          endDate: _endDateController.text.trim(),
                          startTime: formatClockTime(fromTime),
                          endTime: formatClockTime(toTime),
                          description: _descController.text.trim(),
                        )
                        .waitingForSucess()
                        .then((success) async {
                      if (success) {
                        await getSessonalOfferRx.getSessonalOffer();
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
      ),
    );
  }
}
