import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';

class TestingAppBar extends StatelessWidget {
  final double height;
  final String titile;
  final bool isBack;

  final String? discription;
  // final String

  const TestingAppBar({
    super.key,
    this.height = 70,
    required this.titile,
    this.discription,
    this.isBack = true,
  });

  Size get preferredSize => Size.fromHeight(height.h);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              Assets.images.placeholderImage.path,
            ),

            Positioned(
              left: 16.w,
              top: 45.h,
              child: InkWell(
                onTap: () {
                  NavigationService.goBack;
                },
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  padding: EdgeInsets.all(4.sp),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cFFFFFF,
                  ),
                  child: Icon(
                    Platform.isAndroid
                        ? Icons.arrow_back
                        : Icons.arrow_back_ios,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 50.h,
              child: Center(
                child: Text(
                  titile,
                ),
              ),
            ),

            Positioned.fill(
              top: 90.h,
              left: 16.w,
              child: const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
            ),

            // Positioned.fill(
            //   top: 40.h,
            //   left: 16.w,
            //   right: 16.w,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           isBack
            //               ? GestureDetector(
            //                   onTap: () {
            //                     NavigationService.goBack;
            //                   },
            //                   child: Container(
            //                     height: 32.h,
            //                     width: 32.w,
            //                     padding: EdgeInsets.all(10.sp),
            //                     decoration: const BoxDecoration(
            //                         color: AppColors.cFFFFFF,
            //                         shape: BoxShape.circle),
            //                     child: Center(
            //                       child: SvgPicture.asset(
            //                         Assets.icons.backIcon,
            //                         // height: 20.w,
            //                         // width: 20.w,
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               : SizedBox(
            //                   height: 32.h,
            //                   width: 32.w,
            //                 ),
            //           Text(
            //             titile,
            //             style: TextFontStyle.headline20w600C222222Poppins,
            //           ),
            //           SizedBox(
            //             height: 32.h,
            //             width: 32.h,
            //           )
            //         ],
            //       ),
            //       UIHelper.verticalSpace(12.h),
            //       Text(discription ?? '')
            //     ],
            //   ),
            // ),

            // const Positioned(
            //   left: 0,
            //   right: 0,
            //   top: 30,
            //   child: Center(child: Text("Booking")),
            // )
            // Positioned(
            //   top: 60.h,
            //   right: 16.w,
            //   child: GestureDetector(
            //     onTap: () {
            //      /// NavigationService.navigateTo(Routes.notificationRoute);
            //     },
            //     child: StreamBuilder(
            //       stream: getNotificationResponseRX.getNotificationStream,
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return SvgPicture.asset(
            //             Assets.icons.notificationWithoutBadge,
            //             height: 20.h,
            //             width: 20.w,
            //           );
            //         } else if (snapshot.hasData) {
            //           NotificationResponse response = snapshot.data!;
            //           if (response.data!.isEmpty) {
            //             return SvgPicture.asset(
            //               Assets.icons.notificationWithoutBadge,
            //               height: 20.h,
            //               width: 20.w,
            //             );
            //           } else {
            //             return SvgPicture.asset(
            //               Assets.icons.notification,
            //               height: 20.h,
            //               width: 20.w,
            //             );
            //           }
            //         }
            //         return SvgPicture.asset(
            //           Assets.icons.notificationIcon,
            //           height: 20.h,
            //           width: 20.w,
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // StreamBuilder(
            //   stream: getFollowedMasjidResponseRXObj.getFollowedMasjidStream,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const SizedBox.shrink();
            //     } else if (snapshot.hasData) {
            //       FollowedMasjidResponse response = snapshot.data;
            //       return Positioned(
            //         left: 0,
            //         right: 0,
            //         top: 90.h,
            //         child: Text(
            //           "${"You are following".tr} ${response.data?.length} ${'Masjids'.tr}",
            //           textAlign: TextAlign.center,
            //           style: TextFontStyle.headline16w400C161C24.copyWith(
            //             color: AppColors.cffffff.withOpacity(0.69),
            //           ),
            //         ),
            //       );
            //     } else {
            //       return const SizedBox.shrink();
            //     }
            //   },
            // ),
          ],
        ));
  }
}
