import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class AddSpecialEventApi {
  static final AddSpecialEventApi _singleton = AddSpecialEventApi._internal();
  AddSpecialEventApi._internal();

  static AddSpecialEventApi get instance => _singleton;

  Future<Map> addSpecialEvent({
    required String type,
    required String name,
    required String price,
    required String startDate,
    required String startTime,
    required String endTime,
    required String description,
  }) async {
    try {
      Map data = {
        "type": type,
        "name": name,
        "start_date": startDate,
        "on_offer":price,
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
