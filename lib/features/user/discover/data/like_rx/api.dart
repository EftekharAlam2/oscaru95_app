import 'dart:convert';
import 'dart:developer';

import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class LikePostAPi {
  static final LikePostAPi _singleton = LikePostAPi._internal();
  LikePostAPi._internal();

  static LikePostAPi get instance => _singleton;

  Future<Map> like({
    required int id,
  }) async {
    try {
      Map data = {
        "business_profile_id": id,
      };
      var response = await postHttp(EndPoints.userLike(), data);
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
