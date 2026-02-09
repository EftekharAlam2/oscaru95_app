import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/favourite/model/favourite_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetFavouriteApi {
  static final GetFavouriteApi _singleton = GetFavouriteApi._internal();
  GetFavouriteApi._internal();

  static GetFavouriteApi get instance => _singleton;

  Future<FavouriteResponse> getFavourite() async {
    try {
      Response response = await getHttp(EndPoints.favourite());
      if (response.statusCode == 200) {
        final data = FavouriteResponse.fromRawJson(json.encode(response.data));
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
