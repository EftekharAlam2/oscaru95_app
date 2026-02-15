import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_divider_widget.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/common_widget/social_button_widget.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/auth_provider.dart';
import 'package:oscaru95/services/venue_storage_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isChecked = true;
  int role = 1;

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
              CircleAvatar(
                radius: 80.r, // control size here
                backgroundImage: AssetImage(Assets.images.appLogoImage.path),
                backgroundColor: Colors.transparent, // optional
              ), // Text(
              //   "LOGO",
              //   style: TextFontStyle.headline28w600C222222Poppins
              //       .copyWith(color: AppColors.cFFFFFF, fontSize: 40.sp),
              // ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Welcome Back! Log in to continue your journey.',
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

              UIHelper.verticalSpace(16.h),

              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    foucusColor: true,
                    hintText: "Password",
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
              Row(
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                        return Checkbox(
                          activeColor: AppColors.cFFFFFF,
                          checkColor: AppColors.c000000,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: provider.isloginChecked,
                          onChanged: (value) {
                            //log("Check box value $value");
                            provider.toggleloginCheckBox();
                          },
                        );
                      },
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Text(
                    "Remember me",
                    style: TextFontStyle.headline12w400C999999Poppins,
                  )
                ],
              ),

              UIHelper.verticalSpace(32.h),

              CustomButton(
                textStaus: false,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    userLoginRX
                        .userLogin(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim())
                        .waitingForSucess()
                        .then((success) async {
                      if (success) {
                        // Store account type as "user"
                        appData.write(kKeyAccountType, "user");
                        
                        // Load and store venue data after successful login
                        try {
                          await VenueStorageService().loadAndStoreVenueData();
                        } catch (e) {
                          // Log error but don't block navigation
                          // Data will be loaded from assets if storage fails
                        }
                        
                        NavigationService.navigateToReplacement(
                            Routes.userNavigationScreen);
                      }
                    });
                  }
                },
                btnName: "Login",
              ),
              UIHelper.verticalSpace(24.h),
              //forget password
              Center(
                child: GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.forgetPaswordRoute);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextFontStyle.headline12w400C999999Poppins
                        .copyWith(color: AppColors.cFE5401),
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              // Custom button

              // Custom divider
              const CustomDividerWidget(),
              // UIHelper.verticalSpace(24.h),
              // //social button
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // SocialButtonWidget(
              //     //   onTap: () {},
              //     //   icon: Assets.icons.facebook,
              //     // ),
              //     SocialButtonWidget(
              //       onTap: () {},
              //       icon: Assets.icons.google,
              //     ),
              //     // SocialButtonWidget(
              //     //   onTap: () {},
              //     //   icon: Assets.icons.twttir,
              //     // ),
              //     SocialButtonWidget(
              //       onTap: () {},
              //       icon: Assets.icons.apple,
              //     ),
              //   ],
              // ),
              UIHelper.verticalSpace(32.h),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextFontStyle.headline14w400c666666Poppins,
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                NavigationService.navigateTo(
                                    Routes.signupRoute);
                              },
                            text: " Sign Up",
                            style: TextFontStyle.headline14w400c666666Poppins
                                .copyWith(
                              color: AppColors.cFF7A01,
                            ),
                          )
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
