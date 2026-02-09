import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class CustomDateTimeWidget extends StatelessWidget {
  final String icon;
  final String from;
  final String to;

  final String divide;
  const CustomDateTimeWidget({
    super.key,
    required this.icon,
    required this.from,
    required this.to,
    required this.divide,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 16.w,
          ),
          UIHelper.horizontalSpace(4.w),
          Text(
            from,
            style: TextFontStyle.headline12w400C999999Poppins.copyWith(
              color: AppColors.cFFFFFF,
            ),
          ),
          UIHelper.horizontalSpace(4.w),
          Text(
            divide,
            style: TextFontStyle.headline12w400C999999Poppins
                .copyWith(color: AppColors.cFFFFFF),
          ),
          UIHelper.horizontalSpace(4.w),
          Text(
            to,
            style: TextFontStyle.headline12w400C999999Poppins.copyWith(
              color: AppColors.cFFFFFF,
            ),
          ),
          UIHelper.horizontalSpace(12.w),
        ],
      ),
    );
  }
}
