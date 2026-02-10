import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/features/user/profile/model/list_of_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class FoodListApi {
  static final FoodListApi _singleton = FoodListApi._internal();
  FoodListApi._internal();

  static FoodListApi get instance => _singleton;

  Future<FoodListModel> getList(String id) async {
    try {
      // Load from local JSON data
      final String jsonString =
          await rootBundle.loadString('assets/data/nearest_shops.json');
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
