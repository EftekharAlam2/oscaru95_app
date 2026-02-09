import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/home/model/nearest_shop_response.dart';
import 'package:oscaru95/features/user/home/presentation/widgets/home_list_tile_widget.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/user_home_provider.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchCnt = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  Set<Marker> _markers = {};
  List<LocationData> _filteredShops = [];

  /// Store the custom marker icons
  BitmapDescriptor? _resturent; // Marker for the first shop type (shopLocation1.png)
  BitmapDescriptor? _bar;       // Marker for a second shop type (Example)
  String mapTheme='';

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/darkthem/darkthem.json').then((value) {
      setState(() {
        mapTheme = value;
      });
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _loadCustomMarkers();
    // Start getting location immediately
    _getCurrentLocation(); 
    getNearestRx.getNearest();
    _fetchNearestShops();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCnt.dispose();
    super.dispose();
  }

  /// Preload custom marker icon (using assets/images/shopLocation.png)
  Future<void> _loadCustomMarkers() async {
    // Load the first marker image
    _resturent = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(64, 64)), 
      "assets/images/shopLocation1.png", // Your first image path
    );
    
    // Load a second marker image
    _bar = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(64, 64)), 
      "assets/images/shopLocation.png", 
    );

    if (mounted) setState(() {});
  }

  /// New method to consistently focus the camera on the user's location
  void _focusCameraOnCurrentLocation() {
    // Zoom set to 14 for a good street-level focus
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 14), 
        ),
      );
    }
  }

  /// Get the user's current location
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    if (!mounted) return;

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude); 
    });

    appData.write(kKeySelectedLat, position.latitude);
    appData.write(kKeySelectedLng, position.longitude);

    _focusCameraOnCurrentLocation();
  }

  /// Create Google Map markers
  void _createMarkers(NearestShopResponse response) {
    if (_currentPosition == null) return;

    Set<Marker> markers = {};
    List<LocationData> tempFilteredShops = [];

    // Define the primary fallback marker
    final defaultMarker = _resturent ?? BitmapDescriptor.defaultMarker; 

    for (var shop in response.data!.data!) {
      if (shop.latitude != null && shop.longitude != null) {
        final lat = double.tryParse(shop.latitude!);
        final lng = double.tryParse(shop.longitude!);

        if (lat != null && lng != null) {
          tempFilteredShops.add(shop);

          BitmapDescriptor icon;
          
          // Logic to choose the correct icon based on shop data
          // Adjust the condition (shop.type == 'bar') and the variable (_bar) as needed
          if (shop.type == 'Restaurant' && _bar != null) {
            icon = _bar!;
          } else if (shop.type == 'Bar' && _resturent != null) {
             icon = _resturent!;
          } 
          // Add more conditions here for other marker types/images
          else {
            icon = defaultMarker; // Fallback to the default custom marker
          }

          markers.add(
            Marker(
              markerId: MarkerId(shop.id.toString()),
              position: LatLng(lat, lng),
              icon: icon, // Use the dynamically selected icon
              infoWindow: InfoWindow(
                title: shop.venueName,
                snippet: shop.address,
              ),
            ),
          );
        }
      }
    }

    if (mounted) {
      setState(() {
        _markers = markers;
        _filteredShops = tempFilteredShops;
      });
    }
  }

  Future<void> _fetchNearestShops() async {
    try {
      bool success = await getNearestRx.getNearest();
      if (success && _currentPosition != null) {
        _createMarkers(getNearestRx.response! as NearestShopResponse);
      }
    } catch (error) {
      debugPrint("Error fetching shops: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170.h),
        child: Consumer<UserHomeProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          NavigationService.navigateTo(
                              Routes.changeMyLocationScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.icons.location),
                            UIHelper.horizontalSpace(4.w),
                            Text('Barcelona, Spain',
                                style: TextFontStyle
                                    .headline16w400CFFFFFFPoppins),
                            UIHelper.horizontalSpace(4.w),
                            SvgPicture.asset(Assets.icons.arrowDropDown),
                          ],
                        ),
                      ),
                      Badge(
                        label: Text(
                          "4",
                          style: TextFontStyle.headline12w400c6B6B6BPoppins
                              .copyWith(color: AppColors.cFFFFFF),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.navigateTo(
                                Routes.notificationScreen);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.c282828,
                            ),
                            padding: EdgeInsets.all(8.sp),
                            child:
                                SvgPicture.asset(Assets.icons.notificationBing),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  HomeSearchWidget(searchCnt: _searchCnt),
                  UIHelper.verticalSpaceSmall,
                  ViewTypeSelectorWidget(provider: provider),
                  UIHelper.verticalSpace(16.h),
                ],
              ),
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: getNearestRx.getNearestStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            NearestShopResponse response = snapshot.data!;
            
            // Logic to determine the map's initial center point (First shop location)
            LatLng? initialTarget;
            if (response.data?.data?.isNotEmpty == true) {
              final firstShop = response.data!.data!.first;
              final lat = double.tryParse(firstShop.latitude ?? '0.0');
              final lng = double.tryParse(firstShop.longitude ?? '0.0');
              if (lat != null && lng != null && lat != 0.0 && lng != 0.0) {
                // Target the first shop's location
                initialTarget = LatLng(lat, lng);
              }
            }
            // Fallback to the user's current location if no shop data is valid
            initialTarget ??= _currentPosition;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _createMarkers(response);
            });

            return Consumer<UserHomeProvider>(
              builder: (context, provider, child) {
                return provider.selectedIndex == 1
                    ? (initialTarget == null 
                        ? const Center(child: CircularProgressIndicator())
                        : GoogleMap(
                            initialCameraPosition: CameraPosition(
                              // Use the calculated initialTarget (the first shop)
                              target: initialTarget!, 
                              zoom: 10, 
                            ),
                            myLocationEnabled: true,
                            markers: _markers,
                            onMapCreated: (controller) {
                              if(mapTheme.isNotEmpty){
                                controller.setMapStyle(mapTheme);
                              }
                              _mapController = controller;
                            },
                          ))
                    : ListView.builder(
                        itemCount: _filteredShops.length,
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 16.h),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var model = _filteredShops[index];
                          return GestureDetector(
                            onTap: () {
                              // Animates map to the selected list item's location
                              if (_mapController != null) {
                                final lat =
                                    double.tryParse(model.latitude ?? "");
                                final lng =
                                    double.tryParse(model.longitude ?? "");
                                if (lat != null && lng != null) {
                                  _mapController!.animateCamera(
                                    CameraUpdate.newLatLngZoom(
                                        LatLng(lat, lng), 16),
                                  );
                                }
                              }
                            },
                            child: HomeListTileWidget(
                              id: model.id.toString(),
                              img: model.cover,
                              isFav: response.data!.data[index].isWishlisted,
                              locationAddress: model.address,
                              distance: model.distance.toString(),
                              ratting: model.averageRating.toString(),
                              totalReview: model.totalReview.toString(),
                              resturentType: model.type,
                              name: model.venueName,
                              
                              onFavTap: () {
                                setState(() {
                                 
                                });
                              },
                            ),
                          );
                        },
                      );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ViewTypeSelectorWidget extends StatelessWidget {
  final UserHomeProvider provider;
  const ViewTypeSelectorWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.c282828,
        border: Border.all(width: 0.5.w, color: AppColors.c535353),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => provider.tabIndex(1),
              child: Container(
                alignment: Alignment.center,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: provider.selectedIndex == 1
                      ? AppColors.cFE5401
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Map",
                  style: provider.selectedIndex == 1
                      ? TextFontStyle.headline16w700c222222Poppins
                          .copyWith(color: AppColors.cFFFFFF)
                      : TextFontStyle.headline16w400CFFFFFFPoppins
                          .copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => provider.tabIndex(2),
              child: Container(
                alignment: Alignment.center,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: provider.selectedIndex == 2
                      ? AppColors.cFE5401
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "List",
                  style: provider.selectedIndex == 2
                      ? TextFontStyle.headline16w700c222222Poppins
                          .copyWith(color: AppColors.cFFFFFF)
                      : TextFontStyle.headline16w400CFFFFFFPoppins
                          .copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSearchWidget extends StatelessWidget {
  final TextEditingController searchCnt;
  const HomeSearchWidget({super.key, required this.searchCnt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomFormField(
            contentPadding: const EdgeInsets.all(0),
            hintText: "Search",
            controller: searchCnt,
            prefixIcon: Icon(CupertinoIcons.search, size: 18.sp),
            textInputAction: TextInputAction.search,
          ),
        ),
        UIHelper.horizontalSpaceSmall,
        GestureDetector(
          onTap: () => NavigationService.navigateTo(Routes.filterScreen),
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
      ],
    );
  }
}