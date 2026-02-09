import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/setting/model/status_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class StatusApi {
  static final StatusApi _singleton = StatusApi._internal();
  StatusApi._internal();

  static StatusApi get instance => _singleton;

  Future<StatusModel> getStatus() async {
    try {
      Response response = await getHttp(EndPoints.status());
      if (response.statusCode == 200) {
        final data = StatusModel.fromRawJson(json.encode(response.data));
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
