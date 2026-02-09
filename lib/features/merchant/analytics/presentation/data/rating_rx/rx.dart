import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/data/rating_rx/api.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/rating_model_response.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/rx_base.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';


final class RatingRx extends RxResponseInt<RatingSummaryModel> {
  RatingRx({required super.empty, required super.dataFetcher});

  ValueStream get getBusniessProfileStream => dataFetcher.stream;
  final api = RatingApi.instance;

  Future<RatingSummaryModel> getRating() async {
    try {
      RatingSummaryModel data = await api.getRating();
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
