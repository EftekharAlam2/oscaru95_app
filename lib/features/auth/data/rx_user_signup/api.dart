import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oscaru95/features/auth/model/user_signup_response.dart';

import '/networks/endpoints.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class UserSignupApi {
  static final UserSignupApi _singleton = UserSignupApi._internal();
  UserSignupApi._internal();
  static UserSignupApi get instance => _singleton;

  Future<UserSignupResponse> userSignup({
    required String fName,
    required String lName,
    required String email,
    required String password,
    required String confPass,
    File? avatar,
    required String phone,
    required String dob,
    required String gender,
    required String zipCode,
    required String location,
    required String latitude,
    required String longitude,
    required String address,
  }) async {
    try {
      log("=== Starting User Signup ===");
      log("Email: $email");
      log("Name: $fName $lName");
      log("Address: $address");
      log("Zip Code: $zipCode");

      // Use FormData to properly handle file uploads
      FormData formData = FormData.fromMap({
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "password": password,
        "password_confirmation": confPass,
        "phone": phone,
        "dob": dob,
        "gender": gender,
        "zip_code": zipCode,
        "address": address,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      });

      // Handle avatar file upload
      if (avatar != null && await avatar.exists()) {
        formData.files.add(MapEntry(
          'avatar',
          await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split('/').last,
          ),
        ));
        log("Avatar added to request");
      }

      log("Sending signup request to: ${EndPoints.userSignUp()}");
      Response response = await postHttp(EndPoints.userSignUp(), formData);

      log("Response Status: ${response.statusCode}");
      log("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final data = UserSignupResponse.fromRawJson(json.encode(response.data));
        log("=== Signup Successful ===");
        log("OTP: ${data.data?.otp}");
        return data;
      } else {
        log("Error: Status code ${response.statusCode}");
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("Signup Exception: $error");
      rethrow;
    }
  }
}
