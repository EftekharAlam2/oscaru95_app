// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController mapController;
  LatLng? selectedLocation;
  String selectedAddress = "Tap on the map to pick a location";
  Marker? selectedMarker;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  final itemList = [
    'Manually',
    'Map',
  ];

  final selectedIndex = 0;

  /// Get the user's current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
      selectedMarker = Marker(
        markerId: const MarkerId("selected"),
        position: selectedLocation!,
      );
    });

    _getAddressFromLatLng(selectedLocation!);
  }

  /// Convert LatLng to Address using Geocoding
  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        setState(() {
          selectedAddress =
              "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}";
        });
      }
    } catch (e) {
      log("Error getting address: $e");
      setState(() {
        selectedAddress = "Address not found";
      });
    }
  }

  /// When the user taps on the map, move the marker to the new position
  void _onMapTapped(LatLng latLng) {
    setState(() {
      selectedLocation = latLng;
      selectedMarker = Marker(
        markerId: const MarkerId("selected"),
        position: latLng,
      );
    });

    _getAddressFromLatLng(latLng);
  }

  // For index 1
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> placePredictions = [];
  final String apiKey = "AIzaSyBXhT7P_Bqk6WpLdXxAieADGHpwnm34hCc";

  /// Fetch autocomplete suggestions from Google Places API
  Future<void> fetchPlaceSuggestions(String input) async {
    if (input.isEmpty) return;

    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        setState(() {
          placePredictions = data['predictions'].map<Map<String, dynamic>>((p) {
            return {
              "place_id": p['place_id'],
              "description": p['description'],
            };
          }).toList();

          log("Data is $placePredictions");
        });
      }
    }
  }

  /// Fetch place details (lat/lng) when a place is selected
  Future<void> fetchPlaceDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['result']['geometry']['location'];

        Navigator.pop(context, {
          "address": data['result']['formatted_address'],
          "latitude": location['lat'],
          "longitude": location['lng'],
        });
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: const Text("Location Selected"),
        //       content: Text(
        //         "Address: ${data['result']['formatted_address']}\n"
        //         "Latitude: ${location['lat']}\n"
        //         "Longitude: ${location['lng']}",
        //       ),
        //       actions: [
        //         TextButton(
        //           onPressed: () => Navigator.pop(context),
        //           child: const Text("OK"),
        //         ),
        //       ],
        //     );
        //   },
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: selectedLocation!,
                          zoom: 15,
                        ),
                        onMapCreated: (controller) {
                          mapController = controller;
                        },
                        markers:
                            selectedMarker != null ? {selectedMarker!} : {},
                        onTap: _onMapTapped,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: CustomButton(
                          onTap: () {
                            Navigator.pop(context, {
                              "address": selectedAddress,
                              "latitude": selectedLocation!.latitude,
                              "longitude": selectedLocation!.longitude,
                            });
                          },
                          btnName: "Confirm Location",
                          textStaus: false,
                        ),
                      ),
                      Positioned.fill(
                        left: 20.w,
                        right: 20.w,
                        child: SafeArea(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      NavigationService.goBack;
                                    },
                                    child: Container(
                                      height: 45.h,
                                      width: 45.w,
                                      padding: EdgeInsets.all(12.sp),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.cFFFFFF,
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.icons.arrowBackIcon,
                                        width: 20.w,
                                        color: AppColors.c000000,
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  Expanded(
                                    child: TextFormField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: "Write place name",
                                        filled: true,
                                        fillColor: AppColors.cFFFFFF,
                                        isDense: true,
                                        prefixIcon: const Icon(Icons.search),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          setState(() {
                                            placePredictions.clear();
                                          });
                                        } else {
                                          fetchPlaceSuggestions(value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              placePredictions.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: placePredictions.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(left: 56.h),
                                          decoration: const BoxDecoration(
                                            color: AppColors.cFFFFFF,
                                          ),
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.location_on,
                                                color: Colors.blue),
                                            title: Text(placePredictions[index]
                                                ['description']),
                                            onTap: () {
                                              fetchPlaceDetails(
                                                  placePredictions[index]
                                                      ['place_id']);
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
