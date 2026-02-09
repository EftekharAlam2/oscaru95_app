// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_dropdown_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/common_widget/number_picker.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateOfBirthCOntroller = TextEditingController();
  final _homePostcodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedGenderValue;
  List<String> item = ["Bar", "Restaurant", "Café"];
  bool isSelected = false;
  TimeOfDay fromTime = const TimeOfDay(hour: 12, minute: 0); // Default time
  TimeOfDay toTime = const TimeOfDay(hour: 13, minute: 0);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dateOfBirthCOntroller.dispose();
    _confirmPasswordController.dispose();
    _homePostcodeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    final DateFormat formatter = DateFormat('dd MMM yyyy');

    if (pickedDate != null) {
      setState(
        () {
          _dateOfBirthCOntroller.text = formatter.format(pickedDate);
        },
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFromTime ? fromTime : toTime,
    );

    if (picked != null) {
      setState(() {
        if (isFromTime) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 80.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Edit Your Venue",
                style: TextFontStyle.headline28w600C222222Poppins
                    .copyWith(color: AppColors.cFFFFFF, fontSize: 24.sp),
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                'Please enter your details to create an account.',
                textAlign: TextAlign.center,
                style: TextFontStyle.headline14w400c666666Poppins,
              ),
              UIHelper.verticalSpace(50.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                    color: AppColors.c282828,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        Assets.images.profile.path,
                        height: 80.h,
                      ),
                    ),
                    UIHelper.verticalSpace(8.h),
                    Text('Upload Profile Picture',
                        style: TextFontStyle.headline16w400CFFFFFFPoppins
                            .copyWith(color: AppColors.c999999)),
                  ],
                ),
              ),
              UIHelper.verticalSpace(12.h),

              CustomFormField(
                hintText: "Venue Name*",
                controller: _firstNameController,
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Venue Name*';
                  }
                  return null;
                },
              ),

              UIHelper.verticalSpace(12.h),

              CustomDropdownButton(
                selectedValue: selectedGenderValue,
                onChanged: (value) {
                  setState(() {
                    selectedGenderValue = value;
                  });
                },
                iconColor: AppColors.cFFFFFF,
                hintText: "Type of Establishment*",
                borderRadius: 8.r,
                items: item,
                isFilled: true,
              ),
              UIHelper.verticalSpace(12.h),
              GestureDetector(
                onTap: () {},
                child: AbsorbPointer(
                  child: CustomFormField(
                    hintText: "Address*",
                    controller: _dateOfBirthCOntroller,
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'Enter Your Date of Birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              CustomFormField(
                hintText: "Post Code**",
                controller: _homePostcodeController,
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Your Home Postcode';
                  }
                  return null;
                },
              ),
              UIHelper.verticalSpace(12.h),
              CustomFormField(
                hintText: "Email Address*",
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
              UIHelper.verticalSpace(12.h),

              PhoneTextField(
                controller: _phoneController,
                prefixIconOnChanged: (countryCode) {
                  // setState(() {
                  //   selectedCountryCode = countryCode.dialCode!;
                  //   log("selected country code : $selectedCountryCode");
                  // });
                },
              ),

              UIHelper.verticalSpace(12.h),

              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    hintText: "Password*",
                    controller: _passwordController,
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
                    controller: _confirmPasswordController,
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
              Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Operating Hours*",
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(
                                color: AppColors.c999999, fontSize: 16.sp),
                      ),
                      UIHelper.verticalSpace(8.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.cFFFFFF, width: 0.5.w),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start",
                                  style: TextFontStyle
                                      .headline10w400c6B6B6BPoppins
                                      .copyWith(
                                          color: AppColors.c999999,
                                          fontSize: 16.sp),
                                ),
                                UIHelper.verticalSpace(8.h),
                                UIHelper.verticalSpace(8.h),
                                GestureDetector(
                                  onTap: () => _selectTime(context, true),
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.c282828,
                                      border:
                                          Border.all(color: AppColors.c535353),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatTime(fromTime),
                                          style: TextFontStyle
                                              .headline10w400c6B6B6BPoppins
                                              .copyWith(
                                                  color: AppColors.cFF6F6F6F,
                                                  fontSize: 16.sp),
                                        ),
                                        const Icon(Icons.access_time,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End",
                                  style: TextFontStyle
                                      .headline10w400c6B6B6BPoppins
                                      .copyWith(
                                          color: AppColors.c999999,
                                          fontSize: 16.sp),
                                ),
                                UIHelper.verticalSpace(8.h),
                                UIHelper.verticalSpace(8.h),
                                GestureDetector(
                                  onTap: () => _selectTime(context, false),
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.c535353),
                                      color: AppColors.c282828,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatTime(toTime),
                                          style: TextFontStyle
                                              .headline10w400c6B6B6BPoppins
                                              .copyWith(
                                                  color: AppColors.cFF6F6F6F,
                                                  fontSize: 16.sp),
                                        ),
                                        const Icon(Icons.access_time,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              UIHelper.verticalSpace(12.h),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       height: 24.h,
              //       width: 24.w,
              //       child: Consumer<AuthProvider>(
              //         builder: (context, provider, child) {
              //           return Checkbox(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(5),
              //             ),
              //             value: provider.isChecked,
              //             onChanged: (value) {
              //               log("Check box value $value");
              //               provider.toggleCheckBox();
              //             },
              //           );
              //         },
              //       ),
              //     ),
              //     UIHelper.horizontalSpaceSmall,
              //     Expanded(
              //       child: RichText(
              //         textAlign: TextAlign.justify,
              //         text: TextSpan(
              //           text: "I Agree with ",
              //           style: TextFontStyle.headline14w500C222222Poppins,
              //           children: [
              //             TextSpan(
              //               recognizer: TapGestureRecognizer()
              //                 ..onTap = () {
              //                   log("Navigat Rester screen");
              //                 },
              //               text: "Terms of Service ",
              //               style: TextFontStyle.headline14w600CFF7A01Poppins,
              //               children: [
              //                 TextSpan(
              //                     text: "and ",
              //                     style: TextFontStyle
              //                         .headline14w500C222222Poppins,
              //                     children: [
              //                       TextSpan(
              //                         recognizer: TapGestureRecognizer()
              //                           ..onTap = () {
              //                             log("Navigat Rester screen");
              //                           },
              //                         text: "Privacy Policy ",
              //                         style: TextFontStyle
              //                             .headline14w600CFF7A01Poppins,
              //                         // textAlign: TextAlign.center
              //                       ),
              //                     ]),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              UIHelper.verticalSpace(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      textStaus: false,
                      borderBg: false,
                      status: false,
                      onTap: () {
                        NavigationService.navigateToReplacement(
                            Routes.merchantNavigation);
                        // NavigationService.navigateToReplacement(
                        //     Routes.succeessScreen);

                        // _registerValidator();
                        // NavigationService.navigateToWithArgs(Routes.verifyOtpRoute, {
                        //   "email": _emailController.text.trim(),
                        // });
                      },
                      btnName: "Cancel",
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(
                    child: CustomButton(
                      textStaus: false,
                      status: true,
                      onTap: () {
                        NavigationService.navigateToReplacement(
                            Routes.merchantNavigation);
                        // NavigationService.navigateToReplacement(
                        //     Routes.succeessScreen);

                        // _registerValidator();
                        // NavigationService.navigateToWithArgs(Routes.verifyOtpRoute, {
                        //   "email": _emailController.text.trim(),
                        // });
                      },
                      btnName: "Update",
                    ),
                  ),
                ],
              ),
              // Custom button
              UIHelper.verticalSpace(24.h),
              // Custom divider
            ],
          ),
        ),
      ),
    );
  }

  void _registerValidator() {
    if (_formKey.currentState!.validate()) {
      log("Register success");
    }
  }
}
