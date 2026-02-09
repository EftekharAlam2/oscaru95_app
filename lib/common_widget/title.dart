// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class TitleWidget extends StatelessWidget {
  String? title;
  String? subtitle;
  double? titleFontSize;
  double? subTitleFontSize;
  TitleWidget(
      {super.key, required this.title, this.subtitle, this.titleFontSize,this.subTitleFontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? "",
          style: TextFontStyle.headline28w600C222222Poppins
              .copyWith(color: AppColors.cFFFFFF, fontSize: titleFontSize),
        ),
        UIHelper.verticalSpace(8.sp),
        Text(
          subtitle ?? "",
          style: TextFontStyle.headline28w600C222222Poppins
              .copyWith(color: AppColors.c999999, fontSize: subTitleFontSize),
        )
      ],
    );
  }
}
