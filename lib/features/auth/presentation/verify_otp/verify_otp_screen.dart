import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 31.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(37.h),
              Text(
                "Verify your mobile number",
                style: TextFontStyle.headline24w700cFFFFFFPoppins,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "Enter 4-digit code sent to your mobile number +447984378436",
                style: TextFontStyle.headline14w400c666666Poppins,
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(59.h),
              Text(
                "Enter 4 Digit Code",
                style: TextFontStyle.headline16w500c222222Poppins
                    .copyWith(color: AppColors.cFFFFFF),
                textAlign: TextAlign.start,
              ),
              UIHelper.verticalSpace(24.h),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: false,
                blinkDuration: const Duration(microseconds: 0),
                controller: _otpController,
                textStyle: TextFontStyle.headline14w400c666666Poppins
                    .copyWith(fontSize: 18.sp, color: AppColors.cFFFFFF),

                pinTheme: PinTheme(
                  borderWidth: 0,
                  inactiveBorderWidth: 0,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8.r),
                  fieldHeight: 60.h,
                  fieldWidth: 75.w,
                  activeFillColor: AppColors.c282828,
                  inactiveFillColor: AppColors.c282828,
                  selectedFillColor: AppColors.c282828,
                  activeColor: AppColors.c282828,
                  inactiveColor: const Color.fromARGB(255, 190, 160, 160),
                  selectedColor: AppColors.c282828,
                  activeBorderWidth: 0,
                ),
                // onChanged: (value) {
                //   setState(
                //     () {
                //       _otpController.text = value;
                //     },
                //   );
                // },
              ),
              UIHelper.verticalSpace(16.h),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Didn’t Receive Code? ",
                    style: TextFontStyle.headline12w400C999999Poppins,
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // NavigationService.navigateTo(Routes.signupRoute);
                          },
                        text: "Resend Code",
                        style: TextFontStyle.headline12w400C999999Poppins
                            .copyWith(color: AppColors.cFE5401),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Resend code in 00:59",
                  style: TextFontStyle.headline12w400C999999Poppins,
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(32.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // SvgPicture.asset(
              //     //   Assets.icons.clockIcon,
              //     //   width: 20.w,
              //     //   height: 20.h,
              //     // ),
              //     UIHelper.horizontalSpace(8.w),
              //     Text(
              //       "03.50",
              //       style: TextFontStyle.headline14w600C999999Poppins,
              //     )
              //   ],
              // ),
              UIHelper.verticalSpace(150.h),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (_otpController.text.length == 4) {
                      setState(() => _isLoading = true);

                      try {
                        final success = await otpVerifyRxObj
                            .verifiyOtp(
                                email: widget.email,
                                otp: _otpController.text.toString())
                            .waitingForSucess();

                        if (mounted) {
                          setState(() => _isLoading = false);

                          if (success) {
                            ToastUtil.showLongToast("Your OTP is valid");
                            Future.delayed(const Duration(milliseconds: 500), () {
                              NavigationService.navigateTo(Routes.loginScreen);
                            });
                          } else {
                            ToastUtil.showShortToast("OTP verification failed. Please try again.");
                          }
                        }
                      } catch (e) {
                        if (mounted) {
                          setState(() => _isLoading = false);
                          ToastUtil.showShortToast("Error: ${e.toString()}");
                        }
                      }
                    } else {
                      ToastUtil.showShortToast("Please enter a valid 4-digit OTP");
                    }
                  }
                },
                btnName: _isLoading ? "Verifying..." : "Verify",
                textStaus: _isLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
