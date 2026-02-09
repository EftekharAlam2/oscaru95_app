import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_network_image.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class CustomVenueInfoHeading extends StatelessWidget {
  final String url;
  final String name;
  final String shop;
  final String location;
  final String number;
  final String email;
  final String durationtitile;
  final String duration;

  const CustomVenueInfoHeading({
    super.key,
    required this.url,
    required this.name,
    required this.shop,
    required this.location,
    required this.number,
    required this.email,
    required this.durationtitile,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNetworkImageWidget(
          width: 134.w,
          height: 134.w,
          urls: url,
        ),
        UIHelper.verticalSpace(4.h),
        Text(
          name,
          style: TextFontStyle.headline22w400C222222Poppins,
        ),
        UIHelper.verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.barIcon),
            UIHelper.horizontalSpace(4.h),
            Text(
              shop,
              style: TextFontStyle.headline14w400c99999Poppins,
            ),
            UIHelper.horizontalSpace(16.w),
            SvgPicture.asset(Assets.icons.locationGraish),
            Text(
              location,
              style: TextFontStyle.headline14w400c99999Poppins,
            )
          ],
        ),
        UIHelper.verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.callingIcon),
            UIHelper.horizontalSpace(4.h),
            Text(
              number,
              style: TextFontStyle.headline14w400c99999Poppins,
            ),
          ],
        ),
        UIHelper.verticalSpace(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.sms),
            UIHelper.horizontalSpace(4.h),
            Text(
              email,
              style: TextFontStyle.headline14w400c99999Poppins,
            ),
          ],
        ),
        UIHelper.verticalSpace(8.h),
        Row(
          children: [
            Expanded(
              child: Text(
                durationtitile,
                style: TextFontStyle.headline14w400c99999Poppins,
                overflow: TextOverflow.clip,
              ),
            ),
            Text(
              duration,
              style: TextFontStyle.headline14w400c99999Poppins,
            ),
          ],
        ),
      ],
    );
  }
}
