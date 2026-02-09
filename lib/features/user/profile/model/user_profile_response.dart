import 'dart:convert';

class UserProfileResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  UserProfileResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  UserProfileResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      UserProfileResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory UserProfileResponse.fromRawJson(String str) =>
      UserProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
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
  String? fName;
  String? lName;
  String? email;
  String? avatar;
  String? phone;
  DateTime? dob;
  String? zipCode;

  Data({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.avatar,
    this.phone,
    this.dob,
    this.zipCode,
  });

  Data copyWith({
    int? id,
    String? fName,
    String? lName,
    String? email,
    String? avatar,
    String? phone,
    DateTime? dob,
    String? zipCode,
  }) =>
      Data(
        id: id ?? this.id,
        fName: fName ?? this.fName,
        lName: lName ?? this.lName,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        dob: dob ?? this.dob,
        zipCode: zipCode ?? this.zipCode,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        avatar: json["avatar"],
        phone: json["phone"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        zipCode: json["zip_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "avatar": avatar,
        "phone": phone,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "zip_code": zipCode,
      };
}
