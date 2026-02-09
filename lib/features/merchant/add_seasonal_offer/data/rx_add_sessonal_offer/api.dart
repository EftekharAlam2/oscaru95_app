import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class AddSessonalEventApi {
  static final AddSessonalEventApi _singleton = AddSessonalEventApi._internal();
  AddSessonalEventApi._internal();

  static AddSessonalEventApi get instance => _singleton;

  Future<Map> addSessonalEvent({
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
      Map data = {
        "name": name,
        "type": type,
        "discount": discount,
        "on_offer": onOffer,
        "start_date": startDate,
        "end_date": endDate,
        "start_time": startTime,
        "end_time": endTime,
        "description": description,
      };
      Response response = await postHttp(EndPoints.addEvent(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
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
