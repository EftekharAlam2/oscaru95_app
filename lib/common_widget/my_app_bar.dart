import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Color? foregroundColor;
  final String? backgroundImagePath;
  final String? actioIconPath;
  final VoidCallback? onTapAction;
  final bool hasDescription;
  final String? desc;
  final bool isBack;
  final bool hasBgImage;

  const MyAppBar({
    super.key,
    required this.title,
    this.height = 50,
    this.foregroundColor,
    this.backgroundImagePath,
    this.actioIconPath,
    this.onTapAction,
    this.hasDescription = false,
    this.desc,
    this.isBack = true,
    this.hasBgImage = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height.h);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          Image.asset(
            Assets.images.placeholderImage.path,
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            top: 10.h,
            bottom: 0.h,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isBack
                          ? GestureDetector(
                              onTap: () {
                                NavigationService.goBack;
                              },
                              child: Container(
                                height: 32.h,
                                width: 32.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.cFFFFFF,
                                ),
                                // child: Padding(
                                //   padding: EdgeInsets.all(8.sp),
                                //   child: SvgPicture.asset(
                                //     Assets.icons.backIcon,
                                //     width: 10.w,
                                //   ),
                                // ),
                              ),
                            )
                          : SizedBox(
                              height: 32.h,
                              width: 32.h,
                            ),
                      Text(
                        title,
                        style: TextFontStyle.headline20w600C222222Poppins,
                      ),
                      SizedBox(
                        height: 32.h,
                        width: 32.w,
                      )
                    ],
                  ),
                  hasDescription
                      ? UIHelper.verticalSpace(8.h)
                      : const SizedBox.shrink(),
                  hasDescription
                      ? Text(
                          desc ?? "Lorem ",
                          style: TextFontStyle.headline14w400c222222Poppins,
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ],
      ),
      // child: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     title,
      //     style: TextFontStyle.headline20w600C222222Poppins,
      //   ),
      //   foregroundColor: foregroundColor ?? Colors.white,
      //   elevation: 0,
      //   flexibleSpace: Image(
      //     image: AssetImage(backgroundImagePath ?? Assets.images.app_bg.path),
      //     height: 128.h,
      //     fit: BoxFit.cover,
      //   ),
      //   // actions: actioIconPath != null
      //   //     ? [
      //   //         GestureDetector(
      //   //           onTap: onTapAction,
      //   //           child: SvgPicture.asset(
      //   //             actioIconPath ?? Assets.icons.shareIcon,
      //   //           ),
      //   //         ),
      //   //         UIHelper.horizontalSpaceSmall,
      //   //       ]
      //   //     : null,
      //   leading: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: GestureDetector(
      //       onTap: () {
      //         NavigationService.goBack;
      //       },
      //       child: Container(
      //         height: 32.h,
      //         width: 32.w,
      //         padding: EdgeInsets.all(10.sp),
      //         decoration: const BoxDecoration(
      //             color: AppColors.cFFFFFF, shape: BoxShape.circle),
      //         child: Center(
      //           child: SvgPicture.asset(
      //             Assets.icons.backIcon,
      //             height: 20.w,
      //             width: 20.w,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
