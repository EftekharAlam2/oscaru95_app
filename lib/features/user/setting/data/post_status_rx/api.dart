import 'dart:convert';
import 'dart:developer';

import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class PostStatusApi {
  static final PostStatusApi _singleton = PostStatusApi._internal();
  PostStatusApi._internal();

  static PostStatusApi get instance => _singleton;

  Future<Map> staus({
    required String id,
  }) async {
    try {
      Map data = {
        "venue_deal_alerts": id,
      };
      var response = await postHttp(EndPoints.statusAdd(), data);
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
