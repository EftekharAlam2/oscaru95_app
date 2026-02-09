// ignore_for_file: unused_element

import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_divider_widget.dart';
import 'package:oscaru95/common_widget/custom_dropdown_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/common_widget/number_picker.dart';
import 'package:oscaru95/common_widget/social_button_widget.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateOfBirthCOntroller = TextEditingController();
  final _homePostcodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

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
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: '',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(useMaterial3: true),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(
        () {
          _dateOfBirthCOntroller.text = formattedDate;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
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

              UIHelper.verticalSpace(8.h),
              Text(
                'Welcome Back! Log in to continue your journeys',
                textAlign: TextAlign.center,
                style: TextFontStyle.headline14w400c666666Poppins,
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
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                          color: AppColors.c282828,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundImage: selectImage != null
                                ? FileImage(
                                    File(selectImage.path),
                                  )
                                : null,
                            child: selectImage == null
                                ? ClipOval(
                                    child: Image.asset(
                                      Assets.images.profile.path,
                                      fit: BoxFit.cover,
                                      width: 80.w,
                                      height: 80.h,
                                    ),
                                  )
                                : null,
                          ),
                          UIHelper.verticalSpace(8.h),
                          Text('Upload Profile Picture',
                              style: TextFontStyle.headline16w400CFFFFFFPoppins
                                  .copyWith(color: AppColors.c999999)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              UIHelper.verticalSpace(12.h),

              Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      foucusColor: true,
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
                      foucusColor: true,
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
                    foucusColor: true,
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
                foucusColor: true,
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
                foucusColor: true,
                hintText: "Address*",
                controller: _addressController,
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Your Address';
                  }
                  return null;
                },
              ),
              UIHelper.verticalSpace(12.h),
              CustomFormField(
                foucusColor: true,
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

              // PhoneTextField(
              //   controller: _phoneController,
              //   prefixIconOnChanged: (countryCode) {
              //     // setState(() {
              //     //   selectedCountryCode = countryCode.dialCode!;
              //     //   log("selected country code : $selectedCountryCode");
              //     // });
              //   },
              // ),

              UIHelper.verticalSpace(12.h),

              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return CustomFormField(
                    hintText: "Password*", foucusColor: true,
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
                    foucusColor: true,
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

              UIHelper.verticalSpace(48.h),
              // Custom button
              CustomButton(
                textStaus: false,
                onTap: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      await userSignupRxObj
                          .userSignup(
                              fName: _firstNameController.text.toString(),
                              lName: _lastNameController.text.toString(),
                              email: _emailController.text.toString(),
                              password: _passwordController.text.toString(),
                              confPass:
                                  _confirmPasswordController.text.toString(),
                              phone: _phoneController.text.toString(),
                              dob: _dateOfBirthCOntroller.text.toString(),
                              gender: selectedGenderValue.toString(),
                              avatar: imageNotifier.value,
                              zipCode: _homePostcodeController.text.toString(),
                              address: _addressController.text.toString(),
                              location: "dadhahnd",
                              latitude: "23.782398",
                              longitude: "90.4032252")
                          .waitingForSucess()
                          .then((success) {
                        NavigationService.navigateToWithArgs(
                            Routes.verifyOtpRoute, {
                          "email": _emailController.text.trim(),
                        });
                      });
                      // register user here
                    }
                  } catch (e) {
                    print(e);
                  }

                  // _registerValidator();
                  /* NavigationService.navigateToWithArgs(Routes.verifyOtpRoute, {
                    "email": _emailController.text.trim(),
                  });  */
                },
                btnName: "Register",
              ),
              UIHelper.verticalSpace(48.h),
              // Custom divider
              const CustomDividerWidget(),
              UIHelper.verticalSpace(24.h),
              //social button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SocialButtonWidget(
                  //   onTap: () {},
                  //   icon: Assets.icons.facebook,
                  // ),
                  SocialButtonWidget(
                    onTap: () {},
                    icon: Assets.icons.google,
                  ),
                  // SocialButtonWidget(
                  //   onTap: () {},
                  //   icon: Assets.icons.twttir,
                  // ),
                  SocialButtonWidget(
                    onTap: () {},
                    icon: Assets.icons.apple,
                  ),
                ],
              ),
              UIHelper.verticalSpace(32.h),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Have an account? ",
                    style: TextFontStyle.headline14w400c666666Poppins,
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log("Navigat Rester screen");
                            NavigationService.navigateTo(Routes.loginScreen);
                          },
                        text: " Log In here",
                        style: TextFontStyle.headline14w600CFF7A01Poppins,
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(30.h)
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

  void _signUp() async {}
}
