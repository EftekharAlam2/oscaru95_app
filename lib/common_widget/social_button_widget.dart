import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.all(8.sp),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF484848)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: SvgPicture.asset(
          icon,
          width: 24.w,
          height: 24.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
