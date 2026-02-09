import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class CancelSessonalOfferApi {
  static final CancelSessonalOfferApi _singleton =
      CancelSessonalOfferApi._internal();
  CancelSessonalOfferApi._internal();

  static CancelSessonalOfferApi get instance => _singleton;

  Future<Map> cencelSessonalOffer({required int id}) async {
    try {
      Response response = await deleteHttp(EndPoints.cancelSessonalOffer(id));
      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
