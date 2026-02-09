import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class MerchantHelpAndSupport extends StatefulWidget {
  const MerchantHelpAndSupport({super.key});

  @override
  State<MerchantHelpAndSupport> createState() => _MerchantHelpAndSupportState();
}

class _MerchantHelpAndSupportState extends State<MerchantHelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Help & Support',
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Need Assistance? We're Here to Help!",
                style: TextFontStyle.headline24w600cFFFFFFPoppins),
            Text(
              "If you have any questions, issues, or need support, feel free to reach out to us via WhatsApp.",
              style: TextFontStyle.headline12w400C999999Poppins,
            ),
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
                  Text("Contact Us on WhatsApp",
                      style: TextFontStyle.headline16w600CFFFFFFPoppins),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.whatsAppIcon),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        "+1 234 567 890",
                        style: TextFontStyle.headline16w400CFFFFFFPoppins
                            .copyWith(color: AppColors.c999999),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.gmail),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        "emrshop@gmail.com",
                        style: TextFontStyle.headline16w400CFFFFFFPoppins
                            .copyWith(color: AppColors.c999999),
                      )
                    ],
                  )
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Text(
              "We value your feedback and are always here to help you!",
              style: TextFontStyle.headline12w400C999999notoSansOldItalic,
            ),
          ],
        ),
      ),
    );
  }
}
