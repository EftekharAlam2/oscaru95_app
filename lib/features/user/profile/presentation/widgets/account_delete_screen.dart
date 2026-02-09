import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class AccountDeleteScreen extends StatefulWidget {
  const AccountDeleteScreen({super.key});

  @override
  State<AccountDeleteScreen> createState() => _AccountDeleteScreenState();
}

class _AccountDeleteScreenState extends State<AccountDeleteScreen> {
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
                  Text('Delete Account',
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
              SvgPicture.asset(
                Assets.icons.deleteTrashIcon,
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
              UIHelper.verticalSpaceMedium,
              Text('Are you sure?',
                  style: TextFontStyle.headline18w600CFFFFFFPoppins
                      .copyWith(fontSize: 24.sp)),
              UIHelper.verticalSpaceSmall,
              Text(
                  "We're really sorry to see you go Are you sure you want to delete your account? Once you confirm, your data will be gone.",
                  style: TextFontStyle.headline12w400C999999Poppins),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(24.sp),
        child: CustomButton(
          onTap: () {
            deleteUserProfileRxObj.deleteUserProfile().waitingForSucess().then((success){
              ToastUtil.showShortToast("Account deleted successfully.");
              NavigationService.navigateToReplacementUntil(Routes.loginScreen);

            });
            // deleteUserProfileRxObj
            // _registerValidator();
            // NavigationService.navigateToWithArgs(
            //     Routes.verifyOtpRoute, {
            //   "email": _emailController.text.trim(),
            // });
          },
          btnName: "Delete Account",
          textStaus: false,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
