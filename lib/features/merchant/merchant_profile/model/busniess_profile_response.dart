import 'dart:convert';

class BusinessProfileResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  BusinessProfileResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  BusinessProfileResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      BusinessProfileResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory BusinessProfileResponse.fromRawJson(String str) =>
      BusinessProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BusinessProfileResponse.fromJson(Map<String, dynamic> json) =>
      BusinessProfileResponse(
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
  String? email;
  String? venueName;
  String? cover;
  dynamic address;
  dynamic phone;
  String? openHour;
  String? closeHour;

  Data({
    this.id,
    this.email,
    this.venueName,
    this.cover,
    this.address,
    this.phone,
    this.openHour,
    this.closeHour,
  });

  Data copyWith({
    int? id,
    String? email,
    String? venueName,
    String? cover,
    dynamic address,
    dynamic phone,
    String? openHour,
    String? closeHour,
  }) =>
      Data(
        id: id ?? this.id,
        email: email ?? this.email,
        venueName: venueName ?? this.venueName,
        cover: cover ?? this.cover,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        openHour: openHour ?? this.openHour,
        closeHour: closeHour ?? this.closeHour,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        venueName: json["venue_name"],
        cover: json["cover"],
        address: json["address"],
        phone: json["phone"],
        openHour: json["open_hour"],
        closeHour: json["close_hour"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "venue_name": venueName,
        "cover": cover,
        "address": address,
        "phone": phone,
        "open_hour": openHour,
        "close_hour": closeHour,
      };
}
