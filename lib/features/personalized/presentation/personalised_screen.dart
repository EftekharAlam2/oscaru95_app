import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/card.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/location_picker/presentation/location_picker_screen.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/provider/offer_provider.dart';
import 'package:provider/provider.dart';

class PersonalizedScreen extends StatefulWidget {
  const PersonalizedScreen({super.key});

  @override
  State<PersonalizedScreen> createState() => _PersonalizedScreenState();
}

class _PersonalizedScreenState extends State<PersonalizedScreen> {
  final _addressCnt = TextEditingController();
  double? latitude;
  double? longtitue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfferProvider>(context);
    var searchCnt = TextEditingController();
    final availability = provider.personalized;

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.cFFFFFF),
        title: Text(
          "Personalized Itinerary Planner",
          style: TextFontStyle.headline10w400c6B6B6BPoppins
              .copyWith(color: AppColors.cFFFFFF, fontSize: 18.sp),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, top: 20.h),
              child: Text(
                "Create your itinerary planner.",
                style: TextFontStyle.headline10w400c6B6B6BPoppins.copyWith(
                  color: AppColors.c999999,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 500.h,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                itemCount: availability.length,
                itemBuilder: (context, index) {
                  final item = availability[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: AvailabilityCard(
                      day: item["day"],
                      isSelected: item["selected"],
                      fromTime: item["from"],
                      toTime: item["to"],
                      onSelected: (value) =>
                          provider.toggleAvailability(index, value!),
                      onFromTimeChanged: (time) =>
                          provider.updateFromTime(index, time),
                      onToTimeChanged: (time) =>
                          provider.updateToTime(index, time),
                    ),
                  );
                },
              ),
            ),
            UIHelper.verticalSpace(24.h),
            GestureDetector(
              onTap: _pickAddressFromMap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                    ),
                    child: Text(
                      "Location",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.cFFFFFF, fontSize: 16.sp),
                    ),
                  ),
                  UIHelper.horizontalSpaceLarge,
                  SvgPicture.asset(Assets.icons.gps),
                  Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: Text(
                      "Use current location",
                      style: TextFontStyle.headline10w400c6B6B6BPoppins
                          .copyWith(color: AppColors.cFE5401, fontSize: 14.sp),
                    ),
                  )
                ],
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: CustomFormField(
                hintText: "Address",
                controller: _addressCnt,
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Add Filter",
                    style: TextFontStyle.headline10w400c6B6B6BPoppins
                        .copyWith(color: AppColors.cFFFFFF, fontSize: 16.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.filterScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFE5401),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.filters,
                        fit: BoxFit.cover,
                        height: 16.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(20.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: const CustomFormField(
                hintText: "Filter",
                suffixIcon: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
            ),
            UIHelper.verticalSpace(112.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: CustomButton(
                onTap: () {},
                btnName: "Build",
                textStaus: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAddressFromMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
    );

    if (result != null) {
      setState(() {
        _addressCnt.text = result["address"];
        latitude = result["latitude"];
        longtitue = result["longitude"];
      });
    }
  }
}
