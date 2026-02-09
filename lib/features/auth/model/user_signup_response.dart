import 'dart:convert';

class UserSignupResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  UserSignupResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  UserSignupResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      UserSignupResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory UserSignupResponse.fromRawJson(String str) =>
      UserSignupResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSignupResponse.fromJson(Map<String, dynamic> json) =>
      UserSignupResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  String? message;
  String? email;
  int? otp;

  Data({
    this.message,
    this.email,
    this.otp,
  });

  Data copyWith({
    String? message,
    String? email,
    int? otp,
  }) =>
      Data(
        message: message ?? this.message,
        email: email ?? this.email,
        otp: otp ?? this.otp,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "email": email,
        "otp": otp,
      };
}
