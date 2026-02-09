import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1.h,
            color: AppColors.c999999,
          ),
        ),
        UIHelper.horizontalSpace(16.w),
        Text(
          "Or continue with",
          style: TextFontStyle.headline14w600C999999Poppins,
        ),
        UIHelper.horizontalSpace(16.w),
        Expanded(
          child: Container(
            height: 1.h,
            color: AppColors.c999999,
          ),
        ),
      ],
    );
  }
}
