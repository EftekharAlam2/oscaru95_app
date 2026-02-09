// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/features/user/discover/presentation/discover_screen.dart';
import 'package:oscaru95/features/user/favourite/presentation/favourite_screen.dart';
import 'package:oscaru95/features/user/home/presentation/user_home_screen.dart';
import 'package:oscaru95/features/user/profile/presentation/profile_setting_screen.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/networks/api_access.dart';

class UserNavigationScreen extends StatefulWidget {
  const UserNavigationScreen({super.key});

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {
  int selectedIndex = 0;
  final List<Widget> _screens = const [
    UserHomeScreen(),
    DiscoverScreen(),
    FavouriteScreen(),
    ProfileSettingScreen(),

    // UserHomeScreen(),
    // SearchScreen(),
    // BookingScreen(),
    // SaveScreen(),
    // ProfileScreen()
  ];

  @override
  void initState() {
    getNearestRx.getNearest();
    getDiscoverRx.getDiscover();
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
              height: 105.h,
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
                    Assets.icons.home,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.home,
                    color: const Color(0xFFFF7A01),
                    width: 24.w,
                  ),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    Assets.icons.discover,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.discover,
                    color: const Color(0xFFFF7A01),
                    width: 24.w,
                  ),
                  label: "Discover",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    Assets.icons.heart,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.heart,
                    color: const Color(0xFFFF7A01),
                    width: 24.w,
                  ),
                  label: "Favourite",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    Assets.icons.profileCircle,
                    color: const Color(0xFFB8B8B8),
                    width: 24.w,
                  ),
                  selectedIcon: SvgPicture.asset(
                    Assets.icons.profileCircle,
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
