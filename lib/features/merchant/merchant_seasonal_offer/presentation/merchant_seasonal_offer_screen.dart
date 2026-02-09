import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_alart_dialog_widget.dart';
import 'package:oscaru95/common_widget/custom_appbar.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/merchant_food_special/presentation/merchant_food_special_screen.dart';
import 'package:oscaru95/features/merchant/merchant_seasonal_offer/model/sessonal_offer_response.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/helpers_method.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class MerchantSeasonalOfferScreen extends StatefulWidget {
  const MerchantSeasonalOfferScreen({super.key});

  @override
  State<MerchantSeasonalOfferScreen> createState() =>
      _MerchantSeasonalOfferScreenState();
}

class _MerchantSeasonalOfferScreenState
    extends State<MerchantSeasonalOfferScreen> {
  @override
  void initState() {
    getSessonalOfferRx.getSessonalOffer();
    super.initState();
  }

  Future<void> onRefresh() async {
    await getSessonalOfferRx.getSessonalOffer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: const CustomAppbar(
          titile: 'Seasonal Offers',
          centerTitile: true,
        ),
      ),
      body: StreamBuilder(
        stream: getSessonalOfferRx.getSessonalOfferStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            SeasonalOfferResponse response = snapshot.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                shrinkWrap: true,
                itemCount: response.data!.length,
                itemBuilder: (context, index) {
                  final data = response.data![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: AppColors.c282828,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                data.name ?? "",
                                style:
                                    TextFontStyle.headline18w400CFFFFFFPoppins,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                              width: 25.w,
                              // color: AppColors.c014327,
                              // padding: EdgeInsets.zero,
                              child: Center(
                                child: PopupMenuButton(
                                  iconColor: AppColors.cFFFFFF,
                                  color: AppColors.c535353,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      NavigationService.navigateTo(
                                          Routes.editSeasonalOffersScreen);
                                    } else {
                                      // showCustomDialog(
                                      //   context: context,
                                      //   title:
                                      //       "Are you sure you want to delete this announcement?"
                                      //           .tr,
                                      //   onTapYes: () {
                                      //     NavigationService.goBack;
                                      //     deleteAnnouncementRxObj
                                      //         .deleteAnnouncementResponse(id: id)
                                      //         .then((response) async {
                                      //       if (response.code == 200) {
                                      //         await getAnnouncementsRxObj
                                      //             .getAnnouncementResponse(
                                      //                 id: masjidId);
                                      //       }
                                      //     });
                                      //   },
                                      //   onTapNo: () {
                                      //     NavigationService.goBack;
                                      //   },
                                      // );
                                      _showalartdialog();
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text(
                                          "Edit",
                                          style: TextFontStyle
                                              .headline14w400CFF7A01Poppins
                                              .copyWith(
                                                  color: AppColors.cBCBCBC),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text(
                                          "Delete",
                                          style: TextFontStyle
                                              .headline14w400CFF7A01Poppins
                                              .copyWith(
                                                  color: AppColors.cBCBCBC),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(Assets.icons.dateCalenderIcon),
                            UIHelper.horizontalSpace(10.w),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      formatDate(data.startDate!),
                                      style: TextFontStyle
                                          .headline12w400C999999Poppins
                                          .copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.cFFFFFF,
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  Expanded(
                                    child: Text(
                                      formatDate(
                                          data.endDate ?? DateTime.now()),
                                      style: TextFontStyle
                                          .headline12w400C999999Poppins
                                          .copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.cFFFFFF,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.horizontalSpace(10.w),
                            SvgPicture.asset(Assets.icons.dateCalenderIcon),
                            UIHelper.horizontalSpace(10.w),
                            Expanded(
                              child: Text(
                                "${formatTime(formatStringToTime(data.startTime!), context)} - ${formatTime(formatStringToTime(data.endTime!), context)}",
                                style: TextFontStyle
                                    .headline12w400C999999Poppins
                                    .copyWith(
                                  color: AppColors.cFFFFFF,
                                  fontSize: 10.sp,
                                ),
                                // maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(12.h),
                        Row(
                          children: [
                            SvgPicture.asset(Assets.icons.dateCalenderIcon),
                            UIHelper.horizontalSpace(4.w),
                            Text(
                              "\$10:00",
                              style: TextFontStyle.headline14w400CFFFFFFPoppins,
                            ),
                            UIHelper.horizontalSpace(4.w),
                            Text(
                              "\$10:00",
                              style: TextFontStyle.headline10w400c6B6B6BPoppins
                                  .copyWith(
                                color: AppColors.c969696,
                              ),
                            )
                          ],
                        ),
                        UIHelper.verticalSpace(24.h),
                        Text(
                          data.description ?? "",
                          style: TextFontStyle.headline12w400C999999Poppins
                              .copyWith(color: AppColors.c969696),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.scaffoldColor,
        height: 78.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: CustomAddButton(
            titile: 'Add New Seasonal Offer',
            ontap: () {
              NavigationService.navigateToWithArgs(
                  Routes.addSeasonalOffer, {"status": false});
            },
          ),
        ),
      ),
    );
  }

  void _showalartdialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const CustomAlartDialogWidget();
      },
    );
  }
}
