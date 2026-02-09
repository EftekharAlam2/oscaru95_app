import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/rating_model_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class RatingApi {
  static final RatingApi _singleton = RatingApi._internal();
  RatingApi._internal();

  static RatingApi get instance => _singleton;

  Future<RatingSummaryModel> getRating() async {
    try {
      Response response = await getHttp(EndPoints.anlaytics());
      if (response.statusCode == 200) {
        final data = RatingSummaryModel.fromRawJson(json.encode(response.data));
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
