import 'dart:convert';

class MenuModel {
    bool? success;
    String? message;
    DataImage? data;
    int? code;

    MenuModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    MenuModel copyWith({
        bool? success,
        String? message,
        DataImage? data,
        int? code,
    }) => 
        MenuModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory MenuModel.fromRawJson(String str) => MenuModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : DataImage.fromJson(json["data"]),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
    };
}

class DataImage {
    String? menu;

    DataImage({
        this.menu,
    });

    DataImage copyWith({
        String? menu,
    }) => 
        DataImage(
            menu: menu ?? this.menu,
        );

    factory DataImage.fromRawJson(String str) => DataImage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataImage.fromJson(Map<String, dynamic> json) => DataImage(
        menu: json["menu"],
    );

    Map<String, dynamic> toJson() => {
        "menu": menu,
    };
}
