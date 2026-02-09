
import 'package:flutter/material.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomRangeSliderWidget extends StatelessWidget {
  final RangeValues values;
  final double max;
  final Function(RangeValues) onChanged;

  const CustomRangeSliderWidget({
    super.key,
    required this.values,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: AppColors.cFFFFFF,
      inactiveColor: AppColors.c9C9C9C,
      values: values,
      max: max,
      labels: RangeLabels(
        values.start.round().toString(),
        values.end.round().toString(),
      ),
      onChanged: onChanged,
    );
  }
}
