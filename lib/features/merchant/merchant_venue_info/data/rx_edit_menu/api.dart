import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class EditMenuApi {
  static final EditMenuApi _singleton = EditMenuApi._internal();
  EditMenuApi._internal();

  static EditMenuApi get instance => _singleton;

  Future<Map> editMenu({
    required File menu,
  }) async {
    try {
      FormData data = FormData.fromMap({});
      if (await File(menu.path).exists()) {
        data.files.add(MapEntry(
          'menu',
          await MultipartFile.fromFile(menu.path),
        ));
      }
      Response response = await postHttp(EndPoints.editMenu(), data);
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
