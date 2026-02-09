import 'dart:developer';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:provider/provider.dart';
import '../../../../../common_widget/custom_button.dart';
import '../../../../../constants/text_font_style.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../helpers/ui_helpers.dart';
import '../../../../../provider/upload_profile_picture_provider.dart';

class UploadProfilePictureDialog extends StatelessWidget {
  const UploadProfilePictureDialog({super.key});

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<UploadProfilePictureProvider>(context, listen: false);
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
              // Cross Icon For Pop up
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
              Container(
                margin: EdgeInsets.all(16.h),
                width: double.infinity,
                padding: EdgeInsets.all(16.h),
                decoration: ShapeDecoration(
                  color: const Color(0xFF535353),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Your Full Menu",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.c999999, fontSize: 16.sp),
                    ),
                    UIHelper.verticalSpace(8.h),

                    /// Image Picker
                    ///
                    ///
                    ///
                    Consumer<UploadProfilePictureProvider>(
                        builder: (_, provider, child) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            provider.pickImage();
                          },
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundImage: provider.imageFile != null
                                ? FileImage(
                                    File(
                                      provider.imageFile!.path,
                                    ),
                                  )
                                : null,
                            child: provider.imageFile == null
                                ? SvgPicture.asset(
                                    Assets.icons.imageUpload,
                                    fit: BoxFit.cover,
                                    width: 80.w,
                                    height: 80.h,
                                  )
                                : null,
                          ),
                        ),
                      );
                    })
                  ],
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
                          provider.imageFile = null;
                        },
                        btnName: "Cancel"),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(
                    child: CustomButton(
                        textStaus: false,
                        status: true,
                        onTap: () {
                         
                          // Check if image file is selected else show error message.
                           if (provider.imageFile != null) {
                             // Upload Image Here
                             // After Upload, Update the image file path in Provider.
                             provider.imageFile = null;
                             provider.isUpdated = true;
                                   log("Selected avatar file: ${provider.imageFile?.path}");

                             NavigationService.goBack;
                           }

                           else {
                            ToastUtil.showShortToast('Please Selected an Image');
                           }
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
