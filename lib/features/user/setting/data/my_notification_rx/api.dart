import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/setting/model/my_notification_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class NotificationApi {
  static final NotificationApi _singleton = NotificationApi._internal();
  NotificationApi._internal();

  static NotificationApi get instance => _singleton;

  Future<NotificationModel> getNotification() async {
    try {
      Response response = await getHttp(EndPoints.myNotification());
      if (response.statusCode == 200) {
        final data = NotificationModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        log('Error: ${response.statusCode}');
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
