import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class RoleChooseWidget extends StatelessWidget {
  const RoleChooseWidget({
    super.key,
    required this.name,
    required this.radioValue,
    required this.selectedValue,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
    required this.img,
    required this.name2,
    required this.onChanged,
  });

  final String name;
  final String radioValue;
  final String selectedValue;

  final String name2;

  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final Function(String?)? onChanged;
  final String img;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // ()
      // {
      //   onChanged?.call(radioValue);
      // },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.c484848,
                  child: Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: SvgPicture.asset(
                      img,
                      width: 80.w,
                      height: 80.h,
                    ),
                  ),
                ),
                UIHelper.horizontalSpace(24.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextFontStyle.headline20w600C222222Poppins
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                      Text(
                        name2,
                        style: TextFontStyle.headline12w400C999999Poppins,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0.h,
            right: 0.w,
            child: Radio<String>(
              value: radioValue,
              groupValue: selectedValue,
              onChanged: onChanged,
              fillColor: WidgetStateProperty.all(AppColors.cFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}
