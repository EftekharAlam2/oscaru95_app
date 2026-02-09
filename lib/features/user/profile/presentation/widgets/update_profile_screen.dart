// ignore_for_file: unused_element

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_dropdown_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/common_widget/number_picker.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                UIHelper.verticalSpace(50.h),

                GestureDetector(
                  onTap: () {
                    imagePickerDialog(context, imageNotifier);
                  },
                  child: ValueListenableBuilder(
                    valueListenable: imageNotifier,
                    builder: (context, selectImage, child) {
                      return Container(
                          width: double.infinity,
                          height: 150.h,
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                              color: AppColors.c282828,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: selectImage == null
                              ? Column(
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
                                        style: TextFontStyle
                                            .headline16w400CFFFFFFPoppins
                                            .copyWith(
                                                color: AppColors.c999999)),
                                  ],
                                )
                              : Image.file(
                                  selectImage,
                                  fit: BoxFit.cover,
                                ));
                    },
                  ),
                ),

                UIHelper.verticalSpace(12.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        hintText: "First Name*",
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value?.isEmpty == true) {
                            return 'Enter Your User Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    UIHelper.horizontalSpace(16.w),
                    Expanded(
                      child: CustomFormField(
                        hintText: "Last Name*",
                        controller: _lastNameController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value?.isEmpty == true) {
                            return 'Enter Your User Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                UIHelper.verticalSpace(12.h),

                CustomDropdownButton(
                  selectedValue: selectedGenderValue,
                  onChanged: (value) {
                    setState(() {
                      selectedGenderValue = value;
                    });
                  },
                  hintText: "Gender*",
                  borderRadius: 8.r,
                  items: const [
                    "male",
                    "female",
                  ],
                  isFilled: true,
                ),
                UIHelper.verticalSpace(12.h),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: CustomFormField(
                      hintText: "Date of Birth*",
                      controller: _dateOfBirthCOntroller,
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value?.isEmpty == true) {
                          return 'Enter Your Date of Birth';
                        }
                        return null;
                      },
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: SvgPicture.asset(Assets.icons.calendar),
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                CustomFormField(
                  hintText: "Home Postcode*",
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
                  hintText: "Email*",
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

                UIHelper.verticalSpace(24.h),
                // Custom button
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () => NavigationService.goBack,
                      child: Container(
                        height: 59.h,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.c282828, width: 2.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextFontStyle.headline14w600CFFFFFFPoppins
                                .copyWith(
                                    color: AppColors.cFFFFFF, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    )
                        // CustomButton(
                        //   onTap: () {
                        //     NavigationService.goBack;
                        //   },
                        //   btnName: "Cancel",
                        // ),
                        ),
                    UIHelper.horizontalSpaceMedium,
                    Expanded(
                      child: CustomButton(
                        onTap: () async {
                          updateProfileRxObj
                              .updateProfile(
                                  fName: _firstNameController.text.trim(),
                                  lName: _lastNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  gender: selectedGenderValue.toString(),
                                  dob: "",
                                  avatar: imageNotifier.value,
                                  zipCode: _homePostcodeController.text
                                      .trim()
                                      .toString(),
                                  address: "",
                                  latitude: "",
                                  longitude: "")
                              .waitingForSucess()
                              .then((success) {
                            NavigationService.navigateToReplacement(
                                Routes.userNavigationScreen);
                            ToastUtil.showLongToast(
                                "Profile updated successfully.");
                          });

                          // _registerValidator();
                          // NavigationService.navigateToWithArgs(
                          //     Routes.verifyOtpRoute, {
                          //   "email": _emailController.text.trim(),
                          // });
                        },
                        btnName: "Update",
                        textStaus: false,
                      ),
                    ),
                  ],
                ),

                UIHelper.verticalSpace(30.h)
              ],
            ),
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
