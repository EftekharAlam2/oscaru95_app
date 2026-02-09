// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:oscaru95/constants/text_font_style.dart';
// import 'package:oscaru95/gen/assets.gen.dart';
// import 'package:oscaru95/gen/colors.gen.dart';
// import 'package:oscaru95/helpers/ui_helpers.dart';

// class DemoScreen extends StatefulWidget {
//   const DemoScreen({super.key});

//   @override
//   State<DemoScreen> createState() => _DemoScreenState();
// }

// class _DemoScreenState extends State<DemoScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List icons = [
//       Assets.icons.callCalling,
//       Assets.icons.arrowSquare,
//       Assets.icons.messageFavorite,
//       Assets.icons.heartColord,
//     ];

//     return Scaffold(
//       backgroundColor: AppColors.scaffoldColor,
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//             // Profile & Info Section
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 24.sp, vertical: 16.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     _buildProfileImage(),
//                     Text(
//                       "Sanchez Cafe",
//                       style: TextFontStyle.headline16w400CFFFFFFPoppins
//                           .copyWith(fontSize: 22.sp),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(Assets.icons.shopGrayish),
//                         UIHelper.horizontalSpace(4.w),
//                         Text(
//                           "Bar",
//                           style: TextFontStyle.headline14w400c666666Poppins
//                               .copyWith(color: AppColors.c999999),
//                         ),
//                         UIHelper.horizontalSpace(8.w),
//                         SvgPicture.asset(Assets.icons.locationGraish),
//                         UIHelper.horizontalSpace(4.w),
//                         Text(
//                           "Road 3, London",
//                           style: TextFontStyle.headline14w400c666666Poppins
//                               .copyWith(color: AppColors.c999999),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "Daily Operating Hour: 9:30 AM to 10:00 PM",
//                       style: TextFontStyle.headline14w400c666666Poppins
//                           .copyWith(color: AppColors.c999999),
//                     ),
//                     UIHelper.verticalSpace(24.w),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         icons.length,
//                         (index) => Container(
//                           margin: EdgeInsets.symmetric(horizontal: 8.w),
//                           padding: EdgeInsets.all(16.sp),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.c282828,
//                           ),
//                           child: SvgPicture.asset(
//                             icons[index],
//                             height: 24.h,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Sticky TabBar
//             SliverPersistentHeader(
//               pinned: true,
//               floating: false,
//               delegate: _TabBarDelegate(
//                 TabBar(
//                   controller: _tabController,
//                   indicatorColor: AppColors.cFE5401,
//                   labelColor: AppColors.cFE5401,
//                   unselectedLabelColor: AppColors.c999999,
//                   dividerColor: AppColors.c282828,
//                   labelStyle: TextFontStyle.headline12w500c222222Poppins,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   tabs: const [
//                     Tab(text: "Food"),
//                     Tab(text: "Drink"),
//                     Tab(text: "Menu"),
//                     Tab(text: "Coupon"),
//                   ],
//                 ),
//               ),
//             ),
//           ];
//         },
//         // Scrollable Tab Views
//         body: TabBarView(
//           controller: _tabController,
//           physics:
//               const NeverScrollableScrollPhysics(), // Avoid nested scrolling conflicts
//           children: [
//             _buildTabContent("Food"),
//             _buildTabContent("Drink"),
//             _buildTabContent("Menu"),
//             _buildTabContent("Coupon"),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Builds the content inside each tab with ListView for scrolling
//   Widget _buildTabContent(String text) {
//     return ListView.builder(
//       padding: EdgeInsets.all(16.w),
//       physics: const BouncingScrollPhysics(),
//       itemCount: 10, // Example item count
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 8.h),
//           child: Text(
//             "$text Item ${index + 1}",
//             style: TextStyle(color: AppColors.cFFFFFF, fontSize: 16.sp),
//           ),
//         );
//       },
//     );
//   }

//   /// Profile Image with gradient border
//   Stack _buildProfileImage() {
//     return Stack(
//       children: [
//         Container(
//           height: 134.h,
//           width: 134.w,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Color(0XFFFFC900),
//               Color(0XFFFE5401),
//             ]),
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(4.sp),
//             child: ClipOval(
//               child: Image.asset(
//                 Assets.images.placeholderImage.path,
//                 height: 100.h,
//                 width: 100.w,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// **Custom Delegate for the TabBar inside SliverPersistentHeader**
// class _TabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar _tabBar;
//   _TabBarDelegate(this._tabBar);

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Material(
//       color: AppColors.scaffoldColor, // Keeps the TabBar background
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
// }
