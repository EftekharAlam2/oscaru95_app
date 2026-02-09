import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newConfirmPasswordController = TextEditingController();

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
                  Text('Edit Personal Info',
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
              Text('Update your password',
                  style: TextFontStyle.headline14w400CFFFFFFPoppins
                      .copyWith(fontSize: 24.sp)),
              Text(
                  "Your new password must be different from the previously used password.",
                  style: TextFontStyle.headline12w400C999999Poppins),
              UIHelper.verticalSpaceMedium,
              UIHelper.verticalSpace(12.h),
              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    hintText: "Current Password*",
                    controller: _passwordController,
                    isPass: true,
                    isObsecure: provider.isPassVisible,
                    // textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid Password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.togglePassword();
                      },
                      child: Icon(
                        provider.isPassVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(12.h),
              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    hintText: "New Password*",
                    controller: _newPasswordController,
                    isPass: true,
                    isObsecure: provider.isRegisterPassVisible,
                    // textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid Password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.toggleRegisterPassVisiable();
                      },
                      child: Icon(
                        provider.isRegisterPassVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(12.h),
              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    hintText: "Confirm Password*",
                    controller: _newConfirmPasswordController,
                    isPass: true,
                    isObsecure: provider.isPassVisible,
                    // textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid Password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.togglePassword();
                      },
                      child: Icon(
                        provider.isPassVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(150.h),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(24.sp),
        child: CustomButton(
          onTap: () {
            updatePasswordRxObj
                .editPassword(
                    currentPass: _passwordController.text.trim().toString(),
                    password: _newPasswordController.text.trim().toString(),
                    confirmPassword:
                        _newConfirmPasswordController.text.trim().toString())
                .waitingForSucess()
                .then((success) {
              ToastUtil.showLongToast("Password updated successfully.");
              NavigationService.navigateToReplacement(
                  Routes.userNavigationScreen);
            });
            // _registerValidator();
            // NavigationService.navigateToWithArgs(
            //     Routes.verifyOtpRoute, {
            //   "email": _emailController.text.trim(),
            // });
          },
          textStaus: false,
          btnName: "Reset Password",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
