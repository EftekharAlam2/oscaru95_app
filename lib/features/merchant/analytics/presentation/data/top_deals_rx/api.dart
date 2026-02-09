import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/analytics/presentation/model/top_deals_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class AnlayticsApi {
  static final AnlayticsApi _singleton = AnlayticsApi._internal();
  AnlayticsApi._internal();

  static AnlayticsApi get instance => _singleton;

  Future<TopDealsModel> getTopDeals(String month) async {
    try {
      Response response = await getHttp(EndPoints.topDeals(month));
      if (response.statusCode == 200) {
        final data = TopDealsModel.fromRawJson(json.encode(response.data));
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
