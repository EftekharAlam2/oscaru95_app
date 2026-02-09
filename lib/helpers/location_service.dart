import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/app_constants.dart';
import 'di.dart';

class LocationService {
  static Position? currentPosition;

  static Future<void> requestPermissions() async {
    // Check the current status of permissions
    var statuses = await [
      Permission.location,
      Permission.photos,
    ].request();

    // Check if all permissions are granted
    if (statuses[Permission.location]?.isGranted == true &&
        statuses[Permission.photos]?.isGranted == true) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      await appData.write(kKeySelectedLat, currentPosition!.latitude);
      await appData.write(kKeySelectedLng, currentPosition!.longitude);
      getLocation();
    } else {
      // Handle denied permissions
      openAppSettings();
    }
  }

  Future<void> getCurrentLocationAndSave() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("Location services are disabled");
      return;
    }

    // Check for location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Location permissions are denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("Location permissions are permanently denied");
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Save latitude and longitude to GetStorage
    await appData.write(kKeySelectedLat, position.latitude);
    await appData.write(kKeySelectedLng, position.longitude);
    getLocation();
    log("Location saved: Latitude: ${position.latitude}, Longitude: ${position.longitude}");
  }
}

void getLocation() async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    appData.read(kKeySelectedLat),
    appData.read(kKeySelectedLng),
  );

  if (placemarks.isNotEmpty) {
    Placemark place = placemarks[0];

    // location =
    //     "${place.locality},  ${place.administrativeArea},  ${place.country}";
    var location = "${place.locality}, ${place.country}";
    appData.write(kKeySelectedLocation, location);
    log("Saved location $location}");
  } else {}
}
