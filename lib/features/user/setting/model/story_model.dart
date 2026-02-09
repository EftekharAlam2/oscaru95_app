import 'dart:convert';

class StoryModel {
    bool? success;
    String? message;
    List<Datum>? data;
    int? code;

    StoryModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    StoryModel copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
        int? code,
    }) => 
        StoryModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory StoryModel.fromRawJson(String str) => StoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
    };
}

class Datum {
    int? id;
    int? businessProfileId;
    String? image;
    dynamic video;

    Datum({
        this.id,
        this.businessProfileId,
        this.image,
        this.video,
    });

    Datum copyWith({
        int? id,
        int? businessProfileId,
        String? image,
        dynamic video,
    }) => 
        Datum(
            id: id ?? this.id,
            businessProfileId: businessProfileId ?? this.businessProfileId,
            image: image ?? this.image,
            video: video ?? this.video,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessProfileId: json["business_profile_id"],
        image: json["image"],
        video: json["video"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "business_profile_id": businessProfileId,
        "image": image,
        "video": video,
    };
}
