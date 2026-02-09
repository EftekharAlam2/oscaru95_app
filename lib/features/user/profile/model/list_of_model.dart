import 'dart:convert';

class FoodListModel {
    bool? success;
    String? message;
    FoodListModelData? data;
    int? code;

    FoodListModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    FoodListModel copyWith({
        bool? success,
        String? message,
        FoodListModelData? data,
        int? code,
    }) => 
        FoodListModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory FoodListModel.fromRawJson(String str) => FoodListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FoodListModel.fromJson(Map<String, dynamic> json) => FoodListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : FoodListModelData.fromJson(json["data"]),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
    };
}

class FoodListModelData {
    DataData? data;

    FoodListModelData({
        this.data,
    });

    FoodListModelData copyWith({
        DataData? data,
    }) => 
        FoodListModelData(
            data: data ?? this.data,
        );

    factory FoodListModelData.fromRawJson(String str) => FoodListModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FoodListModelData.fromJson(Map<String, dynamic> json) => FoodListModelData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class DataData {
    int? id;
    String? venueName;
    String? type;
    String? openHour;
    String? closeHour;
    String? date;
    String? address;
    dynamic cover;
    String? latitude;
    String? longitude;
    bool? isWishlisted;
    String? distance;
    List<dynamic>? item;
    List<dynamic>? spotlight;
    String? menu;

    DataData({
        this.id,
        this.venueName,
        this.type,
        this.openHour,
        this.closeHour,
        this.date,
        this.address,
        this.cover,
        this.latitude,
        this.longitude,
        this.isWishlisted,
        this.distance,
        this.item,
        this.spotlight,
        this.menu,
    });

    DataData copyWith({
        int? id,
        String? venueName,
        String? type,
        String? openHour,
        String? closeHour,
        String? date,
        String? address,
        dynamic cover,
        String? latitude,
        String? longitude,
        bool? isWishlisted,
        String? distance,
        List<dynamic>? item,
        List<dynamic>? spotlight,
        String? menu,
    }) => 
        DataData(
            id: id ?? this.id,
            venueName: venueName ?? this.venueName,
            type: type ?? this.type,
            openHour: openHour ?? this.openHour,
            closeHour: closeHour ?? this.closeHour,
            date: date ?? this.date,
            address: address ?? this.address,
            cover: cover ?? this.cover,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            isWishlisted: isWishlisted ?? this.isWishlisted,
            distance: distance ?? this.distance,
            item: item ?? this.item,
            spotlight: spotlight ?? this.spotlight,
            menu: menu ?? this.menu,
        );

    factory DataData.fromRawJson(String str) => DataData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        id: json["id"],
        venueName: json["venue_name"],
        type: json["type"],
        openHour: json["open_hour"],
        closeHour: json["close_hour"],
        date: json["date"],
        address: json["address"],
        cover: json["cover"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isWishlisted: json["is_wishlisted"],
        distance: json["distance"],
        item: json["item"] == null ? [] : List<dynamic>.from(json["item"]!.map((x) => x)),
        spotlight: json["spotlight"] == null ? [] : List<dynamic>.from(json["spotlight"]!.map((x) => x)),
        menu: json["menu"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "venue_name": venueName,
        "type": type,
        "open_hour": openHour,
        "close_hour": closeHour,
        "date": date,
        "address": address,
        "cover": cover,
        "latitude": latitude,
        "longitude": longitude,
        "is_wishlisted": isWishlisted,
        "distance": distance,
        "item": item == null ? [] : List<dynamic>.from(item!.map((x) => x)),
        "spotlight": spotlight == null ? [] : List<dynamic>.from(spotlight!.map((x) => x)),
        "menu": menu,
    };
}
