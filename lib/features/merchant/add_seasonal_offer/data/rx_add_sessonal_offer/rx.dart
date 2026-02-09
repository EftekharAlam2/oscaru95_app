import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/add_seasonal_offer/data/rx_add_sessonal_offer/api.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class AddSessonalEventRx extends RxResponseInt<Map> {
  AddSessonalEventRx({required super.empty, required super.dataFetcher});

  ValueStream get getFoodSpecialtream => dataFetcher.stream;
  final api = AddSessonalEventApi.instance;

  Future<bool> addSessonalEvent({
    required String name,
    required String type,
    required String discount,
    required String onOffer,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String description,
  }) async {
    try {
      final data = await api.addSessonalEvent(
        name: name,
        type: type,
        discount: discount,
        onOffer: onOffer,
        startDate: startDate,
        endDate: endDate,
        startTime: startTime,
        endTime: endTime,
        description: description,
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
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
