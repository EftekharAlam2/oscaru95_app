// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/data/rx_user_signup/api.dart';
import 'package:oscaru95/features/auth/model/user_signup_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';

final class UserSignupRx extends RxResponseInt<UserSignupResponse> {
  String? otp;
  final api = UserSignupApi.instance;

  UserSignupRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> userSignup({
    required String fName,
    required String lName,
    required String email,
    required String password,
    required String confPass,
    File? avatar,
    required String phone,
    required String dob,
    required String gender,
    required String zipCode,
    required String location,
    required String latitude,
    required String longitude,
    required String address,
  }) async {
    try {
      log("User Signup RX - Starting signup process");
      final data = await api.userSignup(
        fName: fName,
        lName: lName,
        email: email,
        password: password,
        confPass: confPass,
        avatar: avatar,
        phone: phone,
        dob: dob,
        gender: gender,
        zipCode: zipCode,
        address: address,
        location: location,
        latitude: latitude, 
        longitude: longitude,
      );
      log("User Signup RX - API Response received");
      handleSuccessWithReturn(data);
      otp = data.data!.otp.toString();
      log("User Signup RX - OTP: $otp");
      return true;
    } catch (error) {
      log("User Signup RX - Error: $error");
      return handleErrorWithReturn(error);
    }
  }

  // @override
  // handleSuccessWithReturn(LoginResponse data) {
  //   appData.write(kKeyAccessToken, data.data!.token!);
  //   appData.write(kKeyRole, data.data!.role!);
  //   appData.write(kKeyIsLoggedIn, true);
  //   String token = appData.read(kKeyAccessToken);
  //   DioSingleton.instance.update(token);

  //   dataFetcher.sink.add(data);
  //   return data;
  // }

  @override
  handleErrorWithReturn(dynamic error) {
    log("=== Signup Error Handler ===");
    log("Error Type: ${error.runtimeType}");

    if (error is DioException) {
      log("DioException Status Code: ${error.response?.statusCode}");
      log("DioException Response: ${error.response?.data}");
      log("DioException Message: ${error.message}");

      if (error.response != null && error.response!.data is Map) {
        String errorMessage = error.response!.data["message"] ?? "An error occurred";
        log("Error Message: $errorMessage");
        ToastUtil.showShortToast(errorMessage);
      } else {
        ToastUtil.showShortToast(error.message ?? "Signup failed");
      }
    } else {
      log("Error: $error");
      ToastUtil.showShortToast(error.toString());
    }

    dataFetcher.sink.addError(error);
    return false;
  }
}
