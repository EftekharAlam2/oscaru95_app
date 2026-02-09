// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/analytics.dart';
import 'package:oscaru95/features/merchant/merchant_dash_board/presentation/merchant_desh_board_screen.dart';
import 'package:oscaru95/features/merchant/merchant_profile/presentation/merchant_profile_screen.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/networks/api_access.dart';

class MarchentNavigationScreen extends StatefulWidget {
  const MarchentNavigationScreen({super.key});

  @override
  State<MarchentNavigationScreen> createState() =>
      _MarchentNavigationScreenState();
}

class _MarchentNavigationScreenState extends State<MarchentNavigationScreen> {
  int selectedIndex = 0;
  final List<Widget> _screens = const [
    MerchantDeshBoardScreen(),
    AnalyticsScreen(),
    MerchantProfileScreen(),

    // UserHomeScreen(),
    // SearchScreen(),
    // BookingScreen(),
    // SaveScreen(),
    // ProfileScreen()
  ];

  @override
  void initState() {
    busniessProfileRx.getBusinessProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: _screens[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.cFFFFFF,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                    color: AppColors.cFF7A01,
                    fontWeight: FontWeight.w700,
                    fontSize: 12);
              }
              return const TextStyle(
                  color: AppColors.c6B6B6B,
                  fontWeight: FontWeight.w700,
                  fontSize: 12);
            },
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.c282828,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x16000000),
                blurRadius: 14,
                offset: Offset(0, -5),
                spreadRadius: 0,
              )
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: NavigationBar(
              height: 80.h,
              backgroundColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset(
                    Assets.icons.chartSquare,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.chartSquare,
                    color: const Color(0xFFFF7A01),
                    width: 24.w,
                  ),
                  label: "Dashboard",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    Assets.icons.research,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.research,
                    color: const Color(0xFFFF7A01),
                    width: 24.w,
                  ),
                  label: "Analytics",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    Assets.icons.profile,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.profile,
                    color: const Color(0xFFFF7A01),
                    width: 24.w,
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
