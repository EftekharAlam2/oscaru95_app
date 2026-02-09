// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/profile/data/feedback_rx/api.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';

final class FeedBackRx extends RxResponseInt {
  String? otp;
  final api = FeedBackApi.instance;

  FeedBackRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> feedBack({
    required int rating,
    required String comment,
  }) async {
    try {
      final data = await api.feedBack(rating: rating, comment: comment);
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
