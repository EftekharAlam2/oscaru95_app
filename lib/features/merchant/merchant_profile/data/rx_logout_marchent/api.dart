import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class MarchentLogoutApi {
  static final MarchentLogoutApi _singleton = MarchentLogoutApi._internal();
  MarchentLogoutApi._internal();

  static MarchentLogoutApi get instance => _singleton;

  Future<Map> marchentLogout() async {
    try {
      Response response = await postHttp(EndPoints.marchentLogout());
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
