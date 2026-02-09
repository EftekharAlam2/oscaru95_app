// // ignore_for_file: deprecated_member_use

// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hadsongreen/features/google_map/model/google_map_response.dart';
// import 'package:hadsongreen/networks/api_access.dart';

// class AllMapScreen extends StatefulWidget {
//   const AllMapScreen({super.key});

//   @override
//   State<AllMapScreen> createState() => _AllMapScreenState();
// }

// class _AllMapScreenState extends State<AllMapScreen> {
//   GoogleMapController? _mapController;
//   Position? _currentPosition;

//   Set<Marker> markers = {};
//   Set<Polyline> polylines = {};

//   BitmapDescriptor? _markerDone;
//   BitmapDescriptor? _markerPending;

//   @override
//   void initState() {
//     super.initState();
//     _initMap();
//   }

//   Future<void> _initMap() async {
//     await _loadCustomMarkers();
//     await _determinePosition();
//     await workListMapRxObj.workListMap();
//   }

//   /// Resize the marker image to make it smaller
//   Future<BitmapDescriptor> _getResizedMarker(String path, int width) async {
//     final ByteData data = await rootBundle.load(path);
//     final ui.Codec codec = await ui.instantiateImageCodec(
//       data.buffer.asUint8List(),
//       targetWidth: width,
//     );
//     final ui.FrameInfo fi = await codec.getNextFrame();
//     final Uint8List bytes =
//         (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
//     return BitmapDescriptor.fromBytes(bytes);
//   }

//   Future<void> _loadCustomMarkers() async {
//     _markerDone = await _getResizedMarker("assets/images/locationcomplite.png",80 );
//     _markerPending = await _getResizedMarker("assets/images/locationPending.png", 80);
//   }

//   Future<void> _determinePosition() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) return;

//     final position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     setState(() => _currentPosition = position);
//   }

//   void _buildMapData(List<Datum> data) {
//     Set<Marker> tempMarkers = {};
//     List<LatLng> routePoints = [];

//     for (var item in data) {
//       final lat = double.tryParse(item.latitude.toString());
//       final lng = double.tryParse(item.longitude.toString());
//       if (lat == null || lng == null) continue;

//       final LatLng pos = LatLng(lat, lng);
//       routePoints.add(pos);

//       tempMarkers.add(
//         Marker(
//           markerId: MarkerId(item.id.toString()),
//           position: pos,
//           icon: item.isCompleted == true
//               ? (_markerDone ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen))
//               : (_markerPending ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
//           infoWindow: InfoWindow(
//             title: item.team?.name ?? "Team",
//             snippet: item.location ?? "",
//           ),
//         ),
//       );
//     }

//     // Draw polyline route if points exist
//     if (routePoints.length > 1) {
//       polylines = {
//         Polyline(
//           polylineId: const PolylineId('work_route'),
//           color: Colors.blueAccent,
//           width: 4,
//           points: routePoints,
//         ),
//       };
//     }

//     setState(() {
//       markers = tempMarkers;
//     });

//     _fitCameraToBounds(routePoints);
//   }

//   void _fitCameraToBounds(List<LatLng> points) {
//     if (_mapController == null || points.isEmpty) return;

//     double minLat = points.first.latitude;
//     double maxLat = points.first.latitude;
//     double minLng = points.first.longitude;
//     double maxLng = points.first.longitude;

//     for (var p in points) {
//       if (p.latitude < minLat) minLat = p.latitude;
//       if (p.latitude > maxLat) maxLat = p.latitude;
//       if (p.longitude < minLng) minLng = p.longitude;
//       if (p.longitude > maxLng) maxLng = p.longitude;
//     }

//     _mapController!.animateCamera(
//       CameraUpdate.newLatLngBounds(
//         LatLngBounds(
//           southwest: LatLng(minLat, minLng),
//           northeast: LatLng(maxLat, maxLng),
//         ),
//         50, // padding
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder(
//           stream: workListMapRxObj.allTaskValue,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final model = snapshot.data as WorkGoogleResponse;
//             final data = model.data ?? [];

//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _buildMapData(data);
//             });

//             return GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _currentPosition == null
//                     ? const LatLng(23.8103, 90.4125)
//                     : LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//                 zoom: 10,
//               ),
//               markers: markers,
//               polylines: polylines,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//                 Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
//               },
//               onMapCreated: (controller) => _mapController = controller,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
