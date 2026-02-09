import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/merchant_special_evants/model/special_offer_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetSpecialOfferApi {
  static final GetSpecialOfferApi _singleton = GetSpecialOfferApi._internal();
  GetSpecialOfferApi._internal();

  static GetSpecialOfferApi get instance => _singleton;

  Future<SpecialOfferResponse> getSpecialOffer() async {
    try {
      Response response = await getHttp(EndPoints.getSpecialOffer());
      if (response.statusCode == 200) {
        final data =
            SpecialOfferResponse.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
