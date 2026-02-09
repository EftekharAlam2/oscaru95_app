import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class UserLogoutApi {
  static final UserLogoutApi _singleton = UserLogoutApi._internal();
  UserLogoutApi._internal();

  static UserLogoutApi get instance => _singleton;

  Future<Map> userLogout() async {
    try {
      Response response = await postHttp(EndPoints.logout());
      if (response.statusCode == 200) {
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
