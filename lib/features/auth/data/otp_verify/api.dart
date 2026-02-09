import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/model/verifyOtp_model.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class OtpVerifyApi {
  static final OtpVerifyApi _singleton = OtpVerifyApi._internal();
  OtpVerifyApi._internal();
  static OtpVerifyApi get instance => _singleton;

  Future<VerifyOtpModel> verifiyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      Map data = {
        "email": email,
        "otp": otp,
      };

      Response response = await postHttp(EndPoints.verifyOtp(), data);

      if (response.statusCode == 200) {
        final data = VerifyOtpModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
