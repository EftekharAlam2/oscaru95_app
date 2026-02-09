import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class EditSpecialEventApi {
  static final EditSpecialEventApi _singleton = EditSpecialEventApi._internal();
  EditSpecialEventApi._internal();

  static EditSpecialEventApi get instance => _singleton;

  Future<Map> editSpecialEvent({
    required int id,
    required String type,
    required String name,
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
        "start_time": startTime,
        "end_time": endTime,
        "description": description,
      };
      Response response = await postHttp(EndPoints.editEvent(id), data);
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
