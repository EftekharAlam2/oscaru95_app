import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

/// Singleton service to manage nearest shops data in storage
/// This service loads the data from assets once after login and caches it
/// for use throughout the app lifecycle
class VenueStorageService {
  static final VenueStorageService _instance = VenueStorageService._internal();
  
  factory VenueStorageService() => _instance;
  
  VenueStorageService._internal();

  final GetStorage _storage = GetStorage();
  static const String _storageKey = 'nearest_shops_data';
  
  /// Load nearest shops data from assets and store it
  /// This should be called after successful login
  Future<void> loadAndStoreVenueData() async {
    try {
      log('Loading venue data from assets...');
      final String jsonString = 
          await rootBundle.loadString('assets/data/nearest_shops.json');
      
      // Store the raw JSON string
      await _storage.write(_storageKey, jsonString);
      log('Venue data successfully stored in local storage');
    } catch (e) {
      log('Error loading and storing venue data: $e');
      rethrow;
    }
  }

  /// Get the stored venue data as a JSON string
  /// Returns null if no data is stored
  String? getStoredVenueData() {
    try {
      final data = _storage.read(_storageKey);
      return data;
    } catch (e) {
      log('Error reading venue data from storage: $e');
      return null;
    }
  }

  /// Get the stored venue data as parsed JSON Map
  /// Returns null if no data is stored or parsing fails
  Map<String, dynamic>? getStoredVenueDataAsJson() {
    try {
      final jsonString = getStoredVenueData();
      if (jsonString == null) return null;
      
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      log('Error parsing venue data from storage: $e');
      return null;
    }
  }

  /// Check if venue data exists in storage
  bool hasStoredVenueData() {
    return _storage.hasData(_storageKey);
  }

  /// Clear the stored venue data
  /// This can be called on logout
  Future<void> clearVenueData() async {
    try {
      await _storage.remove(_storageKey);
      log('Venue data cleared from storage');
    } catch (e) {
      log('Error clearing venue data: $e');
    }
  }

  /// Get a specific shop by ID from stored data
  /// Returns null if not found or data not available
  Map<String, dynamic>? getShopById(String id) {
    try {
      final jsonData = getStoredVenueDataAsJson();
      if (jsonData == null) return null;

      final shopsList = jsonData['data']?['data'] as List?;
      if (shopsList == null) return null;

      return shopsList.firstWhere(
        (item) => item['id'].toString() == id,
        orElse: () => null,
      );
    } catch (e) {
      log('Error getting shop by ID: $e');
      return null;
    }
  }
}
