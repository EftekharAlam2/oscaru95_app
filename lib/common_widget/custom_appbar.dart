import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.titile,
    required this.centerTitile,
  });

  final String titile;
  final bool centerTitile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      centerTitle: centerTitile,
      leading: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 2.w),
        child: GestureDetector(
          onTap: () {
            NavigationService.goBack;
          },
          child: Container(
            height: 24.h,
            width: 24.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.c282828,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset(
                Assets.icons.arrowBackIcon,
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Text(titile, style: TextFontStyle.headline24w700cFFFFFFPoppins),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
