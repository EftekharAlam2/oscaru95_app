// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class CustomImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
    final ValueNotifier<File?> imageNotifier1 = ValueNotifier<File?>(null);

    return Consumer<OfferProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                imagePickerDialog(context, imageNotifier);
              },
              child: ValueListenableBuilder(
                valueListenable: imageNotifier,
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
                                    color: AppColors.c999999, fontSize: 16.sp),
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
                                child:
                                    SvgPicture.asset(Assets.icons.imageUpload)),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, bottom: 20.h),
                          child: Center(
                            child: Text(
                              provider.selectedFile == null
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
                imagePickerDialog(context, imageNotifier1);
              },
              child: ValueListenableBuilder(
                valueListenable: imageNotifier1,
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
                                  provider.selectpreimumImage == null
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
          ],
        );
      },
    );
  }
}
