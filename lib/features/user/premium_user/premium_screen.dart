import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/provider/premium_provider.dart';
import 'package:provider/provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 31.sp, vertical: 16.h),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(Assets.icons.crossIcon)),
              SvgPicture.asset(Assets.icons.crown),
              Text(
                "Upgrade to Premium!",
                style: TextFontStyle.headline24w700cFFFFFFPoppins,
              ),
              UIHelper.verticalSpace(40.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.sp),
                decoration: ShapeDecoration(
                  color: AppColors.c282828,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('💡Premium Benefits',
                        style: TextFontStyle.headline16w500c222222Poppins
                            .copyWith(color: AppColors.cFFFFFF)
                        // TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 16,
                        //     fontFamily: 'Poppins',
                        //     fontWeight: FontWeight.w500,
                        //     height: 1.64,
                        // ),
                        ),
                    Text(
                        "✅  Can subscribe to specific venues or types of deals to get alerts and notifications if anything changes or when new deals are added.",
                        style: TextFontStyle.headline14w400CFFFFFFPoppins),
                    UIHelper.verticalSpace(5.h),
                    Text(
                        "✅  Highlighted deals (Hot deals) daily based on user behavior and search history.",
                        style: TextFontStyle.headline14w400CFFFFFFPoppins),
                    UIHelper.verticalSpace(5.h),
                    Text(
                        "✅  Personalized Itinerary planner: by inputting their itinerary for the day, the app will suggest nearby dining and drinking options with relevant deals, making the dining experience seamless and integrated into the user's daily activity.",
                        style: TextFontStyle.headline14w400CFFFFFFPoppins),
                  ],
                ),
              ),
              UIHelper.verticalSpace(40.h),
              Text('Choose the Best Plan',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.headline16w500c222222Poppins
                      .copyWith(color: AppColors.cFFFFFF)),
              UIHelper.verticalSpace(24.h),
              const CustomCheckboxTile(title: "Free Plan"),
              const SizedBox(height: 20),
              const CustomCheckboxTile(title: "Premium Plan"),
              UIHelper.verticalSpace(40.h),
              CustomButton(
                textStaus: false,
                onTap: () {
                  NavigationService.navigateToReplacement(
                      Routes.registrionVenu);
                  // _registerValidator();
                  // NavigationService.navigateTo(Routes.userNavigationScreen);
                },
                btnName: "Upgrade Now",
              ),
              UIHelper.verticalSpace(40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCheckboxTile extends StatelessWidget {
  final String title;

  const CustomCheckboxTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final checkboxProvider = Provider.of<PremiumProvider>(context);

    return InkWell(
      onTap: () {
        checkboxProvider.toggleCheckbox(title);
      },
      child: Container(
        padding: EdgeInsets.all(24.sp),
        decoration: ShapeDecoration(
          color: AppColors.c282828, // Dark theme color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: checkboxProvider.isChecked(title),
                onChanged: (value) {
                  checkboxProvider.toggleCheckbox(title);
                },
                activeColor: Colors.white,
                checkColor: Colors.black,
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Makes it round
                ),
              ),
            ),
            Expanded(
              child: title == "Free Plan"
                  ? Row(
                      children: [
                        Text(title,
                            textAlign: TextAlign.center,
                            style: TextFontStyle.headline16w600CFFFFFFPoppins),
                        Text("",
                            textAlign: TextAlign.center,
                            style: TextFontStyle.headline16w600CFFFFFFPoppins),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            textAlign: TextAlign.center,
                            style: TextFontStyle.headline16w600CFFFFFFPoppins),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Per month",
                                textAlign: TextAlign.center,
                                style:
                                    TextFontStyle.headline12w400C999999Poppins),
                            Text('£4.99',
                                textAlign: TextAlign.center,
                                style: TextFontStyle
                                    .headline20w600C222222Poppins
                                    .copyWith(color: AppColors.cFFFFFF))
                          ],
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
