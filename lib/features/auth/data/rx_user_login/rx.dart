// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/data/rx_user_login/api.dart';
import 'package:oscaru95/features/auth/model/user_login_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../constants/app_constants.dart';
import '../../../../../../helpers/di.dart';
import '../../../../../../networks/rx_base.dart';

final class UserLoginRX extends RxResponseInt<UserLoginResponse> {
  String? role;
  final api = UserLoginApi.instance;

  UserLoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      // final data = await api.login(id: id);
      // handleSuccessWithReturn(data);
      final data = await api.userLogin(
        email: email,
        password: password,
      );
      handleSuccessWithReturn(data);
      role = data.data?.role;
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(UserLoginResponse data) {
    log("User Login Successful");
    appData.write(kKeyAccessToken, data.data!.token!);
    appData.write(kKeyRole, data.data!.role!);
    appData.write(KKeyUserId, data.data!.id!);
    appData.write(kKeyIsLoggedIn, true);

    String token = appData.read(kKeyAccessToken);
    DioSingleton.instance.update(token);

    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        log(error.response!.data['message']);
      } else {
        log(error.response!.statusCode.toString());
      }
    }
    // log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
