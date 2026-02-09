import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class CommentApi {
  static final CommentApi _singleton = CommentApi._internal();
  CommentApi._internal();

  static CommentApi get instance => _singleton;

  Future<Map> comment({
    required String id,
    required String comment
  }) async {
    try {
      Map data = {
        "business_profile_id": id,
        "comment":comment
      };
      Response response = await postHttp(EndPoints.commentInfo(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        log("this is message of data:${data['message']}");
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
