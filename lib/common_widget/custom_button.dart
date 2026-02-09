import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnName;
  final double? width;
  final double? height;
  final bool? status;
  final bool? textStaus;
  final bool? borderBg;
  final double? fontSize;
  final Color? textColor;
  final EdgeInsetsGeometry? margin;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.btnName,
    this.width,
    this.height,
    this.margin,
    this.status = true,
    this.borderBg = true,
    this.fontSize,
    this.textStaus = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        width: width ?? double.maxFinite,
        height: height ?? 59.h,
        clipBehavior: Clip.antiAlias,
        decoration: status == true
            ? ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-1, 0.01),
                  end: Alignment(1.00, -0.01),
                  colors: [Color(0xFFFE8400), Color(0xFFFE5401)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.scaffoldColor,
                border: Border.all(
                    color: borderBg == false
                        ? AppColors.cFFFFFF
                        : AppColors.cFE9900,
                    width: borderBg == false ? 0.5 : 1)),
        child: Center(
          child: Text(
            btnName,
            style: TextFontStyle.headline18w600CFFFFFFPoppins.copyWith(
                color:
                    textStaus == true ? AppColors.cFE5401 : AppColors.cFFFFFF,
                fontSize: fontSize),
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     alignment: Alignment.center,
    //     height: height ?? 50.h,
    //     width: width ?? double.maxFinite,
    //     decoration: BoxDecoration(
    //       color: AppColors.c003925,
    //       borderRadius: BorderRadius.circular(12.r),
    //     ),
    // child:
    //   ),
    // );
  }
}
