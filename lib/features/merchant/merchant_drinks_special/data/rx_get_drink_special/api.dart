import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_drinks_special/model/drink_special_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetDrinkSpecialApi {
  static final GetDrinkSpecialApi _singleton = GetDrinkSpecialApi._internal();
  GetDrinkSpecialApi._internal();

  static GetDrinkSpecialApi get instance => _singleton;

  Future<DrinkSpecialResponse> getDrinkSpecial() async {
    try {
      Response response = await getHttp(EndPoints.getDrinkSpecial());
      if (response.statusCode == 200) {
        final data =
            DrinkSpecialResponse.fromRawJson(json.encode(response.data));
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
