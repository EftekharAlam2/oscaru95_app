import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_profile/model/menu_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetMenuApi {
  static final GetMenuApi _singleton = GetMenuApi._internal();
  GetMenuApi._internal();

  static GetMenuApi get instance => _singleton;

  Future<MenuModel> getMenu() async {
    try {
      Response response = await getHttp(EndPoints.menuInfo());
      if (response.statusCode == 200) {
        final data = MenuModel.fromRawJson(json.encode(response.data));
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
