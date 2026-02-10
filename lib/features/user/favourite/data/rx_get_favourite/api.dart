import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/features/user/favourite/model/favourite_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetFavouriteApi {
  static final GetFavouriteApi _singleton = GetFavouriteApi._internal();
  GetFavouriteApi._internal();

  static GetFavouriteApi get instance => _singleton;
  
  // In-memory set to track favorited shop IDs
  static final Set<String> _favoritedIds = {};
  
  Set<String> get favoritedIds => _favoritedIds;

  Future<FavouriteResponse> getFavourite() async {
    try {
      // Load from local JSON data
      final String jsonString =
          await rootBundle.loadString('assets/data/nearest_shops.json');
      final dynamic jsonData = json.decode(jsonString);
      
      // Filter shops to only include favorited items
      final allShops = jsonData['data']['data'] as List;
      final favoritedShops = allShops.where((shop) {
        return _favoritedIds.contains(shop['id'].toString());
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
  }
  
  bool isFavorited(String shopId) {
    return _favoritedIds.contains(shopId);
  }
}
