import 'dart:convert';

import 'package:dio/dio.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class AddFavouriteApi {
  static final AddFavouriteApi _singleton = AddFavouriteApi._internal();
  AddFavouriteApi._internal();
  static AddFavouriteApi get instance => _singleton;

  Future<Map> addToFavourite({required String id}) async {
    try {
      Map data = {
        "business_profile_id": id,
      };

      Response response = await postHttp(EndPoints.addToFavourite(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
