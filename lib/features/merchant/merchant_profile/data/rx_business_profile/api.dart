import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_profile/model/busniess_profile_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class BusniessProfileApi {
  static final BusniessProfileApi _singleton = BusniessProfileApi._internal();
  BusniessProfileApi._internal();

  static BusniessProfileApi get instance => _singleton;

  Future<BusinessProfileResponse> getBusinessProfile() async {
    try {
      Response response = await getHttp(EndPoints.getBusniessProfile());
      if (response.statusCode == 200) {
        final data =
            BusinessProfileResponse.fromRawJson(json.encode(response.data));
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
