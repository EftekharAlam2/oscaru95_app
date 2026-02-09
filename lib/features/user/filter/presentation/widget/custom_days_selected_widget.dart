
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDaysSelectedWidget extends StatelessWidget {
  final String days;
  final VoidCallback ontap;
  final Color borderColor;
  final TextStyle textStyle;
  const CustomDaysSelectedWidget(
      {super.key,
      required this.days,
      required this.ontap,
      required this.borderColor,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
          decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(4.r)),
          child: Text(days, style: textStyle)),
    );
  }
}
