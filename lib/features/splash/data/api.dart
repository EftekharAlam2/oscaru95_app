import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/splash/model/splash_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetSplashApi {
  static final GetSplashApi _singleton = GetSplashApi._internal();
  GetSplashApi._internal();

  static GetSplashApi get instance => _singleton;

  Future<SplashResponse> getSplashResponse() async {
    try {
      Response response = await getHttp(EndPoints.splash());
      if (response.statusCode == 200) {
        final data = SplashResponse.fromRawJson(json.encode(response.data));
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
