import 'dart:convert';

class StatusModel {
    bool? success;
    String? message;
    Data? data;
    int? code;

    StatusModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    StatusModel copyWith({
        bool? success,
        String? message,
        Data? data,
        int? code,
    }) => 
        StatusModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory StatusModel.fromRawJson(String str) => StatusModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
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
    String? notification;

    Data({
        this.notification,
    });

    Data copyWith({
        String? notification,
    }) => 
        Data(
            notification: notification ?? this.notification,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        notification: json["notification"],
    );

    Map<String, dynamic> toJson() => {
        "notification": notification,
    };
}
