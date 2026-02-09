import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';

class MerchantEditPasswordScreen extends StatefulWidget {
  const MerchantEditPasswordScreen({super.key});

  @override
  State<MerchantEditPasswordScreen> createState() =>
      _MerchantEditPasswordScreenState();
}

class _MerchantEditPasswordScreenState
    extends State<MerchantEditPasswordScreen> {
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _confNewPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPass.dispose();
    _newPass.dispose();
    _confNewPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Edit Password',
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Update your password',
                  style: TextFontStyle.headline24w400cFFFFFFPoppins),
              Text(
                "Your new password must be different from the previously used password.",
                style: TextFontStyle.headline12w400C999999Poppins,
              ),
              UIHelper.verticalSpace(24.h),
              CustomFormField(
                controller: _oldPass,
                foucusColor: true,
                noBorder: false,
                hintText: "Current Password",
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: AppColors.c999999,
                ),
                validator: (value) {
                  if (value == "" || value!.isEmpty) {
                    return "Write your current password";
                  }
                  return null;
                },
              ),
              UIHelper.verticalSpace(24.h),
              CustomFormField(
                controller: _newPass,
                foucusColor: true,
                noBorder: false,
                hintText: "New Password",
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: AppColors.c999999,
                ),
                validator: (value) {
                  if (value == "" || value!.isEmpty) {
                    return "Write your new password";
                  }
                  if (int.parse(value) < 8) {
                    return "Minimum password is 8";
                  }
                  return null;
                },
              ),
              UIHelper.verticalSpace(24.h),
              CustomFormField(
                controller: _confNewPass,
                foucusColor: true,
                noBorder: true,
                hintText: "Confirm Password",
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: AppColors.c999999,
                ),
                validator: (value) {
                  if (value == "" || value!.isEmpty) {
                    return "Write your current password";
                  }
                  if (value != _newPass.text) {
                    return "Password should similler like new password";
                  }
                  return null;
                },
              ),
              UIHelper.verticalSpace(260.h),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    busniessEditPassRx
                        .updatePassword(
                          oldPass: _oldPass.text.trim(),
                          password: _newPass.text.trim(),
                          confPass: _confNewPass.text.trim(),
                        )
                        .waitingForSucess()
                        .then((success) {
                      if (success) {
                        totalDataClean();
                        NavigationService.navigateToReplacementUntil(
                            Routes.loginMerchantScreen);
                      }
                    });
                  }
                },
                btnName: 'Reset',
                textStaus: false,
              ),
              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
