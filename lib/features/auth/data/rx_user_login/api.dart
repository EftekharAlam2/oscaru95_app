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

      // Use a per-request option to ensure Authorization header is not sent
      Response response = await DioSingleton.instance.dio.post(
        EndPoints.login(),
        data: data,
        options: Options(headers: {
          // Explicitly clear Authorization for login endpoint
          NetworkConstants.AUTHORIZATION: null,
          NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
          // Ensure content-type is JSON for login
          'content-type': 'application/json',
        }),
        cancelToken: DioSingleton.cancelToken,
      );

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
