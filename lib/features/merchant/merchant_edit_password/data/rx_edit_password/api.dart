import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class BusniessEditPassApi {
  static final BusniessEditPassApi _singleton = BusniessEditPassApi._internal();
  BusniessEditPassApi._internal();

  static BusniessEditPassApi get instance => _singleton;

  Future<Map> updatePassword({
    required String oldPass,
    required String password,
    required String confPass,
  }) async {
    try {
      Map data = {
        "current_password": oldPass,
        "password": password,
        "password_confirmation": confPass,
      };
      Response response =
          await postHttp(EndPoints.editBusinessPassword(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
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
