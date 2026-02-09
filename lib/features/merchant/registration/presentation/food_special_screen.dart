import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/title.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/widget/dynamic_food_form.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class FoodSpecialScreen extends StatefulWidget {
  final bool? status;
  const FoodSpecialScreen({super.key, this.status});

  @override
  State<FoodSpecialScreen> createState() => _FoodSpecialScreenState();
}

class _FoodSpecialScreenState extends State<FoodSpecialScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OfferProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: widget.status == true
          ? AppBar(
              backgroundColor: AppColors.scaffoldColor,
              actions: [
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateToReplacement(
                        Routes.merchantNavigation);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 31.w),
                    child: Text(
                      "Skip",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(
                              color: AppColors.allPrimaryColor,
                              fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            )
          : AppBar(
              backgroundColor: AppColors.scaffoldColor,
              automaticallyImplyLeading: true,
              foregroundColor: AppColors.cFFFFFF,
              title: Text(
                "New Food Specials",
                style: TextFontStyle.headline10w400c6B6B6BPoppins
                    .copyWith(color: AppColors.cFFFFFF, fontSize: 24.sp),
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.status == true
                ? TitleWidget(
                    title: "Food Specials",
                    titleFontSize: 24.sp,
                    subtitle: "Please enter your details to create an account.",
                    subTitleFontSize: 12.sp,
                  )
                : const SizedBox.shrink(),
            DynamicFoodForm(
                onAddDrink: provider.addNewForm2,
                availability: provider.availability,
                onSelectAvailability: (index, value) {
                  provider.toggleAvailability(index, value);
                },
                onFromTimeChanged: (index, time) {
                  provider.updateFromTime(index, time);
                },
                onToTimeChanged: (index, time) {
                  provider.updateToTime(index, time);
                }),
          ],
        ),
      ),
    );
  }
}
