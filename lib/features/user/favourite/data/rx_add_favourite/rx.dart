// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/user/favourite/data/rx_add_favourite/api.dart';
import 'package:oscaru95/features/user/favourite/data/rx_get_favourite/rx.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../networks/rx_base.dart';
import '../../../../../networks/api_access.dart';

final class AddFavouriteRx extends RxResponseInt<Map> {
  String? errorMessage;
  final api = AddFavouriteApi.instance;

  AddFavouriteRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> addToFavourite({required String id}) async {
    try {
      final data = await api.addToFavourite(id: id);
      handleSuccessWithReturn(data);
      // Refresh the favorite list after toggling
      await getFavouriteRx.getFavourite();
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
        errorMessage = error.response!.data['message'];
        // ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
