import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/user/filter/data/api.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../networks/rx_base.dart';

final class DisoverFilterRx extends RxResponseInt<DiscoverResponse> {
  DisoverFilterRx({required super.empty, required super.dataFetcher});

  ValueStream get getFoodSpecialtream => dataFetcher.stream;
  final api = DiscoverFilterAPi.instance;

  Future<DiscoverResponse> getFilter({
    String? type,
    String? cusingId,
    String? cuisinId,
    String? days,
    String? min,
    String? max,
    String? searchQuery
  }) async {
    try {
      DiscoverResponse data = await api.filter(
        type: type,
        cusingId: cusingId,
        days: days,
        max: max,
        min: min,
        searchQuery: searchQuery
      );
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
    return false;
  }
}
