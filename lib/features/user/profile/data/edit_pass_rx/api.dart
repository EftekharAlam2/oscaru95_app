import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/profile/model/password_response.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class UpdatePasswordApi {
  static final UpdatePasswordApi _singleton = UpdatePasswordApi._internal();
  UpdatePasswordApi._internal();
  static UpdatePasswordApi get instance => _singleton;

  Future<PasswordResponse> editPassword({
    required String currentPass,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "current_password": currentPass,
        "password": password,
        "password_confirmation": confirmPassword,
      });

      Response response = await postHttp(EndPoints.updatePassword(), data);

      if (response.statusCode == 200) {
        final data = PasswordResponse.fromRawJson(json.encode(response.data));

        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
