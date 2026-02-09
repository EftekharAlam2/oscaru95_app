import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/merchant_profile/data/post_gallary_rx/api.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class StoryUploadrRx extends RxResponseInt<Map> {
  StoryUploadrRx({required super.empty, required super.dataFetcher});

  ValueStream get userLogoutStream => dataFetcher.stream;
  final api = StoryUploadApi.instance;

  Future<bool> story({
    required File image,
  }) async {
    try {
      final data = await api.story(image: image);
      handleSuccessWithReturn(data);

      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  void handleSuccessWithReturn(data) {
    appData.write(kKeyIsLoggedIn, false);
    totalDataClean();
    dataFetcher.sink.add(data);
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 401) {
        totalDataClean();
        appData.write(kKeyIsLoggedIn, false);
        NavigationService.navigateToReplacementUntil(Routes.loginScreen);
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
