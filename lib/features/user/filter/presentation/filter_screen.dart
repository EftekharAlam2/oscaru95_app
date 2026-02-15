import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:oscaru95/provider/discover_provider.dart';
import 'package:oscaru95/provider/filter_provider.dart';
import 'package:oscaru95/services/venue_storage_service.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _selectedIndex = -1;
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

  RangeValues _currentRangeValues = const RangeValues(0, 100);
  RangeValues _priceRangeValues = RangeValues(0, 100);

  List<String> availableTypes = [];
  final Set<String> _selectedTypes = {}; // allow multiple selection if needed

  @override
  void initState() {
    super.initState();
    _loadAvailableTypesFromJson();
  }

  Future<void> _loadAvailableTypesFromJson() async {
    try {
      // Try to load from storage first
      final storageService = VenueStorageService();
      String? jsonString = storageService.getStoredVenueData();
      
      // Fallback to loading from assets if not in storage
      if (jsonString == null) {
        log('Venue data not found in storage, loading from assets...');
        jsonString = await rootBundle.loadString('assets/data/nearest_shops.json');
      }
      
      final dynamic jsonData = json.decode(jsonString);
      List<dynamic> allShops = jsonData['data']['data'] as List? ?? [];
      final types = allShops.map((e) => (e['type'] ?? '').toString()).where((t) => t.isNotEmpty).toSet().toList();
      setState(() {
        availableTypes = types;
      });
    } catch (e) {
      log('Error reading nearest_shops.json: $e');
    }
  }

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
        pressClear: () {
          setState(() {
            _selectedTypes.clear();
            _selectedIndex = -1;
            _currentRangeValues = const RangeValues(0, 100);
            _priceRangeValues = const RangeValues(0, 100);
          });
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            // Types Section (derived from nearest_shops.json)
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                      'Type',
                      style: TextFontStyle.headline16w500c222222Poppins
                          .copyWith(color: AppColors.cFFFFFF),
                    ),
                  ],
                ),
                children: [
                  if (availableTypes.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text('Loading types...', style: TextFontStyle.headline14w400CFFFFFFPoppins),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: availableTypes.length,
                      itemBuilder: (context, subIndex) {
                        final subcategory = availableTypes[subIndex];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                subcategory,
                                style: TextFontStyle.headline16w500c222222Poppins
                                    .copyWith(color: AppColors.c9C9C9C),
                              ),
                              SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: Checkbox(
                                  checkColor: AppColors.c000000,
                                  activeColor: AppColors.cFFFFFF,
                                  focusColor: AppColors.cFFFFFF,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  value: _selectedTypes.contains(subcategory),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        _selectedTypes.add(subcategory);
                                      } else {
                                        _selectedTypes.remove(subcategory);
                                      }
                                      // For backward compatibility, set single selectType to first selected or null
                                      selectType = _selectedTypes.isNotEmpty ? _selectedTypes.first : null;
                                    });
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
    final provider = Provider.of<DiscoverProvider>(context, listen: false);

    // Get selected type from filter (first checkbox selected in types)
    String? selectedTypeForFilter;
    if (selectType != null && selectType!.isNotEmpty) {
      selectedTypeForFilter = selectType;
    }

    // Use distance slider values as min/max (in km)
    final minDistance = _currentRangeValues.start.toInt().toString();
    final maxDistance = _currentRangeValues.end.toInt().toString();

    await disoverFilterRxObj
        .getFilter(
          type: selectedTypeForFilter,
          days: _selectedIndex != -1 ? days[_selectedIndex] : null,
          min: minDistance,
          max: maxDistance,
          searchQuery: provider.searchQuery,
        )
        .waitingForSucess()
        .then((success) {
      NavigationService.goBack();
    });
    log("this is days:${_selectedIndex != -1 ? days[_selectedIndex] : 'None selected'}");
    log("this is selected type: $selectType");
    log("distance filter: $minDistance - $maxDistance");
  }
}
