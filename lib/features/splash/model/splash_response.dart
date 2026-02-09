import 'dart:convert';

class SplashResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  SplashResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  SplashResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      SplashResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory SplashResponse.fromRawJson(String str) =>
      SplashResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SplashResponse.fromJson(Map<String, dynamic> json) => SplashResponse(
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
  int? id;
  String? title;
  String? subtitle;

  Data({
    this.id,
    this.title,
    this.subtitle,
  });

  Data copyWith({
    int? id,
    String? title,
    String? subtitle,
  }) =>
      Data(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
      };
}
