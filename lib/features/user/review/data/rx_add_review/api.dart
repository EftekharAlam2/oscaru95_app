import 'dart:convert';

import 'package:dio/dio.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class AddReviewApi {
  static final AddReviewApi _singleton = AddReviewApi._internal();
  AddReviewApi._internal();
  static AddReviewApi get instance => _singleton;

  Future<Map> addReview({
    required String id,
    required String categoryId,
    required String rating,
    required String comment,
  }) async {
    try {
      Map data = {
        "business_profile_id": id,
        "category_id": categoryId,
        "rating": rating,
        "comment": comment,
      };

      Response response = await postHttp(EndPoints.addReview(), data);

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
