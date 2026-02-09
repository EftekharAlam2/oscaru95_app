import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/registration/model/drink_registarion_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';


final class AddItemApi {
  static final AddItemApi _singleton = AddItemApi._internal();
  AddItemApi._internal();
  static AddItemApi get instance => _singleton;

  Future<AddItemModel> itemPost({
    required int categoryId,
    required String type,
    required List<Map<String, dynamic>> itemList,
    required List<Map<String,dynamic>>itemHours
  }) async {
    try {
      // Prepare the request data
      Map data = {
        "category_id": categoryId,
        "type": type,
        "item_lists": itemList,
        "item_hours":itemHours
      };

      log("Request Data =================> $data");

      // API request
      Response response = await postHttp(EndPoints.addItemInfo(), data);

      // Handle the response
      if (response.statusCode == 201) {
        AddItemModel data =
            AddItemModel.fromRawJson(json.encode(response.data));
        return data;
      } else if (response.statusCode == 200) {
        AddItemModel data =
            AddItemModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw Exception('Failed to create challenge');
      }
    } catch (e) {
      rethrow;
    }
  }
}