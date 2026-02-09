

import 'package:flutter/material.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomStartEndingWidget extends StatelessWidget {
  final String start;
  final String ending;
  const CustomStartEndingWidget({
    super.key,
    required this.start,
    required this.ending,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          start,
          style: TextFontStyle.headline12w400C999999Poppins
              .copyWith(color: AppColors.c9C9C9C),
        ),
        Text(
          ending,
          style: TextFontStyle.headline12w400C999999Poppins
              .copyWith(color: AppColors.c9C9C9C),
        ),
      ],
    );
  }
}
