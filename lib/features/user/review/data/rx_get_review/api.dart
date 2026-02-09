import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/review/model/review_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetReviewApi {
  static final GetReviewApi _singleton = GetReviewApi._internal();
  GetReviewApi._internal();

  static GetReviewApi get instance => _singleton;

  Future<ReviewResponse> getReview({required int id}) async {
    try {
      Response response = await getHttp(EndPoints.getReview(id));
      if (response.statusCode == 200) {
        final data = ReviewResponse.fromRawJson(json.encode(response.data));
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
