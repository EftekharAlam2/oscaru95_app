import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class MerchantPrivacyPolicy extends StatefulWidget {
  const MerchantPrivacyPolicy({super.key});

  @override
  State<MerchantPrivacyPolicy> createState() => _MerchantPrivacyPolicyState();
}

class _MerchantPrivacyPolicyState extends State<MerchantPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Privacy Policy',
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Terms & Conditions",
                style: TextFontStyle.headline18w400CFFFFFFPoppins),
            UIHelper.verticalSpace(12.h),
            Text(dummuyText, style: TextFontStyle.headline14w400c99999Poppins),
            UIHelper.verticalSpace(12.h),
            Text(dummuyText, style: TextFontStyle.headline14w400c99999Poppins
                // ignore: deprecated_member_use

                ),
            UIHelper.verticalSpace(18.h),
            Text("Agreements",
                style: TextFontStyle.headline18w400CFFFFFFPoppins),
            UIHelper.verticalSpace(12.h),
            Text(dummuyText, style: TextFontStyle.headline14w400c99999Poppins
                // ignore: deprecated_member_use

                ),
            UIHelper.verticalSpace(12.h),
            Text(dummuyText, style: TextFontStyle.headline14w400c99999Poppins

                // ignore: deprecated_member_use

                ),
          ],
        ),
      ),
    );
  }

  String dummuyText =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.";
}
