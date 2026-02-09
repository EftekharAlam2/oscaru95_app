import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/filter/presentation/widget/custom_days_selected_widget.dart';
import 'package:oscaru95/features/user/filter/presentation/widget/custom_distance_and_price_widget.dart';
import 'package:oscaru95/features/user/filter/presentation/widget/custom_filter_app_bar_widget.dart';
import 'package:oscaru95/features/user/filter/presentation/widget/custom_range_slider_widget.dart';
import 'package:oscaru95/features/user/filter/presentation/widget/custom_start_ending_widget.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/filter_provider.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _selectedIndex = -1;
  int _typeIndex = -1;
  int _typeCousin = -1;
  String? selectType;

  List<String> days = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Friday",
    "Sat",
  ];
  List<String> type = ["food", "drink"];

  RangeValues _currentRangeValues = const RangeValues(40, 80);
RangeValues _priceRangeValues = RangeValues(0, 100);
  @override
  Widget build(BuildContext context) {
    final checkProvider = Provider.of<FilterProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomFilterAppBarWidget(
        titile: 'Filter',
        action: 'Clear All',
        pressNav: () {
          NavigationService.goBack;
        },
        pressClear: () {},
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: checkProvider.filterItems.length,
              itemBuilder: (context, index) {
                var titile = checkProvider.filterItems[index];

                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    iconColor: AppColors.cFFFFFF,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.symmetric(vertical: 3.h),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    title: Row(
                      children: [
                        SvgPicture.asset(Assets.icons.food),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          titile.category,
                          style: TextFontStyle.headline16w500c222222Poppins
                              .copyWith(color: AppColors.cFFFFFF),
                        ),
                      ],
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: titile.subcategories.length,
                        itemBuilder: (context, subIndex) {
                          var subcategory = titile.subcategories[subIndex];
                          log("this is my filter:$subcategory");

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  subcategory,
                                  style: TextFontStyle
                                      .headline16w500c222222Poppins
                                      .copyWith(color: AppColors.c9C9C9C),
                                ),
                                SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Consumer<FilterProvider>(
                                    builder: (context, provider, child) {
                                      return Checkbox(
                                        checkColor: AppColors.c000000,
                                        activeColor: AppColors.cFFFFFF,
                                        focusColor: AppColors.cFFFFFF,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        value: titile.selectedSubcategories
                                            .contains(subcategory),
                                        onChanged: (value) {
                                          _typeIndex = subIndex;
                                          _typeCousin = subIndex;
                                          provider.toggleSubcategory(
                                              titile.category, subcategory);
                                          setState(() {
                                            selectType = selectType =
                                                checkProvider.filterItems[0]
                                                    .subcategories[_typeIndex];
                                          });
                                          log("this is cusin type:$_typeCousin");
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            UIHelper.verticalSpace(24.h),
            const CustomDistanceAndPriceWidget(
              titile: "Distance",
              desciption: "From 0 km to 100 km",
            ),
            UIHelper.verticalSpace(32.h),
            CustomRangeSliderWidget(
              max: 100,
              values: _currentRangeValues,
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const CustomStartEndingWidget(
              start: '0 km',
              ending: '100 km',
            ),
            UIHelper.verticalSpace(40.h),
            const Divider(
              color: AppColors.c535353,
            ),
            UIHelper.verticalSpace(24.h),
            Row(
              children: [
                SvgPicture.asset(Assets.icons.sun),
                UIHelper.horizontalSpace(8.w),
                Text(
                  "Days",
                  style: TextFontStyle.headline16w500c222222Poppins
                      .copyWith(color: AppColors.cFFFFFF),
                )
              ],
            ),
            UIHelper.verticalSpace(16.h),
            Wrap(
                spacing: 15,
                runSpacing: 16,
                children: List.generate(
                  days.length,
                  (index) {
                    return CustomDaysSelectedWidget(
                      borderColor: _selectedIndex == index
                          ? AppColors.cFE5401
                          : AppColors.c9C9C9C,
                      days: days[index],
                      ontap: () {
                        setState(() {
                          _selectedIndex = index;
                          log("this is selected Days:${days[_selectedIndex]}");
                        });
                      },
                      textStyle: _selectedIndex == index
                          ? TextFontStyle.headline16w400CFFFFFFPoppins
                              .copyWith(color: AppColors.cFE5401)
                          : TextFontStyle.headline16w400CFFFFFFPoppins
                              .copyWith(color: AppColors.c9C9C9C),
                    );
                  },
                )),
            UIHelper.verticalSpace(24.h),
             CustomDistanceAndPriceWidget(
              titile: "Price",
              desciption: "From £0 to ${_priceRangeValues.end.toInt()}",
            ),
            UIHelper.verticalSpace(32.h),
            CustomRangeSliderWidget(
              max: 100,
              values: _priceRangeValues,
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRangeValues = values;
                });
              },
            ),
            const CustomStartEndingWidget(
              start: '£0',
              ending: '£100',
            ),
            UIHelper.verticalSpace(40.h),
            const Divider(
              color: AppColors.c535353,
            ),
            UIHelper.verticalSpace(40.h),
            CustomButton(
              onTap: () {
                discoverFilter();
              },
              btnName: "Apply",
              textStaus: false,
            ),
            UIHelper.verticalSpace(20.h)
          ],
        ),
      ),
    );
  }

  void discoverFilter() async {
    await disoverFilterRxObj
        .getFilter(type: selectType, days: days[_selectedIndex])
        .waitingForSucess()
        .then((success) {
      NavigationService.goBack;
    });
    log("this is days:${days[_selectedIndex]}");
  }
}
