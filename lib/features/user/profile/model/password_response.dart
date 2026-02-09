import 'dart:convert';

class PasswordResponse {
    bool? success;
    String? message;
    bool? data;
    int? code;

    PasswordResponse({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    PasswordResponse copyWith({
        bool? success,
        String? message,
        bool? data,
        int? code,
    }) => 
        PasswordResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory PasswordResponse.fromRawJson(String str) => PasswordResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PasswordResponse.fromJson(Map<String, dynamic> json) => PasswordResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
        "code": code,
    };
}
