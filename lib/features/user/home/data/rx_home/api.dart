import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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
      Response response = await getHttp(EndPoints.getNearest());
      if (response.statusCode == 200) {
        final data =
            NearestShopResponse.fromRawJson(json.encode(response.data));
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
