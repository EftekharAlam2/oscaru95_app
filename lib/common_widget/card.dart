// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class AvailabilityCard extends StatefulWidget {
  final String day;
  final bool isSelected;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;
  final Function(bool?) onSelected;
  final Function(TimeOfDay) onFromTimeChanged;
  final Function(TimeOfDay) onToTimeChanged;

  const AvailabilityCard({
    super.key,
    required this.day,
    required this.isSelected,
    required this.fromTime,
    required this.toTime,
    required this.onSelected,
    required this.onFromTimeChanged,
    required this.onToTimeChanged,
  });

  @override
  _AvailabilityCardState createState() => _AvailabilityCardState();
}

class _AvailabilityCardState extends State<AvailabilityCard> {
  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFromTime ? widget.fromTime : widget.toTime,
    );
    if (picked != null) {
      if (isFromTime) {
        widget.onFromTimeChanged(picked);
      } else {
        widget.onToTimeChanged(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String formatTime(TimeOfDay time) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80.w,
                height: 30.h,
                decoration: ShapeDecoration(
                  color: AppColors.c484848,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Center(
                  child: Text(
                    widget.day,
                    style: TextFontStyle.headline10w400c6B6B6BPoppins
                        .copyWith(color: AppColors.cFFFFFF, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Checkbox(
                value: widget.isSelected,
                onChanged: widget.onSelected,
                activeColor: AppColors.c484848,
              ),
            ],
          ),
          if (widget.isSelected) UIHelper.verticalSpace(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("From",
                  style: TextFontStyle.headline10w400c6B6B6BPoppins
                      .copyWith(color: AppColors.cFF6F6F6F, fontSize: 16.sp)),
              GestureDetector(
                onTap: () => _selectTime(context, true),
                child: Container(
                  // height: 40.h,
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: AppColors.c282828,
                    border: Border.all(color: AppColors.c535353),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formatTime(widget.fromTime),
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(
                                color: AppColors.cFF6F6F6F, fontSize: 16.sp),
                      ),
                      UIHelper.horizontalSpace(4.h),
                      const Icon(Icons.access_time, color: Colors.white),
                    ],
                  ),
                ),
              ),
              UIHelper.horizontalSpace(12.h),
              Text("To",
                  style: TextFontStyle.headline10w400c6B6B6BPoppins
                      .copyWith(color: AppColors.cFF6F6F6F, fontSize: 16.sp)),
              UIHelper.horizontalSpace(8.w),
              GestureDetector(
                onTap: () => _selectTime(context, false),
                child: Container(
                  // height: 40.h,
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.c535353),
                    color: AppColors.c282828,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        formatTime(widget.toTime),
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(
                                color: AppColors.cFF6F6F6F, fontSize: 16.sp),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      const Icon(Icons.access_time, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
