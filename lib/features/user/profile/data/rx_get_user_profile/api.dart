import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/profile/model/user_profile_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class GetUserProfileApi {
  static final GetUserProfileApi _singleton = GetUserProfileApi._internal();
  GetUserProfileApi._internal();

  static GetUserProfileApi get instance => _singleton;

  Future<UserProfileResponse> getUserProfile() async {
    try {
      Response response = await getHttp(EndPoints.userProfile());
      if (response.statusCode == 200) {
        final data =
            UserProfileResponse.fromRawJson(json.encode(response.data));
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
