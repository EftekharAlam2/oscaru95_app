import 'dart:convert';

import 'package:dio/dio.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class FeedBackApi {
  static final FeedBackApi _singleton = FeedBackApi._internal();
  FeedBackApi._internal();
  static FeedBackApi get instance => _singleton;

  Future<Map> feedBack({
    required int rating,
    required String comment,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "rating": rating,
        "message": comment,
      });

      Response response = await postHttp(EndPoints.feed(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));

        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
