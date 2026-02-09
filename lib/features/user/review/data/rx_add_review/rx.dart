// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/features/user/review/data/rx_add_review/api.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/networks/stream_cleaner.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../networks/rx_base.dart';

final class AddReviewRx extends RxResponseInt<Map> {
  String? errorMessage;
  final api = AddReviewApi.instance;

  AddReviewRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> addReview({
    required String id,
    required String categoryId,
    required String rating,
    required String comment,
  }) async {
    try {
      final data = await api.addReview(
        id: id,
        categoryId: categoryId,
        rating: rating,
        comment: comment,
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
        // errorMessage = error.response!.data['message'];
        log(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
