
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomAddButton extends StatelessWidget {
  final String titile;
  final VoidCallback ontap;
  const CustomAddButton({
    super.key,
    required this.titile,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cFE5401),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            titile,
            style: TextFontStyle.headline18w500CFFFFFFPoppins
                .copyWith(color: AppColors.cFE5401),
          ),
        ),
      ),
    );
  }
}
