// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';
import 'package:oscaru95/gen/colors.gen.dart';

class CustomToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toggleProvider = Provider.of<OfferProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.c1A1A1A,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withOpacity(0.3.w)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Seasonal Offer",
            style: TextStyle(
              color: toggleProvider.isSeasonalOffer ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Switch(
            value: toggleProvider.isSeasonalOffer,
            activeColor: Colors.white,
            activeTrackColor: AppColors.allPrimaryColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade700,
            onChanged: (value) {
              toggleProvider.toggleOffer();
            },
          ),
          Text(
            "Special Event",
            style: TextStyle(
              color: toggleProvider.isSeasonalOffer ? Colors.grey : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
