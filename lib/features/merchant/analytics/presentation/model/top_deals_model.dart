import 'dart:convert';

class TopDealsModel {
    bool? success;
    String? message;
    List<Datum>? data;

    TopDealsModel({
        this.success,
        this.message,
        this.data,
    });

    TopDealsModel copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
    }) => 
        TopDealsModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory TopDealsModel.fromRawJson(String str) => TopDealsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TopDealsModel.fromJson(Map<String, dynamic> json) => TopDealsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? dealName;
    int? views;

    Datum({
        this.dealName,
        this.views,
    });

    Datum copyWith({
        String? dealName,
        int? views,
    }) => 
        Datum(
            dealName: dealName ?? this.dealName,
            views: views ?? this.views,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        dealName: json["deal_name"],
        views: json["views"],
    );

    Map<String, dynamic> toJson() => {
        "deal_name": dealName,
        "views": views,
    };
}
