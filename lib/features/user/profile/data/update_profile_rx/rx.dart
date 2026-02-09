// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/profile/data/update_profile_rx/api.dart';
import 'package:oscaru95/features/user/profile/model/update_profile.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';

final class UpdateProfileRx extends RxResponseInt<UpdateProfileModel> {
  String? otp;
  final api = UpdateProfileApi.instance;

  UpdateProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> updateProfile({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String gender,
    File? avatar,
    required String dob,
    required String zipCode,
    required String address,
    required String latitude,
    required String longitude,
  }) async {
    try {
      final data = await api.updateProfle(
          fName: fName,
          lName: lName,
          email: email,
          phone: phone,
          gender: gender,
          avatar: avatar,
          dob: dob,
          zipCode: zipCode,
          address: address,
          latitude: latitude,
          longitude: longitude);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
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
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
