import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/merchant/registration/data/categories/api.dart';
import 'package:oscaru95/features/merchant/registration/model/categoires_model.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/streams.dart';

import '../../../../../../networks/rx_base.dart';

final class GetCategoriesRx extends RxResponseInt<CategoriesModel> {
  GetCategoriesRx({required super.empty, required super.dataFetcher});

  ValueStream<CategoriesModel> get getCategory => dataFetcher.stream;
  final api = GetCategoriesApi.instance;

  Future<CategoriesModel> getCategories() async {
    try {
      CategoriesModel data = await api.getCategories();
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
