import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack,
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: const BoxDecoration(
                        // color: AppColors.c282828,
                        shape: BoxShape.circle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.cFFFFFF,
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text('Help & Support',
                      style: TextFontStyle.headline18w600CFFFFFFPoppins),
                  GestureDetector(
                    onTap: () => NavigationService.goBack,
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: const BoxDecoration(
                        color: AppColors.scaffoldColor,
                        shape: BoxShape.circle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.scaffoldColor,
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(40.h),
              Text("Need Assistance? We're Here to Help!",
                  style: TextFontStyle.headline18w600CFFFFFFPoppins
                      .copyWith(fontSize: 24.sp)),
              UIHelper.verticalSpaceSmall,
              Text(
                  "If you have any questions, issues, or need support, feel free to reach out to us via WhatsApp.",
                  style: TextFontStyle.headline12w400C999999Poppins),
              UIHelper.verticalSpace(24.h),
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: AppColors.c282828,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact Us on E-Mail",
                        style: TextFontStyle.headline16w600CFFFFFFPoppins),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      children: [
                        Image.asset(
                          Assets.images.gmail.path,
                          height: 24.h,
                          width: 24.h,
                          fit: BoxFit.cover,
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text("Support@motiveeltd.com",
                            style: TextFontStyle.headline12w400C999999Poppins),
                      ],
                    )
                  ],
                ),
              ),
              UIHelper.verticalSpace(24.h),
              Text("We value your feedback and are always here to help you!",
                  style: TextFontStyle.headline12w400C999999Poppins),
            ],
          ),
        ),
      ),
    );
  }
}
