// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';

import '../gen/colors.gen.dart';

final class CustomFormField extends StatelessWidget {
  final String? hintText;
  final double? hintFontSize;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final double? fieldHeight;
  final int? maxline;
  final String? Function(String?)? validator;
  final bool? validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isObsecure;
  final bool isPass;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool? isEnabled;
  final double? cursorHeight;
  final Color? disableColor;
  final Color? borderCOlor;
  final bool isRead;
  final bool? hintSatus;
  final bool? noBorder;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool? foucusColor;

  const CustomFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.inputType,
    this.fieldHeight,
    this.maxline,
    this.validator,
    this.validation = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintSatus = false,
    this.isObsecure = false,
    this.isPass = false,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.labelStyle,
    this.isEnabled,
    this.style,
    this.cursorHeight,
    this.disableColor,
    this.isRead = false,
    this.borderRadius,
    this.padding,
    this.hintFontSize,
    this.fillColor,
    this.noBorder,
    this.contentPadding,
    this.borderCOlor,
    this.foucusColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        readOnly: isRead,
        cursorHeight: cursorHeight ?? 20.h,
        cursorColor: AppColors.c222222,
        focusNode: focusNode,
        obscureText: isPass ? isObsecure : false,
        textInputAction: textInputAction,
        autovalidateMode: validation!
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        validator: validator,
        maxLines: maxline ?? 1,
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        enabled: isEnabled,
        decoration: InputDecoration(
          contentPadding: contentPadding ?? EdgeInsets.all(16.sp),
          filled: true,
          fillColor: fillColor ?? AppColors.c282828,
          isDense: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: prefixIcon,
                )
              : null,
          hintText: hintText,
          hintStyle: labelStyle ??
              TextFontStyle.headline16w400CFFFFFFPoppins.copyWith(
                fontSize: hintFontSize ?? 14.sp,
                color: AppColors.c999999,
              ),
          labelText: labelText,
          errorStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            // color: AppColors.cD12E34,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: AppColors.cFF7A01,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color:
                  foucusColor == true ? Colors.transparent : AppColors.cFFFFFF,
              width: 0.5.w,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: const BorderSide(
              // color: disableColor ?? AppColors.c6D6D6D.withOpacity(0.19),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: AppColors.cFFFFFF,
              width: 0.5.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
              color:
                  foucusColor == true ? Colors.transparent : AppColors.cFFFFFF,
              width: 0.5.w,
            ),
          ),
        ),
        style: style ??
            TextFontStyle.headline14w400c666666Poppins.copyWith(
                fontSize: hintFontSize ?? 14.sp, color: AppColors.cFFFFFF),
        keyboardType: inputType,
      ),
    );
  }
}
