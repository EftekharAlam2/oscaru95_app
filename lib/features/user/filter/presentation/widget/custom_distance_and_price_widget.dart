

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class CustomDistanceAndPriceWidget extends StatelessWidget {
  final String titile;
  final String desciption;
  const CustomDistanceAndPriceWidget({
    super.key,
    required this.titile,
    required this.desciption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.icons.dollar),
        UIHelper.horizontalSpace(8.w),
        Text(
          titile,
          style: TextFontStyle.headline16w500c222222Poppins
              .copyWith(color: AppColors.cFFFFFF),
        ),
        UIHelper.horizontalSpace(4.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.h),
          decoration: BoxDecoration(
              color: AppColors.c282828,
              borderRadius: BorderRadius.circular(40.r)),
          child: Text(
            desciption,
            style: TextFontStyle.headline10w400c6B6B6BPoppins
                .copyWith(color: AppColors.cFFFFFF),
          ),
        )
      ],
    );
  }
}
