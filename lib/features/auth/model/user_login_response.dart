import 'dart:convert';

class UserLoginResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  UserLoginResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  UserLoginResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      UserLoginResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory UserLoginResponse.fromRawJson(String str) =>
      UserLoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
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
  dynamic fName;
  dynamic lName;
  String? vanueName;
  String? email;
  String? phone;
  String? role;
  String? isItem;
  String? token;

  Data({
    this.id,
    this.fName,
    this.lName,
    this.vanueName,
    this.email,
    this.phone,
    this.role,
    this.isItem,
    this.token,
  });

  Data copyWith({
    int? id,
    dynamic fName,
    dynamic lName,
    String? vanueName,
    String? email,
    String? phone,
    String? role,
    String? isItem,
    String? token,
  }) =>
      Data(
        id: id ?? this.id,
        fName: fName ?? this.fName,
        lName: lName ?? this.lName,
        vanueName: vanueName ?? this.vanueName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        isItem: isItem ?? this.isItem,
        token: token ?? this.token,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        vanueName: json["vanue_name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        isItem: json["is_item"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "vanue_name": vanueName,
        "email": email,
        "phone": phone,
        "role": role,
        "is_item": isItem,
        "token": token,
      };
}
