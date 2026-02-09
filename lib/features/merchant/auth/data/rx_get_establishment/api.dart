import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/registration/model/categoires_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetEstablishmentApi {
  static final GetEstablishmentApi _singleton = GetEstablishmentApi._internal();
  GetEstablishmentApi._internal();

  static GetEstablishmentApi get instance => _singleton;

  Future<CategoriesModel> GetEstablishment() async {
    try {
      Response response = await getHttp(EndPoints.getEstablishment());
      if (response.statusCode == 200) {
        final data = CategoriesModel.fromRawJson(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
