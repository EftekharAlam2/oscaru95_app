import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class MerchantDeshBoardScreen extends StatefulWidget {
  const MerchantDeshBoardScreen({super.key});

  @override
  State<MerchantDeshBoardScreen> createState() =>
      _MerchantDeshBoardScreenState();
}

class _MerchantDeshBoardScreenState extends State<MerchantDeshBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        title: Text(
          "Welcome Dashboard!",
          style: TextFontStyle.headline24w400cFFFFFFPoppins,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            CustomDashBoardWidget(
              titile: 'Food Specials',
              img: Assets.images.food.path,
              onTap: () {
                NavigationService.navigateTo(Routes.merchantFoodSpecialScreen);
              },
            ),
            UIHelper.verticalSpace(16.h),
            CustomDashBoardWidget(
              titile: 'Drink Specials',
              img: Assets.images.drink.path,
              onTap: () {
                NavigationService.navigateTo(
                    Routes.merchantDrincksSpecialScreen);
              },
            ),
            UIHelper.verticalSpace(16.h),
            CustomDashBoardWidget(
              icon: true,
              titile: 'Special Events',
              img: Assets.images.special.path,
              onTap: () {
                NavigationService.navigateTo(
                    Routes.merchantSpeacialEvantsScreen);
              },
            ),
            UIHelper.verticalSpace(16.h),
            CustomDashBoardWidget(
              icon: true,
              titile: 'Seasonal Offers',
              img: Assets.images.offers.path,
              onTap: () {
                NavigationService.navigateTo(
                    Routes.merchantSeasonalOfferScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDashBoardWidget extends StatelessWidget {
  final String titile;
  final String img;
  final VoidCallback onTap;
  final bool? icon;
  const CustomDashBoardWidget({
    super.key,
    required this.titile,
    required this.img,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24..sp),
        decoration: BoxDecoration(
            color: AppColors.c282828, borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Image.asset(
              img,
              width: 60.w,
              height: 60.w,
            ),
            UIHelper.horizontalSpace(16.w),
            Expanded(
              child: Text(
                titile,
                style: TextFontStyle.headline20w400C222222Poppins,
              ),
            ),
            if (icon ?? false)
              SvgPicture.asset(
                Assets.icons.crown,
                width: 24.w,
              ),
          ],
        ),
      ),
    );
  }
}
