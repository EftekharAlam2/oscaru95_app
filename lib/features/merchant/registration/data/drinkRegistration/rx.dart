import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/registration/model/drink_registarion_model.dart';
import 'package:oscaru95/helpers/toast.dart';
import 'package:oscaru95/networks/rx_base.dart';
import 'package:rxdart/rxdart.dart';

import 'api.dart';

final class AddItemRx extends RxResponseInt<AddItemModel> {
  final api = AddItemApi.instance;
  ValueStream<AddItemModel> get update => dataFetcher.stream;

  AddItemRx({required super.empty, required super.dataFetcher});

  Future<AddItemModel> itemPost({
    required int categoryId,
    required String type,
    required List<Map<String, dynamic>> itemList,
    required List<Map<String, dynamic>> itemHours,
  }) async {
    // log("Goals Data: ${goals.map((goal) => goal.toJson()).toList()}");

    try {
      AddItemModel data = await api
          .itemPost(categoryId: categoryId, type: type, itemList: itemList, itemHours: itemHours);
      log("Data ====> $data");

      return data; // Return true if request succeeds
    } catch (e) {
      log("Data ====> d");
      return handleErrorWithReturn(e);
    }
  }

  @override
  handleSuccessWithReturn(AddItemModel data) {
    ToastUtil.showShortToast(data.message!);
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(error) {
    AddItemModel data = AddItemModel();
    if (error is DioException) {
      if (error.response != null && error.response!.statusCode == 422) {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showLongToast(errorMessage);
      } else if (error.response!.statusCode == 404) {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showLongToast(errorMessage);
      } else {
        final errorData = error.response!.data;
        final errorMessage =
            errorData['message'] ?? "An unknown error occurred";
        ToastUtil.showLongToast(errorMessage);
      }
    } else {
      log("Error ====> $error");
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return data;
  }
}
