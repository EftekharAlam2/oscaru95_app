import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class DeleteBusinessProfileApi {
  static final DeleteBusinessProfileApi _singleton =
      DeleteBusinessProfileApi._internal();
  DeleteBusinessProfileApi._internal();

  static DeleteBusinessProfileApi get instance => _singleton;

  Future<Map> deleteBusinessProfile() async {
    try {
      Response response = await deleteHttp(EndPoints.deleteBusinessProfile());
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
