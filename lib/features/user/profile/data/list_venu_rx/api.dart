import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/features/user/profile/model/list_of_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';
import 'package:oscaru95/services/venue_storage_service.dart';

final class FoodListApi {
  static final FoodListApi _singleton = FoodListApi._internal();
  FoodListApi._internal();

  static FoodListApi get instance => _singleton;

  Future<FoodListModel> getList(String id) async {
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
      
      // Find the shop with matching id
      final shopsList = jsonData['data']['data'] as List;
      final shop = shopsList.firstWhere(
        (item) => item['id'].toString() == id,
        orElse: () => shopsList.isNotEmpty ? shopsList[0] : null,
      );
      
      if (shop != null) {
        final data = FoodListModel.fromJson({
          'success': true,
          'message': 'Shop profile retrieved successfully',
          'data': shop,
          'code': 200
        });
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      log('Error loading shop data: $e');
      rethrow;
    }
  }
}
