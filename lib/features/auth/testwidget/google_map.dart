// // ignore_for_file: unused_field

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:henock/common_widget/custom_button.dart';
// import 'package:henock/constants/app_constants.dart';
// import 'package:henock/constants/text_font_style.dart';
// import 'package:henock/features/user/home/model/nearest_shop_response.dart';
// import 'package:henock/features/user/home/model/notice_response.dart';
// import 'package:henock/features/user/home/presentation/widget/custom_drawer.dart';
// import 'package:henock/features/user/home/presentation/widget/restaurant_card_widget.dart';
// import 'package:henock/gen/assets.gen.dart';
// import 'package:henock/gen/colors.gen.dart';
// import 'package:henock/helpers/all_routes.dart';
// import 'package:henock/helpers/di.dart';
// import 'package:henock/helpers/helpers_method.dart';
// import 'package:henock/helpers/loading_helper.dart';
// import 'package:henock/helpers/navigation_service.dart';
// import 'package:henock/helpers/ui_helpers.dart';
// import 'package:henock/networks/api_access.dart';
// import 'package:henock/provider/user_restaurant_provider.dart';
// import 'package:provider/provider.dart';

// class UserHomeScreen extends StatefulWidget {
//   const UserHomeScreen({super.key});

//   @override
//   State<UserHomeScreen> createState() => _UserHomeScreenState();
// }

// class _UserHomeScreenState extends State<UserHomeScreen> {
//   late UserRestaurantProvider provider;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool selected = false;
//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//     provider = Provider.of<UserRestaurantProvider>(context, listen: false);
//     if (appData.read(kKeyIsLoggedIn) == true) {
//       getNotificationRx.getNotification();
//       addTokenRx.addToken(
//         token: appData.read(kKeyFCMToken),
//         deviceId: appData.read(kKeyDeviceID),
//       );

