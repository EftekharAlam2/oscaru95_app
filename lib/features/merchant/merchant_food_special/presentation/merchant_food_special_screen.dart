import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/merchant_food_special/model/food_special_response.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class MerchantFoodSpecialScreen extends StatefulWidget {
  const MerchantFoodSpecialScreen({super.key});

  @override
  State<MerchantFoodSpecialScreen> createState() =>
      _MerchantFoodSpecialScreenState();
}

class _MerchantFoodSpecialScreenState extends State<MerchantFoodSpecialScreen> {
  @override
  void initState() {
    getFoodSpecialRx.getFoodSpecial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Food Specials',
          centerTitile: false,
        ),
      ),
      body: StreamBuilder(
        stream: getFoodSpecialRx.getFoodSpecialtream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            FoodSpecialResponse response = snapshot.data;
            return response.data!.isEmpty
                ? Center(
                    child: Text(
                    "No data found",
                    style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  ))
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: response.data!.length,
                          itemBuilder: (context, index) {
                            final data = response.data![index];
                            return Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 16.h),
                              decoration: BoxDecoration(
                                color: AppColors.c282828,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  //splashColor: Colors.transparent,
                                  dividerColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  dense: false,
                                  //collapsedBackgroundColor: Colors.transparent,

                                  iconColor: AppColors.cFFFFFF,
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  // expandedAlignment: Alignment.centerLeft,
                                  title: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 16.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.c282828,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title ?? "",
                                          style: TextFontStyle
                                              .headline18w700CFFFFFFPoppins,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Friday to Monday •  7:00 AM - 8:00 PM",
                                                style: TextFontStyle
                                                    .headline12w400C999999Poppins
                                                    .copyWith(
                                                        color:
                                                            AppColors.c969696),
                                              ),
                                            ),
                                            UIHelper.horizontalSpace(4.w),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  children: [
                                    Column(
                                      children: [
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: response
                                                .data![index].itemList!.length,
                                            itemBuilder: (context, itemIndex) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 12.h),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 8.h),
                                                decoration: BoxDecoration(
                                                  color: AppColors.c484848,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: Row(
                                                  children: [
                                                    UIHelper.horizontalSpace(
                                                        8.w),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${data.itemList?[itemIndex].name}",
                                                            style: TextFontStyle
                                                                .headline14w600C222222Poppins
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .cFFFFFF),
                                                          ),
                                                          Text(
                                                            "2 oz Tequila, 1 oz Triple Sec,1 oz Lime Juice, Salt (for rimming the glass), Ice Cubes",
                                                            style: TextFontStyle
                                                                .headline10w400c6B6B6BPoppins
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .c969696),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "\$ ${data.itemList?[itemIndex].regularPrice}",
                                                          style: TextFontStyle
                                                              .headline10w400c6B6B6BPoppins
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .c969696,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough),
                                                        ),
                                                        Text(
                                                          "\$ ${data.itemList?[itemIndex].offerPrice}",
                                                          style: TextFontStyle
                                                              .headline14w600C222222Poppins
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .cFFFFFF),
                                                        )
                                                      ],
                                                    )
                                                    // Spacer(),
                                                    // SvgPicture.asset(Assets.icons.edit2)
                                                  ],
                                                ),
                                              );
                                            }),
                                        UIHelper.verticalSpace(12.h),
                                        CustomAddButton(
                                          titile: 'Edit',
                                          ontap: () {
                                            NavigationService.navigateTo(
                                                Routes.editFoodSpecialScreen);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        UIHelper.verticalSpace(100.h),
                      ],
                    ),
                  );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: Container(
        color: AppColors.scaffoldColor,
        height: 85.h,
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h, top: 4.h),
        child: CustomAddButton(
          titile: 'Add New Food Specials',
          ontap: () {
            NavigationService.navigateToWithArgs(
                Routes.foodScreen, {"status": false});
            // NavigationService.navigateTo(Routes.foodScreen);
          },
        ),
      ),
    );
  }
}

class CustomAddButton extends StatelessWidget {
  final String titile;
  final VoidCallback ontap;
  const CustomAddButton({
    super.key,
    required this.titile,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cFE5401),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            titile,
            style: TextFontStyle.headline18w500CFFFFFFPoppins
                .copyWith(color: AppColors.cFE5401),
          ),
        ),
      ),
    );
  }
}
