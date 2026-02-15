import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';
import 'package:oscaru95/services/venue_storage_service.dart';

final class GetDiscoverApi {
  static final GetDiscoverApi _singleton = GetDiscoverApi._internal();
  GetDiscoverApi._internal();

  static GetDiscoverApi get instance => _singleton;

  Future<DiscoverResponse> getDiscover() async {
    try {
      // Try to load from storage first
      final storageService = VenueStorageService();
      String? jsonString = storageService.getStoredVenueData();
      
      // Fallback to loading from assets if not in storage
      if (jsonString == null) {
        log('Venue data not found in storage, loading from assets...');
        jsonString = await rootBundle.loadString('assets/data/nearest_shops.json');
      } else {
        log('Loading venue data from storage');
      }
      
      final dynamic jsonData = json.decode(jsonString);

      // Use the shops data for discover
      final data = DiscoverResponse.fromJson({
        'success': true,
        'message': 'Discover data retrieved successfully',
        'data': jsonData['data']['data'],
        'code': 200
      });
      return data;
    } catch (e) {
      log('Error loading discover data: $e');
      rethrow;
    }
  }
}
