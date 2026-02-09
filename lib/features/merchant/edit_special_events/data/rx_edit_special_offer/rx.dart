import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/edit_special_events/data/rx_edit_special_offer/api.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class EditSpecialEventRx extends RxResponseInt<Map> {
  EditSpecialEventRx({required super.empty, required super.dataFetcher});

  ValueStream get editEventStream => dataFetcher.stream;
  final api = EditSpecialEventApi.instance;

  Future<bool> editSpecialEvent({
    required int id,
    required String type,
    required String name,
    required String startDate,
    required String startTime,
    required String endTime,
    required String description,
  }) async {
    try {
      final data = await api.editSpecialEvent(
        id: id,
        type: type,
        name: name,
        startDate: startDate,
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
