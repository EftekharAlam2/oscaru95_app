import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/merchant_profile/model/menu_model.dart';
import 'package:oscaru95/features/merchant/merchant_venue_info/presentation/widget/custom_venue_info_heading.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class MerchantVenueInfo extends StatefulWidget {
  const MerchantVenueInfo({super.key});

  @override
  State<MerchantVenueInfo> createState() => _MerchantVenueInfoState();
}

class _MerchantVenueInfoState extends State<MerchantVenueInfo> {
  @override
  void initState() {
    getMenuRxObj.getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Venue Information',
          centerTitile: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColors.c282828,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.editProfileScreen);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Edit",
                      style: TextFontStyle.headline18w500CFFFFFFPoppins
                          .copyWith(color: AppColors.cFE5401),
                    ),
                  ),
                ),
                const CustomVenueInfoHeading(
                  url:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5ikmhhWhiOgcw7ITUXMHc-7EjO2J7TIsFojeuonZt6ZykyFDFgS-0kAYI6PbiYiTt8_Q&usqp=CAU',
                  name: 'Sanchez Cafe',
                  shop: 'Bar',
                  location: "Road 3, London, 1230",
                  number: '+4478978346',
                  email: 'email@gmail.com',
                  durationtitile: 'Daily Operating Hour:',
                  duration: '9:30 AM to 10:00 PM',
                )
              ],
            ),
          ),
          UIHelper.verticalSpace(32.h),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const UpdateMenuDialog(); // Show the UpdateMenuDialog
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Menu",
                  style: TextFontStyle.headline22w400C222222Poppins
                      .copyWith(color: AppColors.cFFFFFF),
                ),
                Text(
                  "Edit",
                  style: TextFontStyle.headline18w500CFFFFFFPoppins
                      .copyWith(color: AppColors.cFE5401),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(24.h),
          StreamBuilder(
              stream: getMenuRxObj.menu,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  MenuModel model = snapshot.data;
                  var image = model.data?.menu ?? "";
                  return Image.network(
                    image,
                    width: double.infinity,
                    height: 150.h,
                    fit: BoxFit.cover,
                  );
                }
                return const SizedBox.shrink();
              }),
          UIHelper.verticalSpace(32.h),
          Row(
            children: [
              Text(
                "Gallery",
                style: TextFontStyle.headline22w400C222222Poppins
                    .copyWith(color: AppColors.cFFFFFF),
              ),
              UIHelper.horizontalSpace(16.w),
              SvgPicture.asset(
                Assets.icons.crown,
                width: 24.w,
              ),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const UpdateStory(); // Show the UpdateMenuDialog
                },
              );
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.h),
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  border: Border.all(color: AppColors.cE9E9E9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SvgPicture.asset(Assets.icons.add),
                ),
              ),
            ),
          ),
        ]
            //   Consumer<VenueInformationProvider>(
            //     builder: (context, provider, child) {
            //       return GridView.builder(
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3,
            //           crossAxisSpacing: 8.w,
            //           mainAxisSpacing: 8.h,
            //           childAspectRatio: 109 / 86,
            //         ),
            //         itemCount: provider.images.length + 1,
            //         itemBuilder: (context, index) {
            //           if (index < provider.images.length) {
            //             return Container(
            //               decoration: BoxDecoration(
            //                 color: AppColors.cFFFFFF,
            //                 border: Border.all(color: AppColors.cE9E9E9),
            //                 borderRadius: BorderRadius.circular(8.r),
            //               ),
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(8.r),
            //                 child: Image.file(
            //                   File(provider.images[index].path),
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             );
            //           } else {
            //             return GestureDetector(
            //               onTap: () async {
            //                 final XFile? pickedImage = await ImagePicker()
            //                     .pickImage(source: ImageSource.gallery);
            //                 if (pickedImage != null) {
            //                   provider.addImage(pickedImage);
            //                 }
            //               },
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 30.w, vertical: 19.h),
            //                 decoration: BoxDecoration(
            //                   color: AppColors.cFFFFFF,
            //                   border: Border.all(color: AppColors.cE9E9E9),
            //                   borderRadius: BorderRadius.circular(8.r),
            //                 ),
            //                 child: ClipRRect(
            //                   borderRadius: BorderRadius.circular(8.r),
            //                   child: SvgPicture.asset(Assets.icons.add),
            //                 ),
            //               ),
            //             );
            //           }
            //         },
            //       );
            //     },
            //   )
            // ],
            ),
      ),
    );
  }
}

class UpdateMenuDialog extends StatefulWidget {
  const UpdateMenuDialog({super.key});

  @override
  State<UpdateMenuDialog> createState() => _UpdateMenuDialogState();
}

class _UpdateMenuDialogState extends State<UpdateMenuDialog> {
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
                        onTap: () async {
                          log("this is path:${imageNotifier.value}");
                          provider.setSelectedImage(imageNotifier.value);
                          if (imageNotifier.value != null) {
                            await editMenuRx
                                .editMenu(menu: imageNotifier.value!)
                                .waitingForSucess()
                                .then((success) {
                              getMenuRxObj.getMenu();
                              NavigationService.goBack;
                            }); // Use `!` to assert it's non-null
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

class UpdateStory extends StatefulWidget {
  const UpdateStory({super.key});

  @override
  State<UpdateStory> createState() => _UpdateStoryState();
}

class _UpdateStoryState extends State<UpdateStory> {
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
                ' Story',
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
                              "Upload Your Story",
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
                        onTap: () async {
                          log("this is path:${imageNotifier.value}");
                          provider.setSelectedImage(imageNotifier.value);
                          if (imageNotifier.value != null) {
                            await storyUploadrRxObj
                                .story(image: imageNotifier.value!)
                                .waitingForSucess()
                                .then((success) {
                              ToastUtil.showLongToast(
                                  "Gallery added successfully");
                              NavigationService.goBack;
                            });
                            // await editMenuRx
                            //     .editMenu(menu: imageNotifier.value!)
                            //     .waitingForSucess()
                            //     .then((success) {
                            //   getMenuRxObj.getMenu();
                            //   NavigationService.goBack;
                            // }); // Use `!` to assert it's non-null
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
