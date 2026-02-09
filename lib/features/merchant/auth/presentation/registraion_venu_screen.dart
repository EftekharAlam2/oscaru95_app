// ignore_for_file: unused_element, use_key_in_widget_constructors, unused_local_variable

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
import 'package:oscaru95/features/location_picker/presentation/location_picker_screen.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/auth_provider.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class RegistrationVenuScreen extends StatefulWidget {
  const RegistrationVenuScreen({super.key});

  @override
  State<RegistrationVenuScreen> createState() => _RegistrationVenuScreenState();
}

class _RegistrationVenuScreenState extends State<RegistrationVenuScreen> {
  final _venuNameController = TextEditingController();
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
  final ValueNotifier<File?> imageNotifier2 = ValueNotifier<File?>(null);
  final ValueNotifier<File?> imageNotifier3 = ValueNotifier<File?>(null);

  String? selectedRestaurent;
  List<String> item = ["Bar", "Restaurant", "Café"];
  bool isSelected = false;
  TimeOfDay fromTime = const TimeOfDay(hour: 12, minute: 0);
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
    _addressController.dispose();
    _venuNameController.dispose();
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

  double? latitude;
  double? longitude;

  Future<void> _pickAddressFromMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
    );

    if (result != null) {
      setState(() {
        _addressController.text = result["address"];
        latitude = result["latitude"];
        longitude = result["longitude"];
      });
    }
  }

  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
  @override
  void initState() {
    getEstablishment.GetEstablishment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File? selectImage;
    final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
    final ValueNotifier<File?> imageNotifier1 = ValueNotifier<File?>(null);

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
                "Register Your Venue",
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
                                          .copyWith(color: AppColors.c999999)),
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

              CustomFormField(
                hintText: "Venue Name*",
                controller: _venuNameController,
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Venue Name*';
                  }
                  return null;
                },
              ),

              UIHelper.verticalSpace(12.h),

              StreamBuilder(
                stream: getEstablishment.getCategory,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  var model = snapshot.data?.data;

                  if (model == null || model.isEmpty) {
                    return const Text("No categories available");
                  }

                  selectedRestaurent ??=
                      model.isNotEmpty ? model.first.id.toString() : null;

                  List<String> categoryNames = model
                      .map<String>((category) => category.title ?? '')
                      .toList();

                  return CustomDropdownButton(
                    selectedValue: selectedRestaurent,
                    onChanged: (value) {
                      setState(() {
                        selectedRestaurent = model
                            .firstWhere((category) => category.title == value)
                            .id
                            .toString();
                        log("select value this is data:$selectedRestaurent");
                      });
                    },
                    iconColor: AppColors.cFFFFFF,
                    hintText: "Type of Establishment**",
                    borderRadius: 8.r,
                    items: categoryNames,
                    isFilled: true,
                  );
                },
              ),
              UIHelper.verticalSpace(12.h),
              GestureDetector(
                onTap: _pickAddressFromMap,
                // onTap: ,
                child: AbsorbPointer(
                  child: CustomFormField(
                    hintText: "Address*",
                    controller: _addressController,
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
                hintText: "Post Codeq**",
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
                                    width: 100.w,
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
                                    width: 100.w,
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

              GestureDetector(
                onTap: () {
                  imagePickerDialog(context, imageNotifier1);
                },
                child: ValueListenableBuilder(
                  valueListenable: imageNotifier1,
                  builder: (context, selectImage, child) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIHelper.verticalSpace(20.h),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Text(
                              "Upload Your Full Menu*",
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.c999999,
                                      fontSize: 16.sp),
                            ),
                          ),
                          UIHelper.verticalSpace(10.h),
                          selectImage != null
                              ? Center(
                                  child: ClipOval(
                                    child: Image.file(
                                      selectImage,
                                      width: 80.w,
                                      height: 80.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: SvgPicture.asset(
                                      Assets.icons.imageUpload)),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, bottom: 20.h),
                            child: Center(
                              child: Text(
                                selectImage == null
                                    ? "Upload File (PDF, JPG, PNG, DOC)"
                                    : "Tap to change image",
                                style: const TextStyle(
                                    color: Colors.white60, fontSize: 14),
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(10.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
              UIHelper.verticalSpace(10.h),
              GestureDetector(
                onTap: () {
                  imagePickerDialog(context, imageNotifier2);
                },
                child: ValueListenableBuilder(
                  valueListenable: imageNotifier2,
                  builder: (context, selectImage, child) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIHelper.verticalSpace(20.h),
                          Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Row(
                                children: [
                                  Text(
                                    "Premium Feature",
                                    style: TextFontStyle
                                        .headline10w400c6B6B6BPoppins
                                        .copyWith(
                                            color: AppColors.cFFFFFF,
                                            fontSize: 16.sp),
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  SvgPicture.asset(
                                    Assets.icons.crown,
                                    width: 24.w,
                                    height: 24.h,
                                  )
                                ],
                              )),
                          UIHelper.verticalSpace(8.h),
                          selectImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectImage,
                                    width: 80.w,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 10),
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 16.w),
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.c999999)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectImage == null
                                        ? "Showcase Your Venue"
                                        : "Tap to change image",
                                    style: TextFontStyle
                                        .headline10w400c6B6B6BPoppins
                                        .copyWith(
                                            color: AppColors.c999999,
                                            fontSize: 16.sp),
                                  ),
                                  UIHelper.verticalSpace(4.h),
                                  Text(
                                    "Upload real-time images or short videos to show the current mood and atmosphere of your venue.",
                                    style: TextFontStyle
                                        .headline10w400c6B6B6BPoppins
                                        .copyWith(
                                            color: AppColors.c999999,
                                            fontSize: 12.sp),
                                  ),
                                  UIHelper.verticalSpace(10.w),
                                  Center(
                                    child: Text(
                                      "Upload File (Venue Images, Short Video)",
                                      style: TextFontStyle
                                          .headline10w400c6B6B6BPoppins
                                          .copyWith(color: AppColors.c999999),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              )),
                          UIHelper.verticalSpace(10.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
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
              // Custom button
              CustomButton(
                textStaus: false,
                status: true,
                onTap: () {
                  userMarchentRxObj
                      .userSignup(
                          establishmentId:
                              int.parse(selectedRestaurent.toString()),
                          venueName: _venuNameController.text.toString(),
                          email: _emailController.text.toString(),
                          password: _passwordController.text.toString(),
                          confPass: _confirmPasswordController.text.toString(),
                          phone: _phoneController.text.toString(),
                          address: _addressController.text.toString(),
                          covers: imageNotifier.value,
                          menu: imageNotifier.value,
                          openHour: formatTime(fromTime),
                          closeHour: formatTime(toTime),
                          latitude: latitude.toString(),
                          longitude: longitude.toString())
                      .waitingForSucess()
                      .then((success) {
                    ToastUtil.showLongToast(
                        "Business profile registered successfully");
                    NavigationService.navigateToReplacement(
                        Routes.loginMerchantScreen);
                  });
                  // NavigationService.navigateToReplacement(
                  //     Routes.succeessScreen);

                  // _registerValidator();
                  // NavigationService.navigateToWithArgs(Routes.verifyOtpRoute, {
                  //   "email": _emailController.text.trim(),
                  // });
                },
                btnName: "Register",
              ),
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

class UpdateMenuDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context, listen: false);
    final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

    return Dialog(
        backgroundColor: AppColors.c282828,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Container(
          width: 364.w,
          decoration: ShapeDecoration(
            color: AppColors.c282828,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  NavigationService.goBack;
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.only(top: 15.h, right: 16.w),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.cFFFFFF)),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.cFFFFFF,
                      )),
                ),
              ),
              Text(
                'Update your Menu',
                style: TextFontStyle.headline10w400c6B6B6BPoppins
                    .copyWith(color: AppColors.cFFFFFF, fontSize: 20.sp),
              ),
              UIHelper.verticalSpace(16.h),
              GestureDetector(
                onTap: () {
                  imagePickerDialog(context, imageNotifier);
                },
                child: ValueListenableBuilder<File?>(
                  valueListenable: imageNotifier,
                  builder: (context, selectImage, child) {
                    return Container(
                      margin: EdgeInsets.all(16.h),
                      width: double.infinity,
                      padding: EdgeInsets.all(16.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF535353),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          imagePickerDialog(context, imageNotifier);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upload Your Full Menu",
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                      color: AppColors.c999999,
                                      fontSize: 16.sp),
                            ),
                            UIHelper.verticalSpace(8.h),
                            Center(
                                child: selectImage == null
                                    ? SvgPicture.asset(Assets.icons.imageUpload)
                                    : Image.file(
                                        (selectImage),
                                        width: 100.w,
                                        height: 100.h,
                                      ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              UIHelper.verticalSpace(32.h),
              Row(
                children: [
                  UIHelper.horizontalSpace(16.w),
                  Expanded(
                    child: CustomButton(
                        textStaus: false,
                        status: false,
                        onTap: () {
                          NavigationService.goBack;
                        },
                        btnName: "Cancel"),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(
                    child: CustomButton(
                        textStaus: false,
                        status: true,
                        onTap: () {
                          provider.setSelectedImage(imageNotifier.value);
                          NavigationService.goBack;
                        },
                        btnName: "Update"),
                  ),
                  UIHelper.horizontalSpace(16.w)
                ],
              ),
              UIHelper.verticalSpace(20.h)
            ],
          ),
        ));
  }
}
