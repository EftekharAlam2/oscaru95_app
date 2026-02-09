import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/model/event_details_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetEventDetailsApi {
  static final GetEventDetailsApi _singleton = GetEventDetailsApi._internal();
  GetEventDetailsApi._internal();

  static GetEventDetailsApi get instance => _singleton;

  Future<EventDetailsResponse> getEventDetails({required int id}) async {
    try {
      Response response = await getHttp(EndPoints.getEventDetails(id));
      if (response.statusCode == 200) {
        final data =
            EventDetailsResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
