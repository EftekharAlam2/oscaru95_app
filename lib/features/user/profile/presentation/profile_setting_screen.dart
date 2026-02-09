import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/merchant/merchant_profile/presentation/merchant_profile_screen.dart';
import 'package:oscaru95/features/user/profile/model/user_profile_response.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  void initState() {
    getUserProfileRx.getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      Assets.icons.menuBoard,
      Assets.icons.profile,
      Assets.icons.key,
      Assets.icons.setting2,
      Assets.icons.helpSupport,
      Assets.icons.profileDelete,
      Assets.icons.profileDelete,
    ];
    List<String> title = [
      "Personalized Itinerary planner",
      "Personal Information",
      "Edit Password",
      "Setting",
      "Help & supportdadad",
      "Rating & Feedback",
      "Account Deletion",
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Profile",
                        style: TextFontStyle.headline18w600CFFFFFFPoppins,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(25.h),
                  StreamBuilder(
                      stream: getUserProfileRx.userProfileStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          UserProfileResponse model = snapshot.data;
                          var name = model.data!.fName ?? "";
                          var email = model.data!.email ?? "";
                          var avatar = model.data!.avatar ?? "";
                          return ProfileHeadersWidget(
                            url: avatar,
                            name: name,
                            email: email,
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                  UIHelper.verticalSpace(16.h),
                  const Divider(
                    thickness: 2,
                    color: AppColors.c282828,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ProfileTileWidget(
                      icon: icons[index],
                      isPremium: index == 0,
                      title: title[index],
                      onTap: () {
                        switch (index) {
                          case 0:
                            NavigationService.navigateTo(
                                Routes.personalizedScreen);

                          case 1:
                            NavigationService.navigateTo(
                                Routes.updateProfileScreen);
                            break;
                          case 2:
                            NavigationService.navigateTo(
                                Routes.editPasswordScreen);
                            break;
                          case 3:
                            NavigationService.navigateTo(Routes.setttingScreen);
                            break;

                          case 4:
                            NavigationService.navigateTo(
                                Routes.helpSupportScreen);
                            break;
                          case 5:
                            NavigationService.navigateTo(Routes.reviewScreen);
                            break;

                          case 6:
                            NavigationService.navigateTo(
                                Routes.accountDeleteScreen);
                            break;
                          default:
                        }
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        UIHelper.verticalSpaceSmall,
                    itemCount: 7,
                  ),
                  UIHelper.verticalSpaceExtraLarge,
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          userLogoutRx.userLogout().waitingForSucess().then((success) {
            if (success) {
              NavigationService.navigateTo(Routes.loginScreen);
            }
          });
        },
        child: Container(
          margin: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            gradient: const LinearGradient(
              begin: Alignment(1.00, -0.01),
              end: Alignment(-1, 0.01),
              colors: [Color(0xFFFFC900), Color(0xFFFE5401)],
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              color: AppColors.scaffoldColor,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(16.sp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Log Out',
                    style: TextFontStyle.headline14w600CFF7A01Poppins),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.isPremium,
    this.onTap,
  });
  final String icon;
  final String title;
  final bool isPremium;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.c282828, borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.all(16.sp),
        child: SizedBox(
          width: double.infinity, // Ensure the width is bounded
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: const BoxDecoration(
                  color: AppColors.cFE5401,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(icon),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: Text(
                  title,
                  style: TextFontStyle.headline16w400CFFFFFFPoppins,
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              isPremium
                  ? SvgPicture.asset(
                      Assets.icons.crown,
                      height: 24.h,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              isPremium
                  ? UIHelper.horizontalSpaceSmall
                  : const SizedBox.shrink(),
              Icon(
                Icons.arrow_forward_ios,
                size: 24.sp,
                color: AppColors.cFFFFFF,
              )
            ],
          ),
        ),
      ),
    );
  }
}
