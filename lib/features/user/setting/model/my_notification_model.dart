import 'dart:convert';

class NotificationModel {
    bool? success;
    String? message;
    List<dynamic>? data;
    int? code;

    NotificationModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    NotificationModel copyWith({
        bool? success,
        String? message,
        List<dynamic>? data,
        int? code,
    }) => 
        NotificationModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "code": code,
    };
}
