/* import 'dart:convert';
import 'package:dio/dio.dart';
import '/networks/endpoints.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class SignUpApi {
  static final SignUpApi _singleton = SignUpApi._internal();
  SignUpApi._internal();
  static SignUpApi get instance => _singleton;
  Future<Map> postSignUp({
    required String firstName,
    required String lastName,
    required String gender,
    required String dob,
    required String postCode,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required File avatar,
  }) async {
    try {
      Map data = {
        "f_name": firstName,
        "l_name": lastName,
        "gender": gender,
        "dob": dob,
        "zip_code": postCode,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": confirmPassword,
        'avatar' : avatar
      };
      Response response = await postHttp(Endpoints.signUp(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow; //ErrorHandler.handle(error).failure;
    }
  }
} */