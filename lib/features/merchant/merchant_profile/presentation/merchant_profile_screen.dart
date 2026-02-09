import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_network_image.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/merchant_profile/model/busniess_profile_response.dart';
import 'package:oscaru95/features/merchant/merchant_profile/presentation/widget/custom_profile_info_widget.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class MerchantProfileScreen extends StatefulWidget {
  const MerchantProfileScreen({super.key});

  @override
  State<MerchantProfileScreen> createState() => _MerchantProfileScreenState();
}

class _MerchantProfileScreenState extends State<MerchantProfileScreen> {
  @override
  void initState() {
    busniessProfileRx.getBusinessProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        title: Text(
          "Profile",
          style: TextFontStyle.headline24w400cFFFFFFPoppins,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            StreamBuilder(
              stream: busniessProfileRx.getBusniessProfileStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  BusinessProfileResponse response = snapshot.data;
                  final data = response.data;
                  return ProfileHeadersWidget(
                    url: data?.cover ??
                        "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg",
                    name: data?.venueName ?? "",
                    email: data?.email ?? "",
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            UIHelper.verticalSpace(16.h),
            const Divider(
              thickness: 2,
              color: AppColors.c282828,
            ),
            UIHelper.verticalSpace(35.h),
            CustomProfileInfoWidget(
              titile: 'Venue Information',
              icon: Assets.icons.venueInfoIcon,
              pressInfo: () {
                NavigationService.navigateTo(
                    Routes.merchantVenueInformationScreen);
              },
            ),
            UIHelper.verticalSpace(12.h),
            CustomProfileInfoWidget(
              titile: 'Edit Password',
              icon: Assets.icons.editPassIcon,
              pressInfo: () {
                NavigationService.navigateTo(Routes.merchantEditPasswordScreen);
              },
            ),
            UIHelper.verticalSpace(12.h),
            CustomProfileInfoWidget(
              titile: 'Help & support',
              icon: Assets.icons.infoIcon,
              pressInfo: () {
                NavigationService.navigateTo(
                    Routes.merchanthelpandsupportScreen);
              },
            ),
            UIHelper.verticalSpace(12.h),
            CustomProfileInfoWidget(
              titile: 'Privacy Policy',
              icon: Assets.icons.privacyPolicyIcon,
              pressInfo: () {
                NavigationService.navigateTo(
                    Routes.merchantprivacyPolicyScreen);
              },
            ),
            UIHelper.verticalSpace(12.h),
            CustomProfileInfoWidget(
              titile: 'Delete Account',
              icon: Assets.icons.trushIcon,
              pressInfo: () {
                NavigationService.navigateTo(
                    Routes.merchantDeleteAccountScreen);
              },
            ),
            UIHelper.verticalSpace(41.h),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Logout"),
                        const Text("Are your sure you want to logout"),
                        UIHelper.verticalSpace(20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                width: 60.w,
                                onTap: () {
                                  marchentLogoutRx
                                      .marchentLogout()
                                      .waitingForSucess()
                                      .then((success) {
                                    if (success) {
                                      NavigationService.navigateToReplacement(
                                          Routes.loginMerchantScreen);
                                    }
                                  });
                                },
                                textStaus: false,
                                btnName: "Yes",
                              ),
                            ),
                            UIHelper.horizontalSpace(15.w),
                            Expanded(
                              child: CustomButton(
                                width: 60.w,
                                onTap: () {
                                  NavigationService.goBack;
                                },
                                textStaus: false,
                                btnName: "No",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.cFE5401),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Center(
                  child: Text(
                    "Log Out",
                    style: TextFontStyle.headline18w500CFFFFFFPoppins
                        .copyWith(color: AppColors.cFE5401),
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpace(41.h),
          ],
        ),
      ),
    );
  }
}

class ProfileHeadersWidget extends StatelessWidget {
  final String url;
  final String name;
  final String email;
  const ProfileHeadersWidget({
    super.key,
    required this.url,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImageWidget(width: 85.w, height: 85.w, urls: url),
        UIHelper.horizontalSpace(16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextFontStyle.headline16w500c222222Poppins
                  .copyWith(color: AppColors.cFFFFFF),
            ),
            UIHelper.verticalSpaceSmall,
            Text(
              email,
              style: TextFontStyle.headline12w400C999999Poppins
                  .copyWith(color: AppColors.c969696)
                  .copyWith(color: AppColors.cFFFFFF),
            ),
          ],
        )
      ],
    );
  }
}
