import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/features/user/home/model/nearest_shop_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetNearestApi {
  static final GetNearestApi _singleton = GetNearestApi._internal();
  GetNearestApi._internal();

  static GetNearestApi get instance => _singleton;

  Future<NearestShopResponse> getNearest() async {
    try {
      // Load the local JSON file
      final String jsonString =
          await rootBundle.loadString('assets/data/nearest_shops.json');
      final dynamic jsonData = json.decode(jsonString);
      
      // Parse the JSON to NearestShopResponse
      final data = NearestShopResponse.fromJson(jsonData);
      return data;
    } catch (e) {
      log('Error loading local data: $e');
      rethrow;
    }
  }
}
