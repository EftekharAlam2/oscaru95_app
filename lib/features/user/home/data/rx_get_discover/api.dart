import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetDiscoverApi {
  static final GetDiscoverApi _singleton = GetDiscoverApi._internal();
  GetDiscoverApi._internal();

  static GetDiscoverApi get instance => _singleton;

  Future<DiscoverResponse> getDiscover() async {
    try {
      Response response = await getHttp(EndPoints.getDiscover());
      if (response.statusCode == 200) {
        final data = DiscoverResponse.fromRawJson(json.encode(response.data));
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
