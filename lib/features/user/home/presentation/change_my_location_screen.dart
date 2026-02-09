import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class ChangeMyLocationScreen extends StatefulWidget {
  const ChangeMyLocationScreen({super.key});

  @override
  State<ChangeMyLocationScreen> createState() => _ChangeMyLocationScreenState();
}

class _ChangeMyLocationScreenState extends State<ChangeMyLocationScreen> {
  final _searchCnt = TextEditingController();

  @override
  void dispose() {
    _searchCnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text('Where are you going?',
            style: TextFontStyle.headline18w600CFFFFFFPoppins),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => NavigationService.goBack,
          child: Icon(
            CupertinoIcons.back,
            size: 24.sp,
            color: AppColors.cFFFFFF,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            // padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.c999999),
                  borderRadius: BorderRadius.circular(8.r)),
              child: CustomFormField(
                borderRadius: 8.r,
                borderCOlor: AppColors.cFFFFFF,
                contentPadding: EdgeInsets.all(24.sp),
                fillColor: AppColors.scaffoldColor,
                hintText: "Address, city, station....",
                controller: _searchCnt,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.locationFill,
                  fit: BoxFit.cover,
                  height: 20.sp,
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            decoration: const BoxDecoration(color: AppColors.c302F2E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.icons.routeSquare),
                    UIHelper.horizontalSpace(8.w),
                    Text('My current location',
                        style: TextFontStyle.headline16w400CFFFFFFPoppins
                            .copyWith(color: AppColors.c999999)),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24.sp,
                  color: AppColors.c999999,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
