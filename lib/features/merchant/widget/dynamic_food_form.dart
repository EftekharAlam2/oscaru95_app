import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/common_widget/card.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_dropdown_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/registration/model/add_item_model.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class DynamicFoodForm extends StatefulWidget {
  final VoidCallback onAddDrink;
  final List<Map<String, dynamic>> availability;
  final Function(int, bool) onSelectAvailability;
  final Function(int, TimeOfDay) onFromTimeChanged;
  final Function(int, TimeOfDay) onToTimeChanged;

  const DynamicFoodForm({
    super.key,
    required this.onAddDrink,
    required this.availability,
    required this.onSelectAvailability,
    required this.onFromTimeChanged,
    required this.onToTimeChanged,
  });

  @override
  State<DynamicFoodForm> createState() => _DynamicFoodFormState();
}

class _DynamicFoodFormState extends State<DynamicFoodForm> {
  List<DrinkItem> drinkItems = [];
  String? selectTitle;
  String? selectCusin;
  List<String> categories = ["Bar", "Restaurant", "Café"];
  @override
  void initState() {
    getCategoriesRxObj.getCategories();
    getCusinRxObj.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpace(35.h),
        StreamBuilder(
          stream: getCategoriesRxObj.getCategory,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var model = snapshot.data?.data;

            if (model == null || model.isEmpty) {
              return const Text("No categories available");
            }

            selectTitle ??= model.isNotEmpty ? model.first.id.toString() : null;

            List<String> categoryNames =
                model.map<String>((category) => category.title ?? '').toList();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              child: CustomDropdownButton(
                selectedValue: selectTitle,
                onChanged: (value) {
                  setState(() {
                    selectTitle = model
                        .firstWhere((category) => category.title == value)
                        .id
                        .toString();
                    log("select value this is data:$selectTitle");
                  });
                },
                iconColor: AppColors.cFFFFFF,
                hintText: "Special Title*",
                borderRadius: 8.r,
                items: categoryNames,
                isFilled: true,
              ),
            );
          },
        ),
        UIHelper.verticalSpace(8.h),
        Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              minLines: null,
              style: TextFontStyle.headline10w400c6B6B6BPoppins,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "    Special Description",
                  hintStyle: TextFontStyle.headline10w400c6B6B6BPoppins
                      .copyWith(color: AppColors.c6B6B6B, fontSize: 14.sp)),
            )),
        ...List.generate(drinkItems.length, (index) {
          return _buildFoodConainer(index);
        }),
        UIHelper.verticalSpace(16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: CustomButton(
            status: false,
            onTap: _addNewDrink,
            btnName: " + Add More Drinks",
            fontSize: 14.sp,
          ),
        ),
        UIHelper.verticalSpace(48.h),
        _buildAvailabilitySection(),
        Padding(
          padding: EdgeInsets.all(30.w),
          child: CustomButton(
            onTap: _saveDrinkData,
            btnName: "Save",
            textStaus: false,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodConainer(int index) {
    var drinkItem = drinkItems[index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
      padding: EdgeInsets.all(16.h),
      decoration: ShapeDecoration(
        color: AppColors.c282828,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: getCusinRxObj.getCategory,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              var model = snapshot.data?.data;

              if (model == null || model.isEmpty) {
                return const Text("No categories available");
              }

              selectCusin ??=
                  model.isNotEmpty ? model.first.id.toString() : null;

              List<String> categoryNames = model
                  .map<String>((category) => category.title ?? '')
                  .toList();

              return CustomDropdownButton(
                selectedValue: selectCusin,
                onChanged: (value) {
                  setState(() {
                    selectCusin = model
                        .firstWhere((category) => category.title == value)
                        .id
                        .toString();
                    log("select value this is data:$selectCusin");
                  });
                },
                iconColor: AppColors.cFFFFFF,
                hintText: "cuisine*",
                borderRadius: 8.r,
                items: categoryNames,
                isFilled: true,
              );
            },
          ),
          UIHelper.verticalSpace(8.h),
          CustomFormField(
            hintText: "Dish name*",
            borderCOlor: AppColors.cFFFFFF,
            onChanged: (value) {
              drinkItem.itemLists?[0].name = value;
            },
          ),
          UIHelper.verticalSpace(8.h),
          Row(
            children: [
              Expanded(
                child: CustomFormField(
                  hintText: "Regular Price*",
                  borderCOlor: AppColors.cFFFFFF,
                  onChanged: (value) {
                    drinkItem.itemLists?[0].regularPrice =
                        double.tryParse(value) ?? 0;
                  },
                ),
              ),
              UIHelper.horizontalSpace(8.w),
              Expanded(
                child: CustomFormField(
                  hintText: "Offer Price*",
                  borderCOlor: AppColors.cFFFFFF,
                  onChanged: (value) {
                    drinkItem.itemLists?[0].offerPrice =
                        double.tryParse(value) ?? 0;
                  },
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          CustomFormField(
            hintText: "Ingredients",
            borderCOlor: AppColors.cFFFFFF,
            onChanged: (value) {
              drinkItem.itemLists?[0].ingredients = value;
            },
          ),
        ],
      ),
    );
  }

  void _addNewDrink() {
    setState(() {
      drinkItems.add(DrinkItem(
        categoryId: 0,
        type: selectTitle,
        itemLists: [
          ItemList(
            cuisineId: 0,
            name: "",
            regularPrice: 0,
            offerPrice: 0,
            ingredients: "",
          )
        ],
        itemHours: [],
      ));
    });
  }

  void _saveDrinkData() async {
    if (selectTitle == null) {
      ToastUtil.showLongToast("Please select a special title.");
      return;
    }

    List<Map<String, dynamic>> itemList = drinkItems.map((item) {
      return {
        'cuisine_id': int.parse(selectCusin ?? "0"),
        'name': item.itemLists?[0].name ?? '',
        'regular_price': (item.itemLists?[0].regularPrice ?? 0.0).toString(),
        'offer_price': (item.itemLists?[0].offerPrice ?? 0.0).toString(),
        'ingredients': item.itemLists?[0].ingredients ?? '',
      };
    }).toList();

    List<Map<String, dynamic>> itemHours =
        widget.availability.map((availability) {
      String formatTime(TimeOfDay time) {
        DateTime dateTime = DateTime(2023, 1, 1, time.hour, time.minute);
        return DateFormat("H:mm").format(dateTime);
      }

      return {
        'day': availability["day"].toString(),
        'is_closed': !(availability["selected"] ?? false),
        'open_time': availability["from"] != null
            ? formatTime(availability["from"])
            : "",
        'close_time':
            availability["to"] != null ? formatTime(availability["to"]) : "",
      };
    }).toList();

    log("Request Data: ${jsonEncode({
          "category_id": selectTitle,
          "type": "food",
          "item_lists": itemList,
          "item_hours": itemHours,
        })}");

    try {
      final result = await addItemRxObj
          .itemPost(
            categoryId: int.parse(selectTitle ?? '0'),
            type: "food",
            itemList: itemList,
            itemHours: itemHours,
          )
          .waitingForSucess()
          .then((success) {
        ToastUtil.showShortToast("Item successfully added!");
        NavigationService.navigateToReplacement(
            Routes.merchantFoodSpecialScreen);
      });

      log("Response Data: ${jsonEncode(result)}");
    } catch (e) {
      log("Error adding item: $e");
      ToastUtil.showLongToast("Failed to add item. Please try again.");
    }
  }

  Widget _buildAvailabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            "Times when available*",
            style: TextFontStyle.headline10w400c6B6B6BPoppins.copyWith(
              color: AppColors.cFFFFFF,
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(
          height: 500.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            itemCount: widget.availability.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: AvailabilityCard(
                  day: widget.availability[index]["day"],
                  isSelected: widget.availability[index]["selected"],
                  fromTime: widget.availability[index]["from"],
                  toTime: widget.availability[index]["to"],
                  onSelected: (value) =>
                      widget.onSelectAvailability(index, value!),
                  onFromTimeChanged: (time) =>
                      widget.onFromTimeChanged(index, time),
                  onToTimeChanged: (time) =>
                      widget.onToTimeChanged(index, time),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
