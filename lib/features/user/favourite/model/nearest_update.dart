import 'dart:convert';

class NearestShopUpdate {
    bool? success;
    String? message;
    Data? data;
    int? code;

    NearestShopUpdate({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    NearestShopUpdate copyWith({
        bool? success,
        String? message,
        Data? data,
        int? code,
    }) => 
        NearestShopUpdate(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory NearestShopUpdate.fromRawJson(String str) => NearestShopUpdate.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NearestShopUpdate.fromJson(Map<String, dynamic> json) => NearestShopUpdate(
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
    List<Datum>? data;

    Data({
        this.data,
    });

    Data copyWith({
        List<Datum>? data,
    }) => 
        Data(
            data: data ?? this.data,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? venueName;
    String? type;
    int? typeIcon;
    String? openHour;
    String? closeHour;
    String? date;
    String? address;
    String? cover;
    String? distance;
    String? latitude;
    String? longitude;
    int? averageRating;
    int? totalReview;
    bool? isWishlisted;

    Datum({
        this.id,
        this.venueName,
        this.type,
        this.typeIcon,
        this.openHour,
        this.closeHour,
        this.date,
        this.address,
        this.cover,
        this.distance,
        this.latitude,
        this.longitude,
        this.averageRating,
        this.totalReview,
        this.isWishlisted,
    });

    Datum copyWith({
        int? id,
        String? venueName,
        String? type,
        int? typeIcon,
        String? openHour,
        String? closeHour,
        String? date,
        String? address,
        String? cover,
        String? distance,
        String? latitude,
        String? longitude,
        int? averageRating,
        int? totalReview,
        bool? isWishlisted,
    }) => 
        Datum(
            id: id ?? this.id,
            venueName: venueName ?? this.venueName,
            type: type ?? this.type,
            typeIcon: typeIcon ?? this.typeIcon,
            openHour: openHour ?? this.openHour,
            closeHour: closeHour ?? this.closeHour,
            date: date ?? this.date,
            address: address ?? this.address,
            cover: cover ?? this.cover,
            distance: distance ?? this.distance,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            averageRating: averageRating ?? this.averageRating,
            totalReview: totalReview ?? this.totalReview,
            isWishlisted: isWishlisted ?? this.isWishlisted,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        venueName: json["venue_name"],
        type: json["type"],
        typeIcon: json["type_icon"],
        openHour: json["open_hour"],
        closeHour: json["close_hour"],
        date: json["date"],
        address: json["address"],
        cover: json["cover"],
        distance: json["distance"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        averageRating: json["average_rating"],
        totalReview: json["total_review"],
        isWishlisted: json["is_wishlisted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "venue_name": venueName,
        "type": type,
        "type_icon": typeIcon,
        "open_hour": openHour,
        "close_hour": closeHour,
        "date": date,
        "address": address,
        "cover": cover,
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
        "average_rating": averageRating,
        "total_review": totalReview,
        "is_wishlisted": isWishlisted,
    };
}
