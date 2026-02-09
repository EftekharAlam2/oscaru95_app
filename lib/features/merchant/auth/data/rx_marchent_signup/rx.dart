import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/model/user_signup_response.dart';
import 'package:oscaru95/features/merchant/auth/data/rx_marchent_signup/api.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';

final class UserMarchentRx extends RxResponseInt<UserSignupResponse> {
  String? otp;
  final api = UserMarchentApi.instance;

  UserMarchentRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> userSignup({
    required int establishmentId,
    required String venueName,
    required String email,
    required String password,
    required String confPass,
    required File? covers,
    required String phone,
    required String address,
    required String openHour,
    required String closeHour,
    File? menu,
    required String latitude,
    required String longitude,
  }) async {
    try {
      final data = await api.userSignup(
        email: email,
        password: password,
        confPass: confPass,
        covers: covers,
        phone: phone,
        menu: menu,
        latitude: latitude,
        longitude: longitude,
        establishmentId: establishmentId,
        venueName: venueName,
        address: address,
        openHour: openHour,
        closeHour: closeHour,
      );
      handleSuccessWithReturn(data);
      otp = data.data?.otp.toString();
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final msg = error.response?.data["message"] ?? "Unknown Error";
      ToastUtil.showShortToast(msg);
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
