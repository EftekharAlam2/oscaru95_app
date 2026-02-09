import 'dart:convert';

class UserSignupOtpVerifyResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  UserSignupOtpVerifyResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  UserSignupOtpVerifyResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      UserSignupOtpVerifyResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory UserSignupOtpVerifyResponse.fromRawJson(String str) =>
      UserSignupOtpVerifyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSignupOtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      UserSignupOtpVerifyResponse(
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
  dynamic name;
  String? email;
  String? phone;
  dynamic location;
  dynamic city;
  dynamic description;
  dynamic state;
  String? zipCode;
  String? avatar;
  String? role;
  DateTime? createdAt;
  dynamic isConnected;
  String? token;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.location,
    this.city,
    this.description,
    this.state,
    this.zipCode,
    this.avatar,
    this.role,
    this.createdAt,
    this.isConnected,
    this.token,
  });

  Data copyWith({
    int? id,
    dynamic name,
    String? email,
    String? phone,
    dynamic location,
    dynamic city,
    dynamic description,
    dynamic state,
    String? zipCode,
    String? avatar,
    String? role,
    DateTime? createdAt,
    dynamic isConnected,
    String? token,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        location: location ?? this.location,
        city: city ?? this.city,
        description: description ?? this.description,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        isConnected: isConnected ?? this.isConnected,
        token: token ?? this.token,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        location: json["location"],
        city: json["city"],
        description: json["description"],
        state: json["state"],
        zipCode: json["zip_code"],
        avatar: json["avatar"],
        role: json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isConnected: json["is_connected"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
        "city": city,
        "description": description,
        "state": state,
        "zip_code": zipCode,
        "avatar": avatar,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "is_connected": isConnected,
        "token": token,
      };
}
