import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class CustomProfileInfoWidget extends StatelessWidget {
  final String titile;
  final String icon;
  final VoidCallback pressInfo;
  const CustomProfileInfoWidget({
    super.key,
    required this.titile,
    required this.icon,
    required this.pressInfo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressInfo,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: AppColors.c282828, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                UIHelper.horizontalSpace(12.w),
                Text(
                  titile,
                  style: TextFontStyle.headline16w500c222222Poppins
                      .copyWith(color: AppColors.cFFFFFF),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                color: AppColors.c535353,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                Assets.icons.arrowRightIcon,
                width: 16.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
