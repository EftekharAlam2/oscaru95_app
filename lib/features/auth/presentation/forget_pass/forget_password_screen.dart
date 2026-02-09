import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

import '../../../../common_widget/custom_app_bar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        backgroundColor: AppColors.scaffoldColor,
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Forgot password?",
                style: TextFontStyle.headline28w600C222222Poppins
                    .copyWith(color: AppColors.cFFFFFF, fontSize: 28.sp),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Enter your email address and we’ll send you confirmation code to reset your password',
                textAlign: TextAlign.center,
                style: TextFontStyle.headline14w400c666666Poppins,
              ),
              UIHelper.verticalSpace(50.h),
              CustomFormField(
                foucusColor: true,
                hintText: "Email",
                controller: _emailController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              UIHelper.verticalSpace(32.h),
              CustomButton(
                textStaus: false,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    NavigationService.navigateToReplacement(
                        Routes.verifyOtpRoute);
                  }
                },
                btnName: "Continue",
              ),
              UIHelper.verticalSpace(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
