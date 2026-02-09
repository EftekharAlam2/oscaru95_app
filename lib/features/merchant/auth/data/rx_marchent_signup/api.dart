import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/model/user_signup_response.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';

final class UserMarchentApi {
  static final UserMarchentApi _singleton = UserMarchentApi._internal();
  UserMarchentApi._internal();
  static UserMarchentApi get instance => _singleton;

  Future<UserSignupResponse> userSignup({
    required int establishmentId,
    required String venueName,
    required String email,
    required String password,
    required String confPass,
    required File? covers,
    required String phone,
    required String address,
    required String openHour,
    required String closeHour,
    File? menu,
    required String latitude,
    required String longitude,
  }) async {
    try {
      FormData data = FormData();

      // Regular form fields
      data.fields.addAll([
        MapEntry("email", email),
        MapEntry("password", password),
        MapEntry("password_confirmation", confPass),
        MapEntry("establishment_id", establishmentId.toString()),
        MapEntry("venue_name", venueName),
        MapEntry("phone", phone),
        MapEntry("address", address),
        MapEntry("open_hour", openHour),
        MapEntry("close_hour", closeHour),
        MapEntry("latitude", latitude),
        MapEntry("longitude", longitude),
      ]);

      // Add cover images
    
        if (covers!=null && await covers.exists()){
          data.files.add(MapEntry("cover", await MultipartFile.fromFile(covers.path,filename: covers.path.split("/").last)));

        } 
         
      

      // Optional: add menu file
      if (menu != null && await menu.exists()) {
        data.files.add(MapEntry(
          'menu',
          await MultipartFile.fromFile(menu.path, filename: menu.path.split("/").last),
        ));
      }

      Response response = await postHttp(EndPoints.BusinessSignUp(), data);

      final jsonData = response.data;
      if (jsonData is Map<String, dynamic>) {
        return UserSignupResponse.fromRawJson(json.encode(jsonData));
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (error) {
      rethrow;
    }
  }
}
