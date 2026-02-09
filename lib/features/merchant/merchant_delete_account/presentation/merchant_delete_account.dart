import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';

class MerchantDeleteAccount extends StatefulWidget {
  const MerchantDeleteAccount({super.key});

  @override
  State<MerchantDeleteAccount> createState() => _MerchantDeleteAccountState();
}

class _MerchantDeleteAccountState extends State<MerchantDeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Delete Account',
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(Assets.icons.deleteBinIcon),
            UIHelper.verticalSpace(24.h),
            Text(
              "Are you sure?",
              style: TextFontStyle.headline24w600cFFFFFFPoppins,
            ),
            Text(
              "We're really sorry to see you go Are you sure you want to delete your account? Once you confirm, your data will be gone.",
              style: TextFontStyle.headline12w400C999999Poppins,
            ),
            UIHelper.verticalSpace(320.h),
            CustomButton(
              onTap: () {
                deleteBusinessProfileRx
                    .deleteBusinessProfile()
                    .waitingForSucess()
                    .then((success) {
                  if (success) {
                    totalDataClean();
                    NavigationService.navigateToReplacementUntil(
                        Routes.loginMerchantScreen);
                  }
                });
              },
              btnName: 'Delete Account',
              textStaus: false,
            ),
            UIHelper.verticalSpace(20.h),
          ],
        ),
      ),
    );
  }
}
