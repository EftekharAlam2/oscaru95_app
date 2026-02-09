import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/constants/validation.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';
import '../../../../provider/reset_password_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 80.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Reset Password",
                style: TextFontStyle.headline28w600C222222Poppins
                    .copyWith(color: AppColors.cFFFFFF, fontSize: 28.sp),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Please enter your new password',
                textAlign: TextAlign.center,
                style: TextFontStyle.headline14w400c666666Poppins,
              ),
              UIHelper.verticalSpace(50.h),
              Consumer<ResetPasswordProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    foucusColor: true,
                    hintText: "New Password",
                    controller: _newPasswordController,
                    isPass: true,
                    isObsecure: provider.isNewPassword,
                    // textInputAction: TextInputAction.done,
                    validator: passwordValidator,

                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.toggleNewPassword();
                      },
                      child: Icon(
                        provider.isNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(16.h),
              Consumer<ResetPasswordProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    foucusColor: true,
                    hintText: "Confirm Password",
                    controller: _confirmPasswordController,
                    isPass: true,
                    isObsecure: provider.isConfirmPassword,
                    validator: (value) => confirmPasswordValidator(
                        value, _newPasswordController.text),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.toggleConfirmPassword();
                      },
                      child: Icon(
                        provider.isConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  );
                },
              ),
              UIHelper.verticalSpace(32.h),
              CustomButton(
                textStaus: false,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    NavigationService.navigateToReplacement(
                        Routes.userNavigationScreen);
                  }
                },
                btnName: "Reset",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
