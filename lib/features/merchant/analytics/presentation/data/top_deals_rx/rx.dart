import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/data/top_deals_rx/api.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/top_deals_model.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../../networks/rx_base.dart';

final class AnlayticsRx extends RxResponseInt<TopDealsModel> {
  AnlayticsRx({required super.empty, required super.dataFetcher});

  ValueStream get getBusniessProfileStream => dataFetcher.stream;
  final api = AnlayticsApi.instance;

  Future<TopDealsModel> getTopDeals(String monthId) async {
    try {
      TopDealsModel data = await api.getTopDeals(monthId);
      handleSuccessWithReturn(data);

      return data;
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