//       userProfileRx.getUserProfile();
//       appData.write(KKeyIsFirstTime, false);
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         getNoticeRx.getNotice().then((success) {
//           if (success) {
//             if (getNoticeRx.hasNewNotice != null) {
//               if (getNoticeRx.hasNewNotice! == false) {
//                 debugPrint("log ==============> ${getNoticeRx.hasNewNotice}");
//                 initialDialog();
//               }
//             }
//           }
//         });
//       });
//     }

//     getNearestShopRx.getNearestShop();

//     fetchNearestShops().then(() {
//       if (mounted) {
//         // _showBottomSheet();
//       }
//     });
//   }

//   Future<dynamic> initialDialog() {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Announcement",
//                   style: TextFontStyle.headline16C292D32SatoshiBold,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       readNoticeRx.readNotice();
//                     },
//                     child: const Icon(Icons.close),
//                   ),
//                 ),
//               ],
//             ),
//             UIHelper.verticalSpace(12.h),
//             StreamBuilder(
//               stream: getNoticeRx.noticeStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasData) {
//                   NoticeResponse response = snapshot.data;
//                   final data = response.data;
//                   return Text(
//                     data?.notice?.message ?? "",
//                     style: TextFontStyle.headline14C292D32SatoshiMedium,
//                   );
//                   // return HtmlWidget(
//                   //   data?.message ?? 'No description',
//                   //   textStyle:
//                   //       TextFontStyle.headline12C949698SatoshiRegular.copyWith(
//                   //     fontSize: 12.sp,
//                   //     color: AppColors.c000000,
//                   //     fontWeight: FontWeight.w300,
//                   //   ),
//                   //   customStylesBuilder: (element) {
//                   //     if (element.classes.contains('highlight')) {
//                   //       return {'color': 'blue'};
//                   //     }
//                   //     return null;
//                   //   },
//                   //   customWidgetBuilder: (element) {
//                   //     if (element.attributes['foo'] == 'bar') {
//                   //       // Render a custom widget if needed
//                   //     }
//                   //     return null;
//                   //   },
//                   //   renderMode: RenderMode.column,
//                   // );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<LocationList> _filteredShops = [];

//   GoogleMapController? _mapController;
//   LatLng? _currentPosition;
//   Set<Marker> _markers = {};
//   Map<String, double> _shopDistances = {}; // Store distances separately

//   Future<void> _getUserLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       locationSettings: AppleSettings(
//         accuracy: LocationAccuracy.high,
//       ),
//     );

//     if (mounted) {
//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//       });
//       appData.write(KKeyUserCurrentLat, position.latitude);
//       appData.write(KKeyUserCurrentLng, position.longitude);
//       debugPrint(
//           "User's Current Location: Latitude: ${position.latitude}, Longitude: ${position.longitude}");
//     }

//     _mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: _currentPosition!, zoom: 14),
//       ),
//     );
//   }

//   /// *Fetch Nearest Shops & Add Markers*

//   Future<void> _fetchNearestShops() async {
//     try {
//       bool success = await getNearestShopRx.getNearestShop();
//       if (success && _currentPosition != null) {
//         Set<Marker> shopMarkers = {};
//         List<LocationList> tempFilteredShops = [];
//         Map<String, double> tempShopDistances = {}; // Temporary distance map

//         for (var shop in getNearestShopRx.responseData!.locationList!) {
//           if (shop.latitude != null && shop.longitude != null) {
//             double shopLat = double.parse(shop.latitude!);
//             double shopLng = double.parse(shop.longitude!);
//             double distance = _calculateDistance(_currentPosition!.latitude,
//                 _currentPosition!.longitude, shopLat, shopLng);

//             if (distance <= 15.0) {
//               tempFilteredShops.add(shop);
//               tempShopDistances[shop.id!.toString()] = distance;

//               shopMarkers.add(
//                 Marker(
//                   markerId: MarkerId(shop.id.toString()),
//                   position: LatLng(shopLat, shopLng),
//                   onTap: () async {
//                     bool categoryFetched = await userGetCategoryRx
//                         .getCategory()
//                         .waitingForSucess();
//                     if (categoryFetched) {
//                       await userRestaurantProfileRx.getShopDetails(
//                         shopId: shop.id!,
//                         categoryId: provider.selectedIndex + 1,
//                       );
//                       NavigationService.navigateToWithArgs(
//                         Routes.userRestaurantProfileRoute,
//                         {
//                           'id': shop.id,
//                           'lat': shop.latitude,
//                           'lng': shop.longitude,
//                         },
//                       );
//                     }
//                   },
//                 ),
//               );
//             }
//           }
//         }

//         // Sort shops by distance
//         tempFilteredShops.sort((a, b) {
//           double distanceA =
//               tempShopDistances[a.id.toString()] ?? double.infinity;
//           double distanceB =
//               tempShopDistances[b.id.toString()] ?? double.infinity;
//           return distanceA.compareTo(distanceB);
//         });

//         // Update state with filtered shops and distances
//         setState(() {
//           _markers = shopMarkers;
//           _filteredShops = tempFilteredShops;
//           _shopDistances = tempShopDistances; // Store calculated distances
//         });
//       }
//     } catch (error) {
//       debugPrint("Error fetching shops: $error");
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text("Failed to load nearest shops.")),
//       // );
//     }
//   }

//   double _calculateDistance(
//       double lat1, double lon1, double lat2, double lon2) {
//     const double R = 6371; // Earth radius in km
//     double dLat = _degToRad(lat2 - lat1);
//     double dLon = _degToRad(lon2 - lon1);

//     double a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(_degToRad(lat1)) *
//             cos(_degToRad(lat2)) *
//             sin(dLon / 2) *
//             sin(dLon / 2);

//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return R * c; // Distance in km
//   }

//     double _degToRad(double deg) {
//     return deg * (pi / 180);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: CustomDrawer(
//         scaffoldKey: _scaffoldKey,
//       ),
//       appBar: _userHomeAppBar(),
//       body: _currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _currentPosition!,
//                 zoom: 15,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _mapController = controller;
//               },
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               markers: _markers,
//             ),
//       bottomNavigationBar: GestureDetector(
//           onTap: () {
//             setState(() {
//               selected = !selected;
//             });
//           },
//           child: _filteredShops.isEmpty
//               ? SizedBox(
//                   height: 70.h,
//                   child: Center(
//                     child: Text(
//                       "No shops found within 15 km".tr,
//                       style: TextFontStyle.headline14C292D32SatoshiBold,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 )
//               : Container(
//                   height: selected ? 100.h : 330.h,
//                   decoration: BoxDecoration(
//                     color: AppColors.cFFFFFF,
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20.r),
//                     ),
//                   ),
//                   // padding: EdgeInsets.all(12.sp),
//                   child: selected
//                       ? Padding(
//                           padding: EdgeInsets.all(14.sp),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Expanded(
//                               //   child: Row(
//                               //     children: [
//                               //       SvgPicture.asset(Assets.icons.nearbyIcon),
//                               //       UIHelper.horizontalSpace(8.w),
//                               //       Expanded(
//                               //         child: Text(
//                               //           "Nearby Pickup Points".tr,
//                               //           style: TextFontStyle
//                               //               .headline16C292D32SatoshiBold
//                               //               .copyWith(
//                               //             color: AppColors.c003925,
//                               //           ),
//                               //           overflow: TextOverflow.ellipsis,
//                               //           maxLines: 1,
//                               //         ),
//                               //       ),
//                               //     ],
//                               //   ),
//                               // ),
//                               // UIHelper.verticalSpaceSmall,
//                               // Text(
//                               //   "${"There are".tr} ${_filteredShops.length} ${"pickup points within 15 km of your location.".tr}",
//                               //   style: TextFontStyle
//                               //       .headline16C292D32SatoshiMedium,
//                               // ),
//                               // UIHelper.verticalSpaceSmall,
//                               CustomButton(
//                                 onTap: () {
//                                   setState(() {
//                                     selected = !selected;
//                                   });
//                                 },
//                                 btnName: "Show Pickup Point".tr,
//                               )
//                             ],
//                           ),
//                         )
//                       : Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             UIHelper.verticalSpaceSmall,
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 16.w),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Pickup Points".tr,
//                                     style: TextFontStyle
//                                         .headline16C292D32SatoshiBold,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         selected = !selected;
//                                       });
//                                     },
//                                     child: Icon(
//                                       Icons.close,
//                                       size: 20.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             UIHelper.verticalSpace(10.h),
//                             Consumer<UserRestaurantProvider>(
//                               builder: (context, provider, child) {
//                                 return SizedBox(
//                                   height: 280.h,
//                                   child: ListView.builder(
//                                     itemCount: _filteredShops.length,
//                                     physics: const BouncingScrollPhysics(),
//                                     padding: EdgeInsets.only(
//                                         left: 14.w, bottom: 14.h),
//                                     scrollDirection: Axis.horizontal,
//                                     itemBuilder: (context, index) {
//                                       final data = _filteredShops[index];
//                                       double distance =
//                                           _shopDistances[data.id!.toString()] ??
//                                               0.0;
//                                       int pickupTime = (distance * 2).round();

