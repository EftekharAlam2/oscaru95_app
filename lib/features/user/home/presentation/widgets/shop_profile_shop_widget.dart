import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/profile/model/list_of_model.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class ShopProfileFoodWidget extends StatefulWidget {
  final String id;
  final String tab;

  const ShopProfileFoodWidget({super.key, required this.id, required this.tab});

  @override
  State<ShopProfileFoodWidget> createState() => _ShopProfileFoodWidgetState();
}

class _ShopProfileFoodWidgetState extends State<ShopProfileFoodWidget> {
  @override
  void initState() {
    super.initState();
    foodListRxObj.getVenu(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.w),
      child: StreamBuilder(
        stream: foodListRxObj.getDiscoverStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            FoodListModel model = snapshot.data;
            var data = model.data?.data;
            var openHour = data?.openHour ?? "";
            var closeHour = data?.closeHour ?? "";

            var openTime = DateFormat("hh:mm a")
                .format(DateFormat("HH:mm").parse(openHour));
            var closeTime = DateFormat("hh:mm a")
                .format(DateFormat("HH:mm").parse(closeHour));

            var foodItems = data?.item
                ?.where((item) => item.type == "food")
                .toList();

            if (foodItems == null || foodItems.isEmpty) {
              return Center(
                child: Text(
                  "Food not found!",
                  style: TextFontStyle.headline10w400c6B6B6BPoppins.copyWith(
                    color: AppColors.cFFFFFF,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                var category = foodItems[index];
                var title = category.title ?? "";
                var itemList = category.itemList ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: TextFontStyle
                                .headline18w500CFFFFFFPoppins
                                .copyWith(fontSize: 16.sp),
                          ),
                          TextSpan(
                            text:
                                " (Friday to Monday $openTime - $closeTime)",
                            style: TextFontStyle
                                .headline12w400C999999Poppins
                                .copyWith(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    ...itemList.map((item) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Container(
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            color: AppColors.c282828,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name ?? "",
                                      style: TextFontStyle
                                          .headline14w600CFFFFFFPoppins,
                                    ),
                                    UIHelper.verticalSpace(8.h),
                                    Text(
                                      item.ingredients ?? "",
                                      style: TextFontStyle
                                          .headline10w400c6B6B6BPoppins,
                                    ),
                                  ],
                                ),
                              ),
                              UIHelper.horizontalSpaceMedium,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$ ${item.regularPrice}",
                                    style: TextStyle(
                                      color: AppColors.c6B6B6B,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: AppColors.c6B6B6B,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${item.offerPrice}",
                                    style: TextFontStyle
                                        .headline14w600CFFFFFFPoppins,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                    UIHelper.verticalSpaceMedium,
                  ],
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
