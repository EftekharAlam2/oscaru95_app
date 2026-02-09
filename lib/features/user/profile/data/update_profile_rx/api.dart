import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/user/profile/model/update_profile.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();
  UpdateProfileApi._internal();
  static UpdateProfileApi get instance => _singleton;

  Future<UpdateProfileModel> updateProfle({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    File? avatar,
    required String gender,
    required String dob,
    required String zipCode,
    required String address,
    required String latitude,
    required String longitude,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "gender": gender,
        "dob": dob,
        "zip_code": zipCode,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      });

      if (avatar != null && await File(avatar.path).exists()) {
        data.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(avatar.path),
        ));
      }

      Response response = await postHttp(EndPoints.updateProfile(), data);

      if (response.statusCode == 200) {
        final data = UpdateProfileModel.fromRawJson(json.encode(response.data));

        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
