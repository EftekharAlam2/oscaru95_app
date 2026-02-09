import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/merchant/registration/model/categoires_model.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetCategoriesApi {
  static final GetCategoriesApi _singleton = GetCategoriesApi._internal();
  GetCategoriesApi._internal();

  static GetCategoriesApi get instance => _singleton;

  Future<CategoriesModel> getCategories() async {
    try {
      Response response = await getHttp(EndPoints.categoriesInfo());
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
