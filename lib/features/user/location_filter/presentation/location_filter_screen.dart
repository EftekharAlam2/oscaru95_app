import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_app_bar.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

import '../../../../common_widget/custom_form_field.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';

class LocationFilterScreen extends StatefulWidget {
  const LocationFilterScreen({super.key});

  @override
  State<LocationFilterScreen> createState() => _LocationFilterScreenState();
}

class _LocationFilterScreenState extends State<LocationFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomAppBar(
          backgroundColor: AppColors.scaffoldColor,
          showBackButton: true,
          title: 'Where are you going?',
          style: TextFontStyle.headline18w600cFFFFFFPoppins),
      body: Column(
        children: [
          Divider(
            thickness: 1.w,
            color: AppColors.c282828,
          ),
          UIHelper.verticalSpace(18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomFormField(
              borderCOlor: AppColors.c9C9C9C,
              borderRadius: 8.r,
              controller: _searchController,
              contentPadding: EdgeInsets.symmetric(vertical: 18.h),
              hintText: 'Address, city, station....',
              labelStyle: TextFontStyle.headline16w500c9C9C9CPoppins,
              prefixIcon: SvgPicture.asset(
                Assets.icons.locationFill,
                width: 24.w,
                height: 24.w,
              ),
            ),
          ),
          UIHelper.verticalSpace(24.h),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: ShapeDecoration(
              color: const Color(0x19FFEEE6),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50.w,
                  color: const Color(0xFF282828),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.icons.routeSquare,
                  width: 24.w,
                  height: 24.h,
                ),
                UIHelper.horizontalSpace(8.w),
                Text(
                  'My current location',
                  style: TextFontStyle.headline16w400CFFFFFFPoppins
                      .copyWith(color: AppColors.c9C9C9C),
                ),
                const Spacer(),
                SvgPicture.asset(
                  Assets.icons.arrowLeft,
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
