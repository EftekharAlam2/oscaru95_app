import 'dart:convert';

class VerifyOtpModel {
    bool? status;
    String? message;
    OtpData? data;
    int? code;

    VerifyOtpModel({
        this.status,
        this.message,
        this.data,
        this.code,
    });

    VerifyOtpModel copyWith({
        bool? status,
        String? message,
        OtpData? data,
        int? code,
    }) => 
        VerifyOtpModel(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory VerifyOtpModel.fromRawJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : OtpData.fromJson(json["data"]),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "code": code,
    };
}

class OtpData {
    int? id;
    String? email;
    String? token;
    String? role;

    OtpData({
        this.id,
        this.email,
        this.token,
        this.role,
    });

    OtpData copyWith({
        int? id,
        String? email,
        String? token,
        String? role,
    }) =>
        OtpData(
            id: id ?? this.id,
            email: email ?? this.email,
            token: token ?? this.token,
            role: role ?? this.role,
        );

    factory OtpData.fromRawJson(String str) => OtpData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
        id: json["id"],
        email: json["email"],
        token: json["token"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
        "role": role,
    };
}

