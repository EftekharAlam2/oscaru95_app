import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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
      Response response = await getHttp(EndPoints.homeShopProfile(id));
      if (response.statusCode == 200) {
        final data = FoodListModel.fromRawJson(json.encode(response.data));
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
