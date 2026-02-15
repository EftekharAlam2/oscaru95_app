import 'dart:convert';
import 'dart:developer';

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
import 'package:oscaru95/services/venue_storage_service.dart';
import 'package:provider/provider.dart';

class MerchantDeshBoardScreen extends StatefulWidget {
  const MerchantDeshBoardScreen({super.key});

  @override
  State<MerchantDeshBoardScreen> createState() =>
      _MerchantDeshBoardScreenState();
}

class _MerchantDeshBoardScreenState extends State<MerchantDeshBoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchCnt = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  Set<Marker> _markers = {};
  List<LocationData> _filteredShops = [];

  BitmapDescriptor? _resturent;
  BitmapDescriptor? _bar;
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
    _getCurrentLocation();
    getNearestRx.getNearest();
    _fetchNearestShops();
    _loadNearestShopsFromJson();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCnt.dispose();
    super.dispose();
  }

  Future<void> _loadCustomMarkers() async {
    _resturent = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(64, 64)),
      "assets/images/shopLocation1.png",
    );

    _bar = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(64, 64)),
      "assets/images/shopLocation.png",
    );

    if (mounted) setState(() {});
  }

  void _focusCameraOnCurrentLocation() {
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 14),
        ),
      );
    }
  }

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

  void _createMarkers(NearestShopResponse response) {
    if (_currentPosition == null) return;

    Set<Marker> markers = {};
    List<LocationData> tempFilteredShops = [];

    final defaultMarker = _resturent ?? BitmapDescriptor.defaultMarker;

    for (var shop in response.data!.data!) {

      if (shop.latitude != null && shop.longitude != null) {
        final lat = double.tryParse(shop.latitude!);
        final lng = double.tryParse(shop.longitude!);

        if (lat != null && lng != null) {
          tempFilteredShops.add(shop);

          BitmapDescriptor icon;

          if (shop.type == 'Restaurant' && _bar != null) {
            icon = _bar!;
          } else if (shop.type == 'Bar' && _resturent != null) {
             icon = _resturent!;
          }
          else {
            icon = defaultMarker;
          }

          markers.add(
            Marker(
              markerId: MarkerId(shop.id.toString()),
              position: LatLng(lat, lng),
              icon: icon,
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

  Future<void> _loadNearestShopsFromJson() async {
    try {
      // Try to load from storage first
      final storageService = VenueStorageService();
      String? jsonString = storageService.getStoredVenueData();
      
      // Fallback to loading from assets if not in storage
      if (jsonString == null) {
        log('Venue data not found in storage, loading from assets...');
        jsonString = await DefaultAssetBundle.of(context)
            .loadString('assets/data/nearest_shops.json');
      }
      
      final jsonResponse = jsonDecode(jsonString);
      final response = NearestShopResponse.fromJson(jsonResponse);

      if (mounted && response.data != null && response.data!.data.isNotEmpty) {
        _createMarkersFromJson(response);
      }
    } catch (error) {
      debugPrint("Error loading shops from JSON: $error");
    }
  }

  void _createMarkersFromJson(NearestShopResponse response) {
    Set<Marker> markers = {};

    final defaultMarker = _resturent ?? BitmapDescriptor.defaultMarker;

    for (var shop in response.data!.data!) {
      if (shop.latitude != null && shop.longitude != null) {
        final lat = double.tryParse(shop.latitude!);
        final lng = double.tryParse(shop.longitude!);

        if (lat != null && lng != null) {
          BitmapDescriptor icon;

          if (shop.type == 'Restaurant' && _bar != null) {
            icon = _bar!;
          } else if (shop.type == 'Bar' && _resturent != null) {
            icon = _resturent!;
          } else {
            icon = defaultMarker;
          }

          markers.add(
            Marker(
              markerId: MarkerId(shop.id.toString()),
              position: LatLng(lat, lng),
              icon: icon,
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Consumer<UserHomeProvider>(
          builder: (context, provider, child) {
            return ViewTypeSelectorWidget(provider: provider);
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

            LatLng? initialTarget;
            if (response.data?.data?.isNotEmpty == true) {
              final firstShop = response.data!.data!.first;
              final lat = double.tryParse(firstShop.latitude ?? '0.0');
              final lng = double.tryParse(firstShop.longitude ?? '0.0');
              if (lat != null && lng != null && lat != 0.0 && lng != 0.0) {
                initialTarget = LatLng(lat, lng);
              }
            }
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
                              isFav: getFavouriteRx.api.isFavorited(model.id.toString()),
                              locationAddress: model.address,
                              distance: model.distance.toString(),
                              ratting: model.averageRating.toString(),
                              totalReview: model.totalReview.toString(),
                              resturentType: model.type,
                              name: model.venueName,

                              onFavTap: () {
                                addFavouriteRx.addToFavourite(id: model.id.toString());
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
