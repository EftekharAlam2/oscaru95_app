import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/auth/presentation/role/presentation/widget/role_choose_widget.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen> {
  int selectedIndex = 0;
  String _selectedValue = "1";

  List<String> value = [
    "1",
    "2",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80.r, // control size here
                backgroundImage: AssetImage(Assets.images.appLogoImage.path),
                backgroundColor: Colors.transparent, // optional
              ), // Text(

              // Text(
              //   "LOGO",
              //   style: TextFontStyle.headline28w600C222222Poppins
              //       .copyWith(color: AppColors.cFFFFFF, fontSize: 40.sp),
              // ),
              UIHelper.verticalSpace(40.h),
              RoleChooseWidget(
                name: "User Account",
                name2: "Discover the best food & drink deals near you.",
                borderColor:
                    selectedIndex == 0 ? AppColors.cFF7A01 : Colors.transparent,
                backgroundColor:
                    selectedIndex == 0 ? AppColors.cFFF2E6 : AppColors.cFFFFFF,
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    _selectedValue = value[0];
                  });
                },
                img: Assets.icons.user,
                radioValue: value[0],
                onChanged: (p0) {},
                selectedValue: _selectedValue,
              ),
              UIHelper.verticalSpace(30.h),
              RoleChooseWidget(
                name2: "Promote your venue and attract more customers.",
                name: "Business Account",
                borderColor:
                    selectedIndex == 1 ? AppColors.cFF7A01 : Colors.transparent,
                backgroundColor:
                    selectedIndex == 1 ? AppColors.cFFF2E6 : AppColors.cFFFFFF,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    _selectedValue = value[1];
                  });
                },
                img: Assets.icons.business,
                radioValue: value[1],
                onChanged: (p0) {},
                selectedValue: _selectedValue,
              ),
              UIHelper.verticalSpace(150.h),
              CustomButton(
                textStaus: false,
                onTap: () {
                  if (selectedIndex == 0) {
                    NavigationService.navigateTo(Routes.loginScreen);
                  } else if (selectedIndex == 1) {
                    NavigationService.navigateTo(Routes.loginMerchantScreen);
                  }
                },
                btnName: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
