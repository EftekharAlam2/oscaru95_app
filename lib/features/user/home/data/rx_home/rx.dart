import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/user/home/data/rx_home/api.dart';
import 'package:oscaru95/features/user/home/model/nearest_shop_response.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class GetNearestRx extends RxResponseInt<NearestShopResponse> {
  Data? response;
  GetNearestRx({required super.empty, required super.dataFetcher});

  ValueStream get getNearestStream => dataFetcher.stream;
  final api = GetNearestApi.instance;

  Future<bool> getNearest() async {
    try {
      final data = await api.getNearest();
      handleSuccessWithReturn(data);
      response = data.data;

      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
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
