import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class DiscoverFilterAPi {
  static final DiscoverFilterAPi _singleton = DiscoverFilterAPi._internal();
  DiscoverFilterAPi._internal();

  static DiscoverFilterAPi get instance => _singleton;

  Future<DiscoverResponse> filter({String? type, String? cusingId,String? cuisinId,String? days,String?min,String ?max}) async {
    try {
      final Map<String, dynamic> data = {
        "type": type,
        "cuisine_ids":cusingId,
        "days":days,
        "price_min":min,
        "price_max":max
      };

      Response response = await postHttp(EndPoints.discover(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData =
            json.decode(json.encode(response.data));
        log("This is the message of data: ${responseData['message']}");

        return DiscoverResponse.fromJson(responseData);
      } else {
        log('Error: ${response.statusCode}');
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
