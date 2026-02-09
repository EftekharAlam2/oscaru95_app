import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/title.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/widget/dynamic_drink_form.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class DrinkSpecialScreen extends StatefulWidget {
  final bool? status;

  const DrinkSpecialScreen({super.key, this.status});

  @override
  State<DrinkSpecialScreen> createState() => _DrinkSpecialScreenState();
}

class _DrinkSpecialScreenState extends State<DrinkSpecialScreen> {
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
                "New Drink Specials",
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
                    title: "Drink Specials",
                    titleFontSize: 24.sp,
                    subtitle: "Please enter your details to create an account.",
                    subTitleFontSize: 12.sp,
                  )
                : const SizedBox.shrink(),
            DynamicDrinkForm(
                onAddDrink: provider.addNewForm1,
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