//                                       return RestaurantCard(
//                                         onTap: () async {
//                                           // Navigator.pop(context);
//                                           await userGetCategoryRx
//                                               .getCategory()
//                                               .waitingForSucess()
//                                               .then((success) async {
//                                             if (success) {
//                                               userRestaurantProfileRx
//                                                   .getShopDetails(
//                                                 shopId: data.id!,
//                                                 categoryId:
//                                                     provider.selectedIndex + 1,
//                                               );
//                                               NavigationService
//                                                   .navigateToWithArgs(
//                                                 Routes
//                                                     .userRestaurantProfileRoute,
//                                                 {
//                                                   'id': data.id,
//                                                   'lat': data.latitude,
//                                                   'lng': data.longitude,
//                                                 },
//                                               );
//                                             }
//                                           });
//                                         },
//                                         restaurantName: data.name ?? "",
//                                         image: data.cover ?? "",
//                                         address: data.location ?? "",
//                                         distance:
//                                             "${distance.toStringAsFixed(2)} km",
//                                         duration:
//                                             "$pickupTime min${pickupTime > 1 ? 's' : ""}",
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                 )),
//     );
//   }

//   PreferredSize _userHomeAppBar() {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(100.h),
//       child: Container(
//         height: 100.h,
//         margin: EdgeInsets.only(bottom: 16.h),
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _scaffoldKey.currentState?.openDrawer();
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 decoration: BoxDecoration(
//                   color: AppColors.cF4F4F4,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: SvgPicture.asset(Assets.icons.menuIcon),
//               ),
//             ),
//             UIHelper.horizontalSpaceSmall,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     "Home".tr,
//                     style:
//                         TextFontStyle.headline18CFFFFFFSatoshiMedium.copyWith(
//                       color: AppColors.c292D32,
//                       fontSize: 18.sp,
//                     ),
//                   ),
//                   Text(
//                     "Banasree Main Road, Dhaka",
//                     style:
//                         TextFontStyle.headline14C797878SatoshiRegular.copyWith(
//                       color: AppColors.c292D32,
//                       fontSize: 14.sp,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 if (appData.read(kKeyIsLoggedIn)) {
//                   NavigationService.navigateTo(Routes.cartRoute);
//                 } else {
//                   loginWarningDialog(context);
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 margin: EdgeInsets.symmetric(horizontal: 12.w),
//                 decoration: BoxDecoration(
//                   color: AppColors.cF4F4F4,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: SvgPicture.asset(Assets.icons.cart),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 if (appData.read(kKeyIsLoggedIn)) {
//                   NavigationService.navigateTo(Routes.notificationRoute);
//                 } else {
//                   loginWarningDialog(context);
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 decoration: BoxDecoration(
//                   color: AppColors.cF4F4F4,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: Stack(
//                   children: [
//                     SvgPicture.asset(
//                       Assets.icons.notificationIcon,
//                     ),
//                     Positioned(
//                       right: 0,
//                       child: Container(
//                         height: 8.h,
//                         width: 8.w,
//                         decoration: BoxDecoration(
//                           color:
//                               getNotificationRx.hasUnreadNotification == false
//                                   ? AppColors.cFF0000
//                                   : Colors.transparent,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
