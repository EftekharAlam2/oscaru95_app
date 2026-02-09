import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/merchant_venue_info/data/rx_edit_menu/api.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class EditMenuRx extends RxResponseInt<Map> {
  EditMenuRx({required super.empty, required super.dataFetcher});

  ValueStream get userLogoutStream => dataFetcher.stream;
  final api = EditMenuApi.instance;

  Future<bool> editMenu({
    required File menu,
  }) async {
    try {
      final data = await api.editMenu(menu: menu);
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
