import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_seasonal_offer/model/sessonal_offer_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetSessonalOfferApi {
  static final GetSessonalOfferApi _singleton = GetSessonalOfferApi._internal();
  GetSessonalOfferApi._internal();

  static GetSessonalOfferApi get instance => _singleton;

  Future<SeasonalOfferResponse> getSessonalOffer() async {
    try {
      Response response = await getHttp(EndPoints.getSessonalOffer());
      if (response.statusCode == 200) {
        final data =
            SeasonalOfferResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
