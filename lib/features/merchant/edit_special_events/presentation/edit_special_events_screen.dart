import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/model/event_details_response.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class EditSpecialEventsScreen extends StatefulWidget {
  final int id;
  const EditSpecialEventsScreen({super.key, required this.id});

  @override
  State<EditSpecialEventsScreen> createState() =>
      _EditSpecialEventsScreenState();
}

class _EditSpecialEventsScreenState extends State<EditSpecialEventsScreen> {
  bool isSelected = false;
  TimeOfDay fromTime = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay toTime = const TimeOfDay(hour: 13, minute: 0);
  DateTime selectedDate = DateTime.now();

  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFromTime ? fromTime : toTime,
    );

    if (picked != null) {
      log('Selected time: ${picked.format(context)}'); // Debug log

      setState(() {
        if (isFromTime) {
          fromTime = picked;
          log('Updated fromTime: ${fromTime.format(context)}'); // Debug log
        } else {
          toTime = picked;
          log('Updated toTime: ${toTime.format(context)}'); // Debug log
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

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
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
          titile: "Edit Special Events",
          centerTitile: false,
        ),
      ),
      body: StreamBuilder(
        stream: getEventDetailsRx.getEventDetailsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            EventDetailsResponse response = snapshot.data;
            final data = response.data;
            if (_eventNameController.text.isEmpty) {
              _eventNameController.text = data?.name ?? "";
              _eventDateController.text = data?.startDate != null
                  ? DateFormat('yyyy-MM-dd').format(data!.startDate!)
                  : "";

              // Only set fromTime and toTime if they haven't been set yet
              if (fromTime == const TimeOfDay(hour: 12, minute: 0)) {
                fromTime = convertToTimeOfDay(data!.startTime!);
              }

              if (toTime == const TimeOfDay(hour: 13, minute: 0)) {
                toTime = convertToTimeOfDay(data?.endTime!);
              }

              _descController.text = data?.description ?? "";
            }
            return SingleChildScrollView(
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
                              DateTime initialDate =
                                  data?.startDate ?? DateTime.now();
                              log("Initial Date ======> $initialDate");
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: initialDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );

                              if (selectedDate != null) {
                                // Format and set the date in the controller
                                _eventDateController.text =
                                    DateFormat('yyyy-MM-dd')
                                        .format(selectedDate);
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomFormField(
                                isRead: true,
                                hintText: "Event Date*",
                                controller: _eventDateController,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child:
                                      SvgPicture.asset(Assets.icons.calendar),
                                ),
                              ),
                            ),
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
                                          border: Border.all(
                                              color: AppColors.c535353),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
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
                                                      color:
                                                          AppColors.cFF6F6F6F,
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
                                          border: Border.all(
                                              color: AppColors.c535353),
                                          color: AppColors.c282828,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
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
                                                      color:
                                                          AppColors.cFF6F6F6F,
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
                      if (_formKey.currentState!.validate()) {
                        editSpecialEventRx
                            .editSpecialEvent(
                              id: widget.id,
                              type: "special",
                              name: _eventNameController.text.trim(),
                              startDate: _eventDateController.text.trim(),
                              startTime: formatClockTime(fromTime),
                              endTime: formatClockTime(toTime),
                              description: _descController.text.trim(),
                            )
                            .waitingForSucess()
                            .then((success) async {
                          if (success) {
                            ToastUtil.showLongToast(
                                "Event updated successfully");
                            await getSpecialOfferRx.getSpecialOffer();
                            NavigationService.goBack;
                          }
                        });
                      }
                    },
                    btnName: "Update",
                    textStaus: false,
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
