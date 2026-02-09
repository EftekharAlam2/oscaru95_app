// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/data/otp_verify/api.dart';
import 'package:oscaru95/features/auth/model/verifyOtp_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../constants/app_constants.dart';
import '../../../../../../helpers/di.dart';
import '../../../../../../networks/rx_base.dart';

final class OtpVerifyRx extends RxResponseInt<VerifyOtpModel> {
  String? role;
  final api = OtpVerifyApi.instance;

  OtpVerifyRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> verifiyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      // final data = await api.login(id: id);
      // handleSuccessWithReturn(data);
      final data = await api.verifiyOtp(
        email: email,
        otp: otp,
      );
      handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(VerifyOtpModel data) {
    log("OTP Verification Successful");

    // Extract and save token from response
    if (data.data?.token != null) {
      appData.write(kKeyAccessToken, data.data!.token!);
      appData.write(kKeyRole, data.data?.role ?? "user");
      appData.write(KKeyUserId, data.data!.id!);
      appData.write(kKeyIsLoggedIn, true);

      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      log("Token saved successfully: ${data.data!.token}");
    }

    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    log("OTP Verification Failed: $error");
    if (error is DioException) {
      log("Error Response: ${error.response?.data}");
      if (error.response!.statusCode == 400) {
        log(error.response!.data['message'] ?? 'OTP verification failed');
      } else {
        log("Status Code: ${error.response!.statusCode}");
      }
    }
    dataFetcher.sink.addError(error);
    return false;
  }
}
