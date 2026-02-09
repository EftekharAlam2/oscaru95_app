import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class DeleteUserProfileApi {
  static final DeleteUserProfileApi _singleton =
      DeleteUserProfileApi._internal();
  DeleteUserProfileApi._internal();

  static DeleteUserProfileApi get instance => _singleton;

  Future<Map> deleteUserProfile() async {
    try {
      Response response = await deleteHttp(EndPoints.deleteUserProfile());
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
