import 'dart:convert';

class DiscoverResponse {
    bool? success;
    String? message;
    List<Datum>? data;
    int? code;

    DiscoverResponse({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    DiscoverResponse copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
        int? code,
    }) => 
        DiscoverResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory DiscoverResponse.fromRawJson(String str) => DiscoverResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DiscoverResponse.fromJson(Map<String, dynamic> json) => DiscoverResponse(
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
    String? venueName;
    String? cover;
    String? establishment;
    String? address;
    String? latitude;
    String? longitude;
    int? totalReviews;
    double? averageRating;
    String? category;
    int? isItem;
    dynamic dealType;
    String? fromDay;
    String? toDay;
    String? fromTime;
    String? toTime;
    String? createdAt;
    int? totalLike;
    int? totalComment;
    List<Like>? likes;

    Datum({
        this.id,
        this.venueName,
        this.cover,
        this.establishment,
        this.address,
        this.latitude,
        this.longitude,
        this.totalReviews,
        this.averageRating,
        this.category,
        this.isItem,
        this.dealType,
        this.fromDay,
        this.toDay,
        this.fromTime,
        this.toTime,
        this.createdAt,
        this.totalLike,
        this.totalComment,
        this.likes,
    });

    Datum copyWith({
        int? id,
        String? venueName,
        String? cover,
        String? establishment,
        String? address,
        String? latitude,
        String? longitude,
        int? totalReviews,
        double? averageRating,
        String? category,
        int? isItem,
        dynamic dealType,
        String? fromDay,
        String? toDay,
        String? fromTime,
        String? toTime,
        String? createdAt,
        int? totalLike,
        int? totalComment,
        List<Like>? likes,
    }) => 
        Datum(
            id: id ?? this.id,
            venueName: venueName ?? this.venueName,
            cover: cover ?? this.cover,
            establishment: establishment ?? this.establishment,
            address: address ?? this.address,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            totalReviews: totalReviews ?? this.totalReviews,
            averageRating: averageRating ?? this.averageRating,
            category: category ?? this.category,
            isItem: isItem ?? this.isItem,
            dealType: dealType ?? this.dealType,
            fromDay: fromDay ?? this.fromDay,
            toDay: toDay ?? this.toDay,
            fromTime: fromTime ?? this.fromTime,
            toTime: toTime ?? this.toTime,
            createdAt: createdAt ?? this.createdAt,
            totalLike: totalLike ?? this.totalLike,
            totalComment: totalComment ?? this.totalComment,
            likes: likes ?? this.likes,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        venueName: json["venue_name"],
        cover: json["cover"],
        establishment: json["establishment"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        totalReviews: json["total_reviews"],
        averageRating: json["average_rating"]?.toDouble(),
        category: json["category"],
        isItem: json["is_item"],
        dealType: json["deal_type"],
        fromDay: json["from_day"],
        toDay: json["to_day"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        createdAt: json["created_at"],
        totalLike: json["total_like"],
        totalComment: json["total_comment"],
        likes: json["likes"] == null ? [] : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "venue_name": venueName,
        "cover": cover,
        "establishment": establishment,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "total_reviews": totalReviews,
        "average_rating": averageRating,
        "category": category,
        "is_item": isItem,
        "deal_type": dealType,
        "from_day": fromDay,
        "to_day": toDay,
        "from_time": fromTime,
        "to_time": toTime,
        "created_at": createdAt,
        "total_like": totalLike,
        "total_comment": totalComment,
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x.toJson())),
    };
}

class Like {
    String? userName;
    String? userAvatar;

    Like({
        this.userName,
        this.userAvatar,
    });

    Like copyWith({
        String? userName,
        String? userAvatar,
    }) => 
        Like(
            userName: userName ?? this.userName,
            userAvatar: userAvatar ?? this.userAvatar,
        );

    factory Like.fromRawJson(String str) => Like.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        userName: json["user_name"],
        userAvatar: json["user_avatar"],
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "user_avatar": userAvatar,
    };
}
