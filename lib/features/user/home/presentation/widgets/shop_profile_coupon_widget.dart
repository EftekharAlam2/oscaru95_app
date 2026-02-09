import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class ShopProfileCouponWidget extends StatelessWidget {
  const ShopProfileCouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.sp),
          margin: EdgeInsets.all(30.sp),
          decoration: BoxDecoration(
              color: AppColors.c282828,
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Seasonal Offer Name",
                  style: TextFontStyle.headline16w400CFFFFFFPoppins),
              Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 5,
                spacing: 5,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.calendar,
                            color: AppColors.cFE5401,
                            height: 20.h,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.horizontalSpace(5.w),
                          Text("1/12/25 to 2/12/25",
                              style: TextFontStyle.headline12w400c6B6B6BPoppins
                                  .copyWith(color: AppColors.cFFFFFF)),
                        ],
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.clock,
                            color: AppColors.cFE5401,
                            height: 20.h,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.horizontalSpace(5.w),
                          Text("7:00 AM - 8:00 PM",
                              style: TextFontStyle.headline12w400c6B6B6BPoppins
                                  .copyWith(color: AppColors.cFFFFFF)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.icons.dollarCircle,
                        color: AppColors.cFE5401,
                        height: 20.h,
                        fit: BoxFit.cover,
                      ),
                      UIHelper.horizontalSpace(5.w),
                      Text("7:00 AM - 8:00 PM",
                          style: TextFontStyle.headline12w400c6B6B6BPoppins
                              .copyWith(color: AppColors.cFFFFFF)),
                    ],
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                  textAlign: TextAlign.start,
                  "Join us for our Autumn Happy Hour! Enjoy delightful seasonal cocktails and warm appetizers every Friday from 5 PM to 7 PM. Celebrate the flavors of fall with our signature spiced apple cider and pumpkin-infused treats. Don't miss out on the cozy vibes and great company!",
                  style: TextFontStyle.headline12w400c6B6B6BPoppins)
            ],
          ),
        ),
      ],
    );
  }
}
