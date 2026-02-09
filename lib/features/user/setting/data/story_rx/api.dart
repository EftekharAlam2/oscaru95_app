import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/setting/model/story_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetStoryApi {
  static final GetStoryApi _singleton = GetStoryApi._internal();
  GetStoryApi._internal();

  static GetStoryApi get instance => _singleton;

  Future<StoryModel> getStory() async {
    try {
      Response response = await getHttp(EndPoints.story());
      if (response.statusCode == 200) {
        final data = StoryModel.fromRawJson(json.encode(response.data));
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
