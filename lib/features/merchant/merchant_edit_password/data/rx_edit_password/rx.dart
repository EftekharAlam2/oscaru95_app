import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/merchant_edit_password/data/rx_edit_password/api.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class BusniessEditPassRx extends RxResponseInt<Map> {
  BusniessEditPassRx({required super.empty, required super.dataFetcher});

  ValueStream get getBusniessProfileStream => dataFetcher.stream;
  final api = BusniessEditPassApi.instance;

  Future<bool> updatePassword({
    required String oldPass,
    required String password,
    required String confPass,
  }) async {
    try {
      final data = await api.updatePassword(
        oldPass: oldPass,
        confPass: confPass,
        password: password,
      );
      handleSuccessWithReturn(data);

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
        log("Error is =====> ${error.response!.data}");
        // ToastUtil.showShortToast(error.response!.data);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
