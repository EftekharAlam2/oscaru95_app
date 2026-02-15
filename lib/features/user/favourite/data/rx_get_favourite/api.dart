import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oscaru95/features/user/favourite/model/favourite_response.dart';
import 'package:oscaru95/services/venue_storage_service.dart';

final class GetFavouriteApi {
  static final GetFavouriteApi _singleton = GetFavouriteApi._internal();
  GetFavouriteApi._internal() {
    _initStorage();
  }

  static GetFavouriteApi get instance => _singleton;
  
  static const String _storageKey = 'fav_ids';
  final GetStorage _box = GetStorage();

  // In-memory set to track favorited shop IDs
  static final Set<String> _favoritedIds = {};
  
  Set<String> get favoritedIds => _favoritedIds;

  void _initStorage() {
    try {
      final List<dynamic>? stored = _box.read<List<dynamic>>(_storageKey);
      if (stored != null) {
        for (var id in stored) {
          _favoritedIds.add(id.toString());
        }
      }
    } catch (e) {
      log('Error initializing favorite storage: $e');
    }
  }

  Future<void> _saveToStorage() async {
    try {
      await _box.write(_storageKey, _favoritedIds.toList());
    } catch (e) {
      log('Error saving favorites to storage: $e');
    }
  }

  Future<FavouriteResponse> getFavourite() async {
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
      
      // If no favorites have been tracked yet, initialize from JSON is_wishlisted
      if (_favoritedIds.isEmpty) {
        try {
          final allShopsInit = jsonData['data']?['data'] as List? ?? [];
          for (var shop in allShopsInit) {
            final isWish = shop['is_wishlisted'];
            // Accept boolean, int(1), or string '1' as truthy
            final bool marked = (isWish is bool && isWish) ||
                (isWish is int && isWish == 1) ||
                (isWish is String && (isWish == '1' || isWish.toLowerCase() == 'true'));
            if (marked) {
              _favoritedIds.add(shop['id'].toString());
            }
          }
          // persist initial favorites if any
          await _saveToStorage();
        } catch (e) {
          // ignore initialization errors, continue
          log('Error initializing favorites from JSON: $e');
        }
      }

      // Filter shops to only include favorited items (either tracked in-memory or flagged in JSON)
      final allShops = (jsonData['data']?['data'] as List?) ?? [];
      final favoritedShops = allShops.where((shop) {
        final shopIdStr = shop['id'].toString();
        final isWish = shop['is_wishlisted'];
        final bool marked = (isWish is bool && isWish) ||
            (isWish is int && isWish == 1) ||
            (isWish is String && (isWish == '1' || isWish.toLowerCase() == 'true'));
        return _favoritedIds.contains(shopIdStr) || marked;
      }).map((shop) {
        // Normalize the map to include the expected `is_favourite` key
        final normalized = Map<String, dynamic>.from(shop as Map);
        final isWish = shop['is_wishlisted'];
        final bool marked = (isWish is bool && isWish) ||
            (isWish is int && isWish == 1) ||
            (isWish is String && (isWish == '1' || isWish.toLowerCase() == 'true'));
        // Use '1'/'0' strings to be safe with model expecting string
        normalized['is_favourite'] = marked ? '1' : '0';
        return normalized;
      }).toList();
      
      final responseMap = {
        'success': true,
        'message': 'Favourites retrieved successfully',
        'data': favoritedShops,
        'code': 200
      };
      
      final data = FavouriteResponse.fromJson(responseMap);
      return data;
    } catch (e) {
      log('Error loading favourite data: $e');
      rethrow;
    }
  }
  
  // Toggle favorite status for a shop
  void toggleFavorite(String shopId) {
    if (_favoritedIds.contains(shopId)) {
      _favoritedIds.remove(shopId);
    } else {
      _favoritedIds.add(shopId);
    }
    // persist
    _saveToStorage();
  }
  
  bool isFavorited(String shopId) {
    return _favoritedIds.contains(shopId);
  }
}
