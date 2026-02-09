import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class HomeMapWidget extends StatelessWidget {
  const HomeMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment
      //     .center, // Ensures the container is positioned correctly
      children: [
        Positioned.fill(
          child: Image.asset(
            Assets.images.mapDemo.path,
            fit: BoxFit.cover,
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: MapScreenDetailWidget(),
        ),
      ],
    );
  }
}

class MapScreenDetailWidget extends StatelessWidget {
  const MapScreenDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.navigateTo(Routes.homeTileDetailsScreen),
      child: Column(
        children: [
          UIHelper.verticalSpace(360.h),
          Container(
            constraints: const BoxConstraints(),
            width: double.maxFinite,
            padding: EdgeInsets.all(16.sp),
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.cE8E8E8,
              borderRadius: BorderRadius.circular(8.r),
              border: const Border(
                left: BorderSide(color: AppColors.cFE5401),
                top: BorderSide(width: 5, color: AppColors.cFE5401),
                right: BorderSide(color: AppColors.cFE5401),
                bottom: BorderSide(color: AppColors.cFE5401),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.images.placeholderImage.path),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 3, color: const Color(0xFFFFC900)),
                  ),
                ),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('The Capital Grille',
                          style: TextFontStyle.headline18w600CFFFFFFPoppins
                              .copyWith(
                            color: AppColors.c222222,
                          )),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Happy hour',
                            style: TextFontStyle.headline12w400C999999Poppins),
                        TextSpan(
                            text: ' • ',
                            style: TextFontStyle.headline16w700c222222Poppins),
                        TextSpan(
                            text: '24 km',
                            style: TextFontStyle.headline12w400C999999Poppins),
                      ])),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.calendar),
                          Text('Friday to Monday',
                              style:
                                  TextFontStyle.headline12w400C999999Poppins),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.clock,
                            fit: BoxFit.cover,
                            height: 20.sp,
                          ),
                          Text('7:00 AM - 8:00 PM',
                              style:
                                  TextFontStyle.headline12w400C999999Poppins),
                        ],
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: AppColors.cFE5401,
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                )
              ],
            ), // Add content to define its size
          ),
        ],
      ),
    );
  }
}
