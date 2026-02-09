import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/model/user_login_response.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class UserLoginApi {
  static final UserLoginApi _singleton = UserLoginApi._internal();
  UserLoginApi._internal();
  static UserLoginApi get instance => _singleton;

  Future<UserLoginResponse> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      Map data = {
        "email": email,
        "password": password,
      };

      Response response = await postHttp(EndPoints.login(), data);

      if (response.statusCode == 200) {
        final data = UserLoginResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
