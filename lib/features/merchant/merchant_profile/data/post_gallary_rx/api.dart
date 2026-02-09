import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class StoryUploadApi {
  static final StoryUploadApi _singleton = StoryUploadApi._internal();
  StoryUploadApi._internal();

  static StoryUploadApi get instance => _singleton;

  Future<Map> story({
    required File image,
  }) async {
    try {
      FormData data = FormData.fromMap({});
      if (await File(image.path).exists()) {
        data.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path),
        ));
      }
      Response response = await postHttp(EndPoints.gallery(), data);
      if (response.statusCode == 200) {
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
