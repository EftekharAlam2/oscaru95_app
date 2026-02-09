// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';

import '../gen/colors.gen.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String? hintText;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final double borderWidth;
  final double iconSize;
  final Color? hintColor;
  final Color borderColor;
  final Color iconColor;
  final bool isFilled;
  final Color? fillColor;

  const CustomDropdownButton({
    super.key,
    required this.items,
    this.hintText,
    this.selectedValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16),
    this.borderRadius = 48.0,
    this.borderWidth = 0.5,
    this.iconSize = 24.0,
    this.borderColor = AppColors.c000000,
    this.iconColor = Colors.black45,
    this.hintColor,
    required this.isFilled,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColors.c282828,
        filled: isFilled,
        contentPadding: contentPadding,
        border: _buildBorder(borderColor.withOpacity(.5)),
        enabledBorder: _buildBorder(AppColors.cFFFFFF),
        focusedBorder: _buildBorder(borderColor, width: borderWidth + 0.5),
      ),
      hint: hintText != null
          ? Text(
              hintText!,
              style: TextFontStyle.headline16w400CFFFFFFPoppins.copyWith(
                color: hintColor ?? AppColors.c999999,
              ),
            )
          : null,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextFontStyle.headline16w400CFFFFFFPoppins
                      .copyWith(color: AppColors.c999999),
                ),
              ))
          .toList(),
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: iconColor),
        iconSize: iconSize,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.c000000),
          trackColor: WidgetStateProperty.all(Colors.grey.shade300),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 0.5}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(color: color, width: width.w),
    );
  }
}
