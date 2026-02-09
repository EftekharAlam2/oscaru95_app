import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/merchant_drinks_special/data/rx_get_drink_special/api.dart';
import 'package:oscaru95/features/merchant/merchant_drinks_special/model/drink_special_response.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class GetDrinkSpecialRx extends RxResponseInt<DrinkSpecialResponse> {
  GetDrinkSpecialRx({required super.empty, required super.dataFetcher});

  ValueStream get getDrinkSpecialtream => dataFetcher.stream;
  final api = GetDrinkSpecialApi.instance;

  Future<bool> getDrinkSpecial() async {
    try {
      final data = await api.getDrinkSpecial();
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
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
