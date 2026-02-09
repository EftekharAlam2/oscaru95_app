import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_network_image.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class HomeListTileWidget extends StatefulWidget {
  const HomeListTileWidget(
      {super.key,
      this.name,
      this.locationAddress,
      this.img,
      this.distance,
      this.onFavTap,
      required this.isFav,
      this.resturentType,
      this.ratting,
      this.totalReview,
      this.onNextTap,
      this.happyHourTime,
      required this.id});
  final String? name;
  final String? id;
  final String? locationAddress;
  final String? img;
  final String? resturentType;
  final String? ratting;
  final String? totalReview;
  final VoidCallback? onNextTap;
  final String? happyHourTime;
  final String? distance;
  final VoidCallback? onFavTap;
  final bool isFav;

  @override
  State<HomeListTileWidget> createState() => _HomeListTileWidgetState();
}

class _HomeListTileWidgetState extends State<HomeListTileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("this is id found:${widget.id}");

        NavigationService.navigateToWithArgs(Routes.homeTileDetailsScreen, {
          "id": widget.id??"",
          "image": widget.img??"",
          "title": widget.name??"",
          "type": widget.resturentType??"",
          "location": widget.locationAddress??"",
          "isWishlisted":widget.isFav,
          "distance":widget.distance
        });
      },
      // onTap: () => NavigationService.navigateTo(Routes.homeTileDetailsScreen),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.c282828,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  child: CustomNetworkImageWidget(
                    status: true,
                    urls: widget.img ?? "",
                    height: 166.h,
                    width: double.infinity,
                  ),
                  // child: Image.asset(
                  //   img ?? "",
                  //   height: 166.h,
                  //   width: double.infinity,
                  //   fit: BoxFit.fitWidth,
                  // ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  // right: -180.w,
                  child: InkWell(
                    onTap: widget.onFavTap,
                    child: CircleAvatar(
                      backgroundColor: AppColors.cFFFFFF,
                      child: widget.isFav
                          ? SvgPicture.asset(
                              Assets.icons.heartBoldIcon,
                              height: 24.h,
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              Assets.icons.heart,
                              height: 24.h,
                              fit: BoxFit.cover,
                              color: AppColors.c222222,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.resturentType ?? "Asian",
                        style: TextFontStyle.headline12w400C999999Poppins,
                      ),
                      SvgPicture.asset(
                        Assets.icons.crown,
                        height: 16.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(5.h),
                  Text(
                    widget.name ?? "The Capital Grille",
                    style: TextFontStyle.headline16w600CFFFFFFPoppins,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Wrap(
                    spacing: 5.w, // Space between items
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.icons.location,
                            height: 16.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              widget.locationAddress ?? "Catalunya, Barcelona",
                              style: TextFontStyle.headline12w400C999999Poppins,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(" • ",
                              style:
                                  TextFontStyle.headline12w400C999999Poppins),
                          Text(widget.distance ?? "30 km",
                              style:
                                  TextFontStyle.headline12w400C999999Poppins),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(" • ",
                              style:
                                  TextFontStyle.headline12w400C999999Poppins),
                          SvgPicture.asset(
                            Assets.icons.star,
                            height: 14.h,
                            fit: BoxFit.cover,
                          ),
                          Text(widget.ratting ?? "4.5",
                              style: TextFontStyle.headline12w600cBABABAPoppins
                                  .copyWith(color: AppColors.c999999)),
                          Text("( ${widget.totalReview ?? "12"})",
                              style:
                                  TextFontStyle.headline12w400C999999Poppins),
                        ],
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          color: AppColors.c484848,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Happy Hour',
                                style: TextFontStyle
                                    .headline12w500c0E0E0EPoppins
                                    .copyWith(color: AppColors.cFFFFFF)),
                            Text(
                                '(${widget.happyHourTime ?? "Friday to Monday 7:00 AM - 8:00 PM"})',
                                style: TextFontStyle
                                    .headline10w400c6B6B6BPoppins
                                    .copyWith(
                                        color: AppColors.c999999,
                                        fontSize: 8.sp)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onNextTap ??
                            () => NavigationService.navigateTo(
                                Routes.homeTileDetailsScreen),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.cFE5401,
                          child: Icon(
                            CupertinoIcons.arrow_right,
                            color: AppColors.cFFFFFF,
                          ),
                        ),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
