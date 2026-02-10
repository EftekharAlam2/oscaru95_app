import 'dart:convert';

class FavouriteResponse {
    bool? success;
    String? message;
    List<Datum>? data;
    int? code;

    FavouriteResponse({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    FavouriteResponse copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
        int? code,
    }) => 
        FavouriteResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory FavouriteResponse.fromRawJson(String str) => FavouriteResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavouriteResponse.fromJson(Map<String, dynamic> json) => FavouriteResponse(
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
    String? isFavourite;
    String? venueName;
    dynamic cover;
    String? establishment;
    String? address;
    String? latitude;
    String? longitude;
    int? totalReview;
    int? averageRating;
    dynamic category;
    String? isItem;
    dynamic fromDay;
    dynamic toDay;
    dynamic fromTime;
    dynamic toTime;
    String? distance;
    String? type;

    Datum({
        this.id,
        this.isFavourite,
        this.venueName,
        this.cover,
        this.establishment,
        this.address,
        this.latitude,
        this.longitude,
        this.totalReview,
        this.averageRating,
        this.category,
        this.isItem,
        this.fromDay,
        this.toDay,
        this.fromTime,
        this.toTime,
        this.distance,
        this.type,
    });

    Datum copyWith({
        int? id,
        String? isFavourite,
        String? venueName,
        dynamic cover,
        String? establishment,
        String? address,
        String? latitude,
        String? longitude,
        int? totalReview,
        int? averageRating,
        dynamic category,
        String? isItem,
        dynamic fromDay,
        dynamic toDay,
        dynamic fromTime,
        dynamic toTime,
        String? distance,
        String? type,
    }) =>
        Datum(
            id: id ?? this.id,
            isFavourite: isFavourite ?? this.isFavourite,
            venueName: venueName ?? this.venueName,
            cover: cover ?? this.cover,
            establishment: establishment ?? this.establishment,
            address: address ?? this.address,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            totalReview: totalReview ?? this.totalReview,
            averageRating: averageRating ?? this.averageRating,
            category: category ?? this.category,
            isItem: isItem ?? this.isItem,
            fromDay: fromDay ?? this.fromDay,
            toDay: toDay ?? this.toDay,
            fromTime: fromTime ?? this.fromTime,
            toTime: toTime ?? this.toTime,
            distance: distance ?? this.distance,
            type: type ?? this.type,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        isFavourite: json["is_favourite"],
        venueName: json["venue_name"],
        cover: json["cover"],
        establishment: json["establishment"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        totalReview: json["total_review"],
        averageRating: json["average_rating"],
        category: json["category"],
        isItem: json["is_item"],
        fromDay: json["from_day"],
        toDay: json["to_day"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        distance: json["distance"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "is_favourite": isFavourite,
        "venue_name": venueName,
        "cover": cover,
        "establishment": establishment,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "total_review": totalReview,
        "average_rating": averageRating,
        "category": category,
        "is_item": isItem,
        "from_day": fromDay,
        "to_day": toDay,
        "from_time": fromTime,
        "to_time": toTime,
        "distance": distance,
        "type": type,
    };
}
