import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_food_special/model/food_special_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetFoodSpecialApi {
  static final GetFoodSpecialApi _singleton = GetFoodSpecialApi._internal();
  GetFoodSpecialApi._internal();

  static GetFoodSpecialApi get instance => _singleton;

  Future<FoodSpecialResponse> getFoodSpecial() async {
    try {
      Response response = await getHttp(EndPoints.getFoodSpecial());
      if (response.statusCode == 200) {
        final data =
            FoodSpecialResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        log('Error: ${response.statusCode}');
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
