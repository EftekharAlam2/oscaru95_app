import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class CustomAlartDialogWidget extends StatelessWidget {
  const CustomAlartDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(27),
      ),
      insetPadding: const EdgeInsets.all(16),
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.c535353,
        ),
        padding: EdgeInsets.all(10.sp),
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: AppColors.cFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(Assets.icons.remove),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.sp),
                decoration: const BoxDecoration(
                    color: AppColors.c282828, shape: BoxShape.circle),
                child: SvgPicture.asset(Assets.icons.trush),
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                "Are you sure you want to cancel?",
                style: TextFontStyle.headline16w600CFFFFFFPoppins,
              ),
              UIHelper.verticalSpace(16.h),
              Text(
                "This action will cancel your seasonal offer. Are you sure?",
                style: TextFontStyle.headline12w400C999999Poppins,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(16.h),
              CustomButton(
                onTap: () {},
                btnName: "Yes, I’m sure",
                textStaus: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
