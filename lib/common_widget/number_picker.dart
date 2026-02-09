import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {super.key, required this.controller, this.prefixIconOnChanged});

  final TextEditingController controller;
  final void Function(CountryCode)? prefixIconOnChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextFontStyle.headline14w400c666666Poppins
          .copyWith(fontSize: 14.sp, color: AppColors.cFFFFFF),
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        // fillColor: AppColors.primaryColor,
        filled: true,
        fillColor: AppColors.c282828,
        hintText: "Enter Number",
        hintStyle: TextFontStyle.headline16w400CFFFFFFPoppins.copyWith(
          fontSize: 14.sp,
          color: AppColors.c999999,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.r)),
        prefixIcon: CountryCodePicker(
            onChanged: prefixIconOnChanged,
            initialSelection: 'US',
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            showFlag: true,
            showFlagDialog: true,
            alignLeft: false,
            padding: EdgeInsets.all(8.sp),
            textStyle: TextFontStyle.headline12w400C999999Poppins),
      ),
    );
  }
}
